# encoding: utf-8
Factory.define :animal do |t|
  t.nombre "Capitan"
  t.raza { |raza| raza.association(:perro) }
  t.descripcion "Perrito blanco eléctrico"
  t.en_casa true
  t.situacion "1"
  t.geografia_id "1"
end