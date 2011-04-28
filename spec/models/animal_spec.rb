# encoding: utf-8
require 'spec_helper'

describe Animal do
  
  before(:each) do
    @animal = Factory(:animal)
  end
  
  it "debe generar el mensaje para twitter correcto" do
    @animal.situacion=2
    @animal.mensaje_tweet.should == "Perrito labrador extraviado."
    @animal.situacion=1
    @animal.mensaje_tweet.should == "Perrito labrador encontrado."
  end
  
  it "debe avisar en twitter" do
    @animal.should_receive(:avisa_registrado)
    @animal.run_callbacks(:save)
  end
  
  it "debe desplegar Está extraviado según el valor de su estancia temporal" do
    @animal.estancia_temporal = 0
    @animal.estancia_humanize.should == "Siendo buscado"
  end
  
  it "debe desplegar En albergue según el valor de su estancia temporal" do
    @animal.estancia_temporal = 1
    @animal.situacion=1
    @animal.estancia_humanize.should == "En albergue"
  end
  
  it "debe desplegar En casa temporal según el valor de su estancia temporal" do
    @animal.estancia_temporal = 2
    @animal.situacion=1
    @animal.estancia_humanize.should == "En casa temporal"
  end
  
  it "debo poder cambiar las coordenadas de un animal" do
    @animal.aplica_geo({"lat" => "19.4", "lon" => "-99.15"})
    @animal.coordenadas.lat.should == 19.4
    @animal.coordenadas.lon.should == -99.15
  end
  
  it "devuelve las mascotas que cumplen con los parametros de busqueda" do
    Animal.busqueda_paginada({:nombre => "Capitán", :situacion => 2, :perro => 1}).should == [@animal]
  end
  
  it "devuelve las mascotas que cumplen con los parametros de busqueda" do
    Animal.busqueda_paginada({:nombre => "Capitán", :situacion => 2, :perro => 1}, 1).should == [@animal]
  end
  
  it "guarda un nuevo animal con estancia temporal cero si su situacion es extraviado" do
    @animal.situacion = 2
    @animal.estancia_temporal = 1
    @animal.save
    @animal.estancia_temporal.should == 0
  end
end
