#encoding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  it "debe desplegar un mensaje sobre un animalito encontrado y su geografia" do
    @ani = Factory.build(:animal, :situacion => Animal.encontrado, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Encontrado hace 30 días"
  end
  
  it "debe desplegar un mensaje para un animalito extraviado y su geografia" do
    @ani = Factory.build(:animal, :situacion => Animal.extraviado, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Extraviado hace 30 días"
  end
  
  it "debe desplegar un mensaje sobre una animalita encontrada y su geografia" do
     @ani = Factory.build(:animal, :situacion => Animal.encontrado, :sexo => "H", :fecha => Time.now.months_ago(1) )
     ubicacion_y_fecha_animalito(@ani).should == "Encontrada hace 30 días"
   end
  
  it "debe desplegar un mensaje para una animalita extraviada y su geografia" do
    @ani = Factory.build(:animal, :situacion => Animal.extraviado, :sexo => "H", :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Extraviada hace 30 días"
  end
  
  it "debe desplegar un mensaje para casos cerrados" do
    @ani = Factory.build(:animal, :caso_cerrado => true)
    estado_del_caso(@ani).should == "Caso cerrado"
  end
  
  it "debe desplegar un mensaje para casos abiertos" do
    @ani = Factory.build(:animal)
    estado_del_caso(@ani).should == "Caso no resuelto aún"
  end
end
