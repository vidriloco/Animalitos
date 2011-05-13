# encoding: utf-8
class Animal < ActiveRecord::Base  
  has_many :fotos, :dependent => :destroy
  belongs_to :usuario
  belongs_to :raza
  
  validates_presence_of :nombre, :raza, :descripcion, :situacion, :sexo
  
  after_save :avisa_registrado, :on => :create
  before_save :verifica_consistencia_extraviado
  
  cattr_reader :per_page
  @@per_page = 9
  
  cattr_reader :encontrado
  @@encontrado = 1
  cattr_reader :extraviado
  @@extraviado = 2
  
  # @@DEPRECATED
  #def self.busqueda_paginada(params, pagina=1)
  #  condiciones = ["animales.nombre ILIKE ? AND situacion = ? AND razas.tipo = ?", params[:nombre], params[:situacion]]
  #  condiciones << params[:perro] ? 1 : 2
    
  #  Animal.paginate(:page => pagina, :conditions => condiciones, :include => :raza, :joins => :raza)
  #end
  
  def self.todos
    { 1 => "Perro", 2 => "Gato" }
  end
  
  def self.sexos 
    { "H" => "Hembra", "M" => "Macho" }
  end
  
  def self.situaciones
    { Animal.encontrado => "Encontré a un animalito en la calle", Animal.extraviado => "Mi mascota está perdida" }
  end
  
  def atributos_basicos
    res = {self.tipo_de_mascota.downcase => "1"}
    
    {"sexo" => self.sexo}.merge(res)
  end
  
  def aplica_geo(hash)
    self.coordenadas = Point.from_lon_lat(hash["lon"].to_f, hash["lat"].to_f, 4326)
    self
  end
  
  def situacion_humanize
    case self.situacion
      when Animal.encontrado then "Encontrado"
      when Animal.extraviado then "Extraviado"
    end
  end
  
  def self.estancias
    { 0 => 'No aplica', 1 => 'Albergue', 2 => 'Mí casa' }
  end
  
  def es_hembra?
    self.sexo == "H"
  end
  
  def estancia_humanize
    if self.situacion == Animal.extraviado
      return "Siendo #{self.es_hembra? ? "buscada" : "buscado"}" 
    end  
    case self.estancia_temporal
      when 1 then "En albergue"
      when 2 then "En casa temporal"
    end
  end
  
  def tipo_de_mascota
    Animal.todos[self.raza.tipo]
  end
  
  def foto_principal
    begin
      return Foto.find(foto_id) unless foto_id.nil?
    rescue  
      return nil 
    end
  end
  
  def pon_foto_principal(foto_id)
    self.foto_id = foto_id
  end
  
  def solo_hay_una_foto_y_es_principal?
    fotos.length == 1 && foto_id == fotos[0].id
  end
  
  def mensaje_tweet
    mascota = (tipo_de_mascota == "Perro") ? "Perrito" : "Gatito"
    situacion = self.situacion_humanize
    
    if self.es_hembra?
      mascota.gsub!('o', 'a')
      situacion = situacion.chop+"a"
    end
    cruza = self.cruza ? ' cruza' : ''
    
    "#{mascota} #{self.raza.nombre.downcase}#{cruza} #{situacion.downcase}."
  end
  
  def tiny_urled
    Net::HTTP.get_response(URI.parse("http://tinyurl.com/api-create.php?url=http://www.amigosenapuros.com/ayudame/#{self.id}")).body
  end
  
  def verifica_consistencia_extraviado
    self.estancia_temporal = 0 if self.situacion == Animal.extraviado
  end
  
  def avisa_registrado
    begin
      p "ANUNCIO ANUNCIO CAMBIO CAMBIO #{tiny_urled}"
      Twitter.update(mensaje_tweet + " Ayúdalo en #{tiny_urled}") if Rails.env=="production"
    rescue
      # doble tweet 
    end
  end
  
  def self.busqueda_valida?(hash)
    hash.has_key?(:ext) || !hash[:nombre].empty?
  end
  
  def self.busqueda_paginada(params, pagina=1)
    condiciones = [""]
    extra = {}
    
    unless params[:nombre].blank?
      condiciones[0] += "animales.nombre ILIKE ? AND "
      condiciones << params[:nombre]
    end
    
    if !params[:extraviado].blank? && !params[:adopcion].blank?
      condiciones[0] += "animales.situacion IN (1,2) AND "
    elsif !params[:extraviado].blank? || !params[:adopcion].blank?
      condiciones[0] += "animales.situacion = #{Animal.extraviado} AND " unless params[:extraviado].blank?
      condiciones[0] += "animales.situacion = #{Animal.encontrado} AND " unless params[:adopcion].blank?
    end
    
    unless params[:sexo].blank?
      condiciones[0] += "animales.sexo = ? AND "
      condiciones << params[:sexo]
    end
    
    unless params[:cruza].blank?
      condiciones[0] += "animales.cruza = 't' AND "
    #else
    #  condiciones[0] += "animales.cruza = 'f' AND "
    end
    
    unless params[:caso_cerrado].blank?
      condiciones[0] += "animales.caso_cerrado = 'f' AND "
    end
    
    unless params[:raza].blank?
      condiciones[0] += "razas.id = ? AND "
      condiciones << params[:raza]
      extra.merge!(:include => :raza, :joins => :raza)
    end
    
    # Eliminar última condición AND del query
    condiciones[0]=condiciones.first[0..-6]
    Animal.paginate(extra.merge(:page => pagina, :conditions => condiciones))
  end
end
