# encoding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe AnimalesController do    

  describe "GET busqueda" do
    
    before(:each) do
      @animal = Factory.stub(:animal, :nombre => 'Lanudo', :situacion => Animal.extraviado)
      @params = {"nombre" => 'Lanudo', "raza" => @animal.raza.tipo, "extraviado" => "on"}
    end
    
    it "busca perros y los asigna a @animales con paginacion" do
      Animal.should_receive(:busqueda_paginada).with(@params, 1) { [@animal] }
      
      post :busqueda, :busqueda => {:nombre => 'Lanudo', :raza => @animal.raza.tipo, :extraviado => "on"}, :page => 1
      assigns(:animales).should == [@animal]
    end
    
    it "busca perros y los asigna a @animales desde busqueda" do
      Animal.should_receive(:busqueda_paginada).with(@params, nil) { [@animal] }
      
      post :busqueda, :busqueda => {:nombre => 'Lanudo', :raza => @animal.raza.tipo, :extraviado => "on"}
      assigns(:animales).should == [@animal]
    end
    
    it "asigna los parametros de busqueda a @parametros" do
      post :busqueda, :busqueda => @params
      assigns(:parametros).should == {"nombre" => 'Lanudo', "raza" => @animal.raza.tipo, "extraviado" => "on"}
    end
    
    it "vuelve a desplegar pagina principal si parametros de busqueda están vacíos" do
      post :busqueda, :busqueda => {:nombre => '', :situacion => Animal.extraviado}
      response.should redirect_to(root_path)
    end
    
    it "despliega el template index si la busqueda es extendida" do
      post :busqueda, :busqueda => @params.merge(:ext => 1)
      response.should render_template("index")
    end
    
    it "despliega el template index" do
      Animal.stub(:busqueda_paginada) { [@animal] }
      
      post :busqueda, :busqueda => {:nombre => 'Lanudo', :perro => 1, :situacion => Animal.extraviado}
      response.should render_template("index")
    end
  end
  
  describe "GET index" do
    before(:each) do
      @animal = Factory.stub(:animal, :nombre => 'Lanudo', :situacion => Animal.extraviado)
      @params = {"nombre" => 'Lanudo', "raza" => 3, "extraviado" => "on", "sexo" => "H"}
    end
    
    it "busca perros y los asigna a @animales con paginacion" do
      Animal.should_receive(:paginate).with(:page => 1) { [@animal] }
      
      get :index, :page => 1
      assigns(:animales).should == [@animal]
    end
    
    it "despliega el template index" do
      Animal.stub(:paginate) { [@animal] }
      
      get :index
      response.should render_template("index")
    end
  end
  

  describe "GET show" do
    
    before(:each) do
      @animal = Factory.stub(:animal)
    end
    
    it "asigna el animal buscado a @animal" do
      Animal.stub(:find).with("37", {:include => :fotos}) { @animal }
      get :show, :id => "37"
      assigns(:animal).should be(@animal)
    end
  end

  describe "POST create" do
    
    before(:each) do
      @animal = Factory.stub(:animal)
      usuario = Factory(:usuario)
      #usuario.confirm! 
      sign_in(usuario)
    end
    
    describe "con parámetros válidos" do
      
      before(:each) do
        @animal.stub(:save).and_return(true)
      end
      
      it "asigna un nuevo animal a @animal" do
        Animal.stub(:new).with('correct' => 'params') { @animal }
        
        @animal.should_receive(:aplica_geo).with({"lat" => "19.45", "lon" => "-99.23"})
        post :create, :animal => {'correct' => 'params'}, :coordenadas => {:lat => "19.45", :lon => "-99.23"}
        assigns(:animal).should be(@animal)
      end

      it "redirecciona al recién creado animal" do
        Animal.stub(:new) { @animal }
        @animal.stub(:aplica_geo)
        
        post :create, :animal => {}, :coordenadas => {}
        response.should redirect_to(animal_url(@animal))
      end
    end

    describe "with invalid params" do
      
      before(:each) do
        @animal.stub(:save).and_return(false)
      end
      
      it "assigns a newly created but unsaved animal as @animal" do
        Animal.stub(:new).with('bad' => 'params') { @animal }
        post :create, :animal => {'bad' => 'params'}, :coordenadas => {}
        assigns(:animal).should be(@animal)
      end

      it "re-renders the 'new' template" do
        Animal.stub(:new) { @animal }
        post :create, :animal => {}, :coordenadas => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT edo_caso_cambio" do
    
    before(:each) do
      @animal = Factory(:animal)
      usuario = Factory(:usuario)
      #usuario.confirm! 
      sign_in(usuario)
    end
    
    it "cambia el estado del caso" do
      Animal.stub(:find).with("43") { @animal }
      
      @animal.should_receive(:update_attribute).with(:caso_cerrado, "true")
      put :edo_caso_cambio, :id => "43", :animal => {:caso_cerrado => "true"}
      
      assigns(:animal).should be(@animal)
    end
    
    it "redespliega el template actual" do
      Animal.stub(:find) { @animal }
      put :edo_caso_cambio, :id => "43", :animal => {}
      
      response.should redirect_to(animal_url(@animal))
    end
  end
end
