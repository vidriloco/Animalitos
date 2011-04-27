# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
begin # perros
  Raza.create!(:tipo => 1, :nombre => "Pastor Alemán")
  Raza.create!(:tipo => 1, :nombre => "Pastor Inglés")
  Raza.create!(:tipo => 1, :nombre => "Beagle")
  Raza.create!(:tipo => 1, :nombre => "Labrador")
  Raza.create!(:tipo => 1, :nombre => "Golden Retriever")
  Raza.create!(:tipo => 1, :nombre => "French Poodle")
  Raza.create!(:tipo => 1, :nombre => "Akita")
  Raza.create!(:tipo => 1, :nombre => "Pug")
  Raza.create!(:tipo => 1, :nombre => "Pit Bull")
  Raza.create!(:tipo => 1, :nombre => "Bulldog")
  Raza.create!(:tipo => 1, :nombre => "Husky Siberiano")
  Raza.create!(:tipo => 1, :nombre => "Doberman")
  Raza.create!(:tipo => 1, :nombre => "Rottweiler")
rescue
  p "Hubo errores en el proceso de inserción de datos de Raza (perros)"
end

begin # gatos
  Raza.create!(:tipo => 2, :nombre => "Abisinio")
  Raza.create!(:tipo => 2, :nombre => "Angora turco")
  Raza.create!(:tipo => 2, :nombre => "Asiático Humo Atigrado")
  Raza.create!(:tipo => 2, :nombre => "Azul Ruso")
  Raza.create!(:tipo => 2, :nombre => "Balines")
  Raza.create!(:tipo => 2, :nombre => "Bengal")
  Raza.create!(:tipo => 2, :nombre => "Bombay")
  Raza.create!(:tipo => 2, :nombre => "Bobtail Japonés")
  Raza.create!(:tipo => 2, :nombre => "Brasileño Pelo Corto")
  Raza.create!(:tipo => 2, :nombre => "Británico")
  Raza.create!(:tipo => 2, :nombre => "Cornish Rex")
  Raza.create!(:tipo => 2, :nombre => "Curl Americano")
  Raza.create!(:tipo => 2, :nombre => "Chartreux")
rescue
  p "Hubo errores en el proceso de inserción de datos de Raza (gatos)"
end

u=Usuario.create!(:nombre => "Administrador", :es_admin => true, :password => "katwijk", :password_confirmation => "katwijk", :email => "vidriloco@gmail.com")
u.confirm!






