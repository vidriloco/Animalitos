class Raza < ActiveRecord::Base
  has_many :animales, :dependent => :destroy

  validates_presence_of :tipo, :nombre
  
  
  def self.agrupadas
    razas_agrupadas = {"Perro" => [], "Gato" => []}
    Raza.all.each do |r|
      razas_agrupadas[Animal.todos[r.tipo]] << [r.nombre, "#{r.id}"]
    end
    razas_agrupadas
  end
end
