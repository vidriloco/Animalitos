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
  it "debe desplegar un mensaje sobre un animalito encontrado y su geografia" do
    @ani = Factory.build(:animal, :situacion => 1, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Encontrado hace cerca de 1 mes"
  end
  
  it "debe desplegar un mensaje para un animalito extraviado y su geografia" do
    @ani = Factory.build(:animal, :situacion => 2, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Extraviado hace cerca de 1 mes"
  end
  
  it "devuelve nil cuando no hay nada acerca de la busqueda" do
    despliega_resultado_de_busqueda(nil).should == nil
  end
  
  it "despliega un mensaje acerca de la busqueda" do
    perro = "Resultados de perritos extraviados con nombre <span class='extraviado-nombre'>Lanudo</span>"
    gato = "Resultados de gatitos extraviados con nombre <span class='extraviado-nombre'>Lanudo</span>"
    
    despliega_resultado_de_busqueda({"nombre"=>"Lanudo", "perro"=>1, "situacion"=>2}).should == perro
    despliega_resultado_de_busqueda({"nombre"=>"Lanudo", "gato"=>1, "situacion"=>2}).should == gato
  end
  
  it "despliega la situacion de una mascota" do
    situacion(2, :p).should == " extraviados"
    situacion(1, :p).should == " encontrados"
    situacion(2, :s).should == " extraviado"
    situacion(1, :s).should == " encontrado"
  end
  
  it "despliega el tipo de mascota" do
    mascota_tipo({"gato" => 1, "nombre" => "Lencho"}, :p).should == "gatitos"
    mascota_tipo({"perro" => 1, "nombre" => "Lencho"}, :p).should == "perritos"
    mascota_tipo({"gato" => 1, "nombre" => "Lencho"}, :s).should == "gatito"
    mascota_tipo({"perro" => 1, "nombre" => "Lencho"}, :s).should == "perrito"
  end
end
