require 'spec_helper'

describe FrenteController do
  describe "GET index" do
    
    before(:each) do
      @encontrados = [Factory.stub(:animal)]
      @extraviados = []
      @mascotas = @encontrados
    end
    
    it "asigna el animal buscado a @animal" do
      Animal.should_receive(:count).with(:conditions => {:situacion => Animal.encontrado}) { @encontrados }
      Animal.should_receive(:count).with(:conditions => {:situacion => Animal.extraviado}) { @extraviados }

      Animal.should_receive(:all).with(:order => "animales.id DESC", :conditions => "foto_id IS NOT NULL", :include => :fotos, :limit => 5) { @mascotas }

      get :index
      assigns(:mascotas).should == @mascotas
      assigns(:encontrados).should == @encontrados
      assigns(:extraviados).should == @extraviados
    end
  end
end
