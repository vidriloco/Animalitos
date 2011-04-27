# encoding: utf-8
class Animal < ActiveRecord::Base  
  has_many :fotos, :dependent => :destroy
  belongs_to :usuario
  belongs_to :raza
  
  validates_presence_of :nombre, :raza_id, :descripcion, :situacion
  
  after_save :avisa_registrado
  
  cattr_reader :per_page
  @@per_page = 9
  
  
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
  
  def aplica_geo(hash)
    self.coordenadas = Point.from_lon_lat(hash["lon"].to_f, hash["lat"].to_f, 4326)
    self
  end
  
  def self.todos
    { 1 => "Perro", 2 => "Gato" }
  end
  
  def self.situaciones
    { 1 => "Encontré a un animalito en la calle", 2 => "Mi mascota está perdida" }
  end
  
  def situacion_humanize
    case self.situacion
      when 1 then "Encontrado"
      when 2 then "Extraviado"
    end
  end
  
  def self.estancias
    { 0 => 'No aplica', 1 => 'Albergue', 2 => 'Mí casa' }
  end
  
  def estancia_humanize
    case self.estancia_temporal
      when 0 then "Está extraviado"
      when 1 then "En albergue"
      when 2 then "En casa temporal"
    end
  end
  
  def tipo_de_mascota
    Animal.todos[self.raza.tipo]
  end
  
  def tipo_de_mascota_diminutivo
    tipo_de_mascota == "Perro" ? "Perrito" : "Gatito"
  end
  
  def en_casa_semantico
    return "casa" if en_casa
    "no_casa"
  end
  
  def en_casa_humanize
    return "En casa" if en_casa
    "En albergue temporal"
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
    "#{self.tipo_de_mascota_diminutivo} #{self.raza.nombre.downcase} #{self.situacion_humanize.downcase}."
  end
  
  def tiny_urled
    Net::HTTP.get_response(URI.parse("http://tinyurl.com/api-create.php?url=http://www.amigosenapuros/ayudame/#{self.id}")).body
  end
  
  def avisa_registrado
    begin
      Twitter.update(mensaje_tweet + " Ayudalo en #{tiny_urled}") if Rails.env!="test"
    rescue
      # doble tweet 
    end
  end
end
