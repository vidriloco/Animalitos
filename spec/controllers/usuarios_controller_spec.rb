# encoding: utf-8
require 'spec_helper'

describe UsuariosController do
  
  describe "GET perfil" do
    
    before(:each) do
      @usuario = Factory(:usuario)
      @usuario.confirm! 
      sign_in(@usuario)
      @akita=Factory(:akita_con_foto, :usuario => @usuario)
      Factory(:pastor_con_foto)
    end
    
    it "asigna el usuario con sesión actual a @usuario" do
      get :perfil
      assigns(:usuario).should == @usuario
    end
    
    it "asigna el usuario con sesión actual a @usuario" do
      get :perfil
      assigns(:animales).should == [@akita]
    end
  end
  
end
