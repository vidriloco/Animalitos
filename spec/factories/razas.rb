# encoding: utf-8

Factory.define :raza do |r|
  r.nombre "Alguna raza"
  r.tipo 1
end

Factory.define :perro, :class => Raza do |r|
  r.nombre "Labrador"
  r.tipo 1
end

Factory.define :beagle, :class => Raza do |r|
  r.nombre "Beagle"
  r.tipo 1
end

Factory.define :gato, :class => Raza do |r|
  r.nombre "Balines"
  r.tipo 2
end