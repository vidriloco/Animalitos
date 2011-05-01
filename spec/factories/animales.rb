# encoding: utf-8
Factory.define :animal do |t|
  t.nombre "Capitán"
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

Factory.define :pastor_con_foto, :class => Animal do |t|
  t.nombre "Laika"
  t.raza { |raza| raza.association(:perro, :nombre => "Pastor Alemán") }
  t.descripcion "Es una perrita muy bonachona"
  t.estancia_temporal 2
  t.situacion 1
  t.coordenadas Point.from_lon_lat(19.323, 34.223, 4326)
  t.fotos { |fotos| [fotos.association(:foto_de_frente)] }
  
  t.after_build { |animal| animal.pon_foto_principal(animal.fotos.first) }
end

Factory.define :akita_con_foto, :class => Animal do |t|
  t.nombre "Mokita"
  t.raza { |raza| raza.association(:perro, :nombre => "Akita") }
  t.descripcion "Es una perrita muy bonachona"
  t.estancia_temporal 2
  t.situacion 2
  t.coordenadas Point.from_lon_lat(19.323, -99.223, 4326)
  t.fotos { |fotos| [fotos.association(:foto_de_akita)] }
  
  t.after_build { |animal| animal.pon_foto_principal(animal.fotos.first) }
end

Factory.define :cooker_con_foto, :class => Animal do |t|
  t.nombre "Dulcinea"
  t.raza { |raza| raza.association(:perro, :nombre => "Cooker") }
  t.descripcion "Es una perrita muy bonachona"
  t.estancia_temporal 2
  t.situacion 2
  t.coordenadas Point.from_lon_lat(19.323, -99.223, 4326)
  t.fotos { |fotos| [fotos.association(:foto_de_lanudo)] }
  
  t.after_build { |animal| animal.pon_foto_principal(animal.fotos.first) }
end