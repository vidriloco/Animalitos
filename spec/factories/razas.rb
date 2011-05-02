# encoding: utf-8

Factory.define :raza do |r|
  r.nombre "Alguna raza"
  r.tipo 1
end

Factory.define :pastor, :class => Raza do |r|
  r.nombre "Pastor Alemán"
  r.tipo 1
end

Factory.define :labrador, :class => Raza do |r|
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

Factory.define :akita, :class => Raza do |r|
  r.nombre "Akita"
  r.tipo 1
end

Factory.define :cooker, :class => Raza do |r|
  r.nombre "Cooker"
  r.tipo 1
end