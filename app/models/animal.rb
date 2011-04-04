# encoding: utf-8
class Animal < ActiveRecord::Base
  has_many :fotos, :dependent => :destroy
  belongs_to :usuario
  belongs_to :geografia
  belongs_to :raza
  
  validates_presence_of :nombre, :raza_id, :descripcion, :geografia, :situacion
  validates_inclusion_of :en_casa, :in => [true, false]
  
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
  
  def self.todos
    { 1 => "Perro", 2 => "Gato" }
  end
  
  def self.situaciones
    { 1 => "Buscando a su familia", 2 => "Su familia lo está buscando" }
  end
  
  def self.situaciones_twitter
    { 1 => "encontrado", 2 => "extraviado" }
  end
  
  def tipo_de_mascota
    Animal.todos[raza.tipo]
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
    "#{self.tipo_de_mascota_diminutivo} #{self.raza.nombre.downcase} #{Animal.situaciones_twitter[self.situacion]}. Ayudalo en http://www.amigosenapuros/ayudame/#{self.id}"
  end
  
  def avisa_registrado
    Twitter.update(mensaje_tweet)
  end
end
