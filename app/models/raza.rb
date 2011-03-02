class Raza < ActiveRecord::Base
  has_many :animales, :dependent => :destroy
  
  validates_uniqueness_of :nombre
  validates_presence_of :tipo
  
  
  def self.agrupadas
    razas_agrupadas = {"Perro" => [], "Gato" => []}
    Raza.all.each do |r|
      razas_agrupadas[Animal.todos[r.tipo]] << [r.nombre, "#{r.id}"]
    end
    razas_agrupadas
  end
end
