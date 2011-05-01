# encoding: utf-8
class Animal < ActiveRecord::Base  
  has_many :fotos, :dependent => :destroy
  belongs_to :usuario
  belongs_to :raza
  
  validates_presence_of :nombre, :raza, :descripcion, :situacion
  
  after_save :avisa_registrado
  before_save :verifica_consistencia_extraviado
  
  cattr_reader :per_page
  @@per_page = 9
  
  cattr_reader :encontrado
  @@encontrado = 1
  cattr_reader :extraviado
  @@extraviado = 2
  
  
  def self.pagina_y_encuentra(params)
    conds = {:en_casa => false}
    included = {}
    
    if params.key?(:en_casa)
      conds[:en_casa] = params[:en_casa] == "1" ? true : false
    end
    
    if params.key?(:raza) && params[:raza] != "0"
      conds[:raza_id] = params[:raza] 
      included = {:include => :raza, :joins => :raza}
    end
    
    Animal.paginate(:all, {:conditions => conds, :page => params[:page]}.merge(included))
  end
  
  def self.busqueda_paginada(params, pagina=1)
    condiciones = ["animales.nombre ILIKE ? AND situacion = ? AND razas.tipo = ?", params[:nombre], params[:situacion]]
    condiciones << params[:perro] ? 1 : 2
    
    Animal.paginate(:page => pagina, :conditions => condiciones, :include => :raza, :joins => :raza)
  end
  
  def self.todos
    { 1 => "Perro", 2 => "Gato" }
  end
  
  def self.situaciones
    { Animal.encontrado => "Encontré a un animalito en la calle", Animal.extraviado => "Mi mascota está perdida" }
  end
  
  def self.busqueda_valida?(hash)
    !((hash.has_key?(:perro) && hash.has_key?(:gato) ) ||
      (!hash.has_key?(:perro) && !hash.has_key?(:gato)) || 
      hash[:nombre].empty?)
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
  
  def estancia_humanize
    return "Siendo buscado" if self.situacion == Animal.extraviado
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
    "#{mascota} #{self.raza.nombre.downcase} #{self.situacion_humanize.downcase}."
  end
  
  def tiny_urled
    Net::HTTP.get_response(URI.parse("http://tinyurl.com/api-create.php?url=http://www.amigosenapuros/ayudame/#{self.id}")).body
  end
  
  def verifica_consistencia_extraviado
    self.estancia_temporal = 0 if self.situacion == Animal.extraviado
  end
  
  def avisa_registrado
    begin
      Twitter.update(mensaje_tweet + " Ayudalo en #{tiny_urled}") if Rails.env!="test"
    rescue
      # doble tweet 
    end
  end
end
