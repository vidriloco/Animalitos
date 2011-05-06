# encoding: utf-8
require 'spec_helper'

describe Animal do
  
  before(:each) do
    @animal = Factory(:animal, :sexo => "M", :nombre => "Lanudo")
  end
  
  it "debe generar el mensaje para twitter correcto si no es cruza y es macho" do
    @animal.situacion=2
    @animal.mensaje_tweet.should == "Perrito beagle extraviado."
    @animal.situacion=1
    @animal.mensaje_tweet.should == "Perrito beagle encontrado."
  end
  
  it "debe generar el mensaje para twitter correcto si es una cruza" do
    animal = Factory.build(:animal, :sexo => "H", :cruza => true)
    animal.mensaje_tweet.should == "Perrita beagle cruza extraviada."    
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
    Animal.busqueda_paginada({:nombre => "Lanudo", :situacion => 2, :perro => 1}).should == [@animal]
  end
  
  it "devuelve las mascotas que cumplen con los parametros de busqueda" do
    Animal.busqueda_paginada({:nombre => "Lanudo", :situacion => 2, :perro => 1}, 1).should == [@animal]
  end
  
  it "guarda un nuevo animal con estancia temporal cero si su situacion es extraviado" do
    @animal.situacion = 2
    @animal.estancia_temporal = 1
    @animal.save
    @animal.estancia_temporal.should == 0
  end
  
  it "verifica los parámetros de la búsqueda" do
    Animal.busqueda_valida?({:nombre => '', :situacion => Animal.extraviado}).should be_false
    Animal.busqueda_valida?({:nombre => '', :situacion => Animal.extraviado, :raza => 2}).should be_false
    Animal.busqueda_valida?({:nombre => 'Alguien', :situacion => Animal.extraviado, :raza => 2}).should be_true
    Animal.busqueda_valida?({:ext => 1}).should be_true
  end
  
  it "devuelve los atributos básicos en un hash" do
    @animal.atributos_basicos.should == {"sexo" => "M", "perro" => "1"}
  end
  
  describe "habiendo un animal adicional" do
  
    before(:each) do
      @gato=Factory(:animal_gato, :nombre => "Lanudo", :caso_cerrado => true)
    end
  
    it "devuelve las mascotas que cumplen con tener un nombre dado y ser cruza" do
      Animal.busqueda_paginada({:nombre => "Lanudo"}).should == [@animal, @gato]
    end
  
    it "devuelve las mascotas que cumplen con estar extraviadas dado" do
      Animal.busqueda_paginada({:extraviado => "on"}).should == [@animal]
    end
    
    it "devuelve las mascotas que cumplen con ser machos cruza y aquellas que son hembras" do
      Animal.busqueda_paginada({:sexo => "M", :cruza => "on"}).should == [@gato]
      Animal.busqueda_paginada({:sexo => "H"}).should == []
    end
    
    it "devuelve las mascotas que cumplen con ser una cruza" do
      Animal.busqueda_paginada({:cruza => "on"}).should == [@gato]
    end
    
    it "devuelve las mascotas cuyos casos esten concluidos" do
      Animal.busqueda_paginada({:caso_cerrado => "on"}).should == [@animal]
    end
  
    it "devuelve las mascotas que tienen una raza específica" do
      Animal.busqueda_paginada({:raza => @animal.raza.tipo}).should == [@animal]
      Animal.busqueda_paginada({:raza => @gato.raza.tipo, :cruza => "on"}).should == [@gato]
    end
  
    it "devuelve las mascotas que tienen un nombre, están extraviados y se conoce su raza" do
      Animal.busqueda_paginada({:nombre => "Lanudo", 
                                          :extraviado => "on", 
                                          :raza => @animal.raza.id}).should == [@animal]
    end
    
    it "devuelve las mascotas que tienen un nombre, están en adopción y se conoce su raza" do
      Animal.busqueda_paginada({:nombre => "Lanudo", 
                                          :adopcion => "on", 
                                          :raza => @gato.raza.id}).should == [@gato]
    end
  end
end
