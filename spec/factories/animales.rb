# encoding: utf-8
Factory.define :animal do |t|
  t.nombre "Capitan"
  t.raza { |raza| raza.association(:perro) }
  t.descripcion "Perrito blanco eléctrico"
  t.estancia_temporal 2
  t.situacion 2
  t.coordenadas Point.from_lon_lat(19.323, 34.223, 4326)
end

Factory.define :animal_sin_coords, :class => Animal do |t|
  t.nombre "Capitan"
  t.raza { |raza| raza.association(:perro) }
  t.descripcion "Perrito blanco eléctrico"
  t.estancia_temporal 2
  t.situacion 2
end