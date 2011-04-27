# encoding: utf-8
require 'spec_helper'

describe Animal do
  
  before(:each) do
    @animal = Factory.build(:animal, :raza => Factory.build(:raza, :nombre => "Labrador", :tipo => 1))
  end
  
  it "debe generar el mensaje para twitter correcto" do
    @animal.mensaje_tweet.should == "Perrito labrador encontrado."
  end
  
  it "debe avisar en twitter" do
    @animal.should_receive(:avisa_registrado)
    @animal.run_callbacks(:save)
  end
  
  it "debe desplegar Está extraviado según el valor de su estancia temporal" do
    perdido=Factory.build(:animal, :estancia_temporal => 0)
    perdido.estancia_humanize.should == "Está extraviado"
  end
  
  it "debe desplegar En albergue según el valor de su estancia temporal" do
    perdido=Factory.build(:animal, :estancia_temporal => 1)
    perdido.estancia_humanize.should == "En albergue"
  end
  
  it "debe desplegar En casa temporal según el valor de su estancia temporal" do
    perdido=Factory.build(:animal, :estancia_temporal => 2)
    perdido.estancia_humanize.should == "En casa temporal"
  end
  
  it "debo poder cambiar las coordenadas de un animal" do
    @animal.aplica_geo({"lat" => "19.4", "lon" => "-99.15"})
    @animal.coordenadas.lat.should == 19.4
    @animal.coordenadas.lon.should == -99.15
  end
end
