class Animal < ActiveRecord::Base
  has_many :fotos, :dependent => :destroy
  belongs_to :usuario
  belongs_to :geografia
  belongs_to :raza
  
  validates_presence_of :nombre, :raza_id, :descripcion, :geografia, :situacion
  validates_inclusion_of :en_casa, :in => [true, false]
  
  cattr_reader :per_page
  @@per_page = 9
  
  def self.todos
    { 1 => "Perro", 2 => "Gato" }
  end
  
  def self.situaciones
    { 1 => "Encontrado", 2 => "Desaparecido" }
  end
  
  def tipo_de_mascota
    Animal.todos[raza.tipo]
  end
  
  def en_casa_semantico
    return "casa" if en_casa
    "no_casa"
  end
  
  def en_casa_humanize
    return "En casa" if en_casa
    "Buscando casa"
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
end
