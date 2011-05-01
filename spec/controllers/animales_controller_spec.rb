# encoding: utf-8
require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe AnimalesController do    

  describe "GET busqueda" do
    
    before(:each) do
      @animal = Factory.stub(:animal, :nombre => 'Lanudo', :situacion => Animal.extraviado)
    end
    
    it "busca perros y los asigna a @animales con paginacion" do
      Animal.should_receive(:busqueda_paginada).with({"nombre" => 'Lanudo', "perro" => 1, "situacion" => Animal.extraviado}, 1) { [@animal] }
      
      post :busqueda, :busqueda => {:nombre => 'Lanudo', :perro => 1, :situacion => Animal.extraviado}, :page => 1
      assigns(:animales).should == [@animal]
    end
    
    it "busca perros y los asigna a @animales desde busqueda" do
      Animal.should_receive(:busqueda_paginada).with({"nombre" => 'Lanudo', "perro" => 1, "situacion" => Animal.extraviado}, nil) { [@animal] }
      
      post :busqueda, :busqueda => {:nombre => 'Lanudo', :perro => 1, :situacion => Animal.extraviado}
      assigns(:animales).should == [@animal]
    end
    
    it "asigna los parametros de busqueda a @parametros" do
      post :busqueda, :busqueda => {:nombre => 'Lanudo', :perro => 1, :situacion => Animal.extraviado}
      assigns(:parametros).should == {"nombre" => 'Lanudo', "perro" => 1, "situacion" => Animal.extraviado}
    end
    
    it "vuelve a desplegar pagina principal si parametros de busqueda están vacíos" do
      post :busqueda, :busqueda => {:nombre => '', :situacion => Animal.extraviado}
      response.should redirect_to(root_path)
    end
    
    it "despliega el template index" do
      Animal.stub(:busqueda_paginada) { [@animal] }
      
      post :busqueda, :busqueda => {:nombre => 'Lanudo', :perro => 1, :situacion => Animal.extraviado}
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
      usuario.confirm! 
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

end
