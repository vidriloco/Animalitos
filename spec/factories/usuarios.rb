# encoding: utf-8

Factory.define :usuario do |u|
  u.nombre "Tester"
  u.es_admin true
  u.password "prueba"
  u.password_confirmation "prueba"
  u.email "amigosenapuros@gmail.com"
end
