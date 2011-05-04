require "spec_helper"

describe UsuariosController do
  describe "routing" do
    it "reconoce y genera #edit" do
      { :get => "/usuarios/1/edit" }.should route_to(:controller => "usuarios", :action => "edit", :id => "1")
    end
    
    it "reconoce y genera #update" do
      { :put => "/usuarios/1" }.should route_to(:controller => "usuarios", :action => "update", :id => "1")
    end
  end
end