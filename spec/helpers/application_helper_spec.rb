#encoding: utf-8
require 'spec_helper'

describe ApplicationHelper do
  
  describe "habiendo sido registrados hace un mes" do
  
    it "debe desplegar un mensaje sobre un animalito encontrado y su geografia" do
      Delorean.time_travel_to("1 month ago") do
        @ani = Factory.build(:animal, :situacion => Animal.encontrado, :fecha => Time.now )
      end
      ubicacion_y_fecha_animalito(@ani).should == "Encontrado hace cerca de 1 mes"
    end
  
    it "debe desplegar un mensaje para un animalito extraviado y su geografia" do
      Delorean.time_travel_to("1 month ago") do
        @ani = Factory.build(:animal, :situacion => Animal.extraviado, :fecha => Time.now )
      end
      ubicacion_y_fecha_animalito(@ani).should == "Extraviado hace cerca de 1 mes"
    end
  
    it "debe desplegar un mensaje sobre una animalita encontrada y su geografia" do
      Delorean.time_travel_to("1 month ago") do  
        @ani = Factory.build(:animal, :situacion => Animal.encontrado, :sexo => "H", :fecha => Time.now )
       end
       ubicacion_y_fecha_animalito(@ani).should == "Encontrada hace cerca de 1 mes"
     end
  
    it "debe desplegar un mensaje para una animalita extraviada y su geografia" do
      Delorean.time_travel_to("1 month ago") do
        @ani = Factory.build(:animal, :situacion => Animal.extraviado, :sexo => "H", :fecha => Time.now )
      end
      ubicacion_y_fecha_animalito(@ani).should == "Extraviada hace cerca de 1 mes"
    end
  
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
