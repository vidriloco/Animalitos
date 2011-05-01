#encoding: utf-8
require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AnimalesHelper. For example:
#
# describe AnimalesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AnimalesHelper do
  it "devuelve nil cuando no hay nada acerca de la busqueda" do
    despliega_resultado_de_busqueda(nil).should == nil
  end
  
  it "despliega un mensaje acerca de la busqueda" do
    perro = "Resultados de perritos extraviados con nombre <span class='extraviado-nombre'>Lanudo</span>"
    gato = "Resultados de gatitos extraviados con nombre <span class='extraviado-nombre'>Lanudo</span>"
    
    despliega_resultado_de_busqueda({"nombre"=>"Lanudo", "perro"=>1, "situacion"=>Animal.extraviado}).should == perro
    despliega_resultado_de_busqueda({"nombre"=>"Lanudo", "gato"=>1, "situacion"=>Animal.extraviado}).should == gato
  end
  
  it "despliega la situacion de una mascota" do
    situacion(Animal.extraviado, :p).should == " extraviados"
    situacion(Animal.encontrado, :p).should == " encontrados"
    situacion(Animal.extraviado, :s).should == " extraviado"
    situacion(Animal.encontrado, :s).should == " encontrado"
  end
  
  it "despliega el tipo de mascota" do
    mascota_tipo({"gato" => 1, "nombre" => "Lencho"}, :p).should == "gatitos"
    mascota_tipo({"perro" => 1, "nombre" => "Lencho"}, :p).should == "perritos"
    mascota_tipo({"gato" => 1, "nombre" => "Lencho"}, :s).should == "gatito"
    mascota_tipo({"perro" => 1, "nombre" => "Lencho"}, :s).should == "perrito"
    mascota_tipo({"gato" => 1, "nombre" => "Lencho", "sexo" => "M"}, :s).should == "gatito"
    mascota_tipo({"perro" => 1, "nombre" => "Dulce Poli", "sexo" => "H"}, :s).should == "perrita"
    mascota_tipo({"gato" => 1, "nombre" => "Lencho", "sexo" => "M"}, :p).should == "gatitos"
    mascota_tipo({"perro" => 1, "nombre" => "Dulce Poli", "sexo" => "H"}, :p).should == "perritas"
  end
  
  it "devuelve el numero de mascotas encontradas" do
    situacion_numeros(0, Animal.encontrado).should == "No hay ninguna mascota en adopción o encontrada"
    situacion_numeros(1, Animal.encontrado).should == "1 en adopción o encontrada"
    situacion_numeros(2, Animal.encontrado).should == "2 en adopción o encontradas"
  end
  
  it "devuelve el numero de mascotas extraviadas" do
    situacion_numeros(0, Animal.extraviado).should == "Sin reportes de mascotas extraviadas"
    situacion_numeros(1, Animal.extraviado).should == "1 reportada como extraviada"
    situacion_numeros(2, Animal.extraviado).should == "2 reportadas como extraviadas"
  end
end
