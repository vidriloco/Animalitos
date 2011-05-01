#encoding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  it "debe desplegar un mensaje sobre un animalito encontrado y su geografia" do
    @ani = Factory.build(:animal, :situacion => Animal.encontrado, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Encontrado hace cerca de 1 mes"
  end
  
  it "debe desplegar un mensaje para un animalito extraviado y su geografia" do
    @ani = Factory.build(:animal, :situacion => Animal.extraviado, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Extraviado hace cerca de 1 mes"
  end
end
