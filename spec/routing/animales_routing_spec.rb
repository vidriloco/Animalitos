require "spec_helper"

describe AnimalesController do
  describe "routing" do

    it "redirecciona #ayudame a #show" do
      { :get => "/ayudame/1" }.should route_to(:controller => "animales", :action => "show", :id => "1")
    end
    
    it "reconoce y genera #busqueda" do
      { :get => "/busqueda" }.should route_to(:controller => "animales", :action => "busqueda")
    end

    it "recognizes and generates #index" do
      { :get => "/animales" }.should route_to(:controller => "animales", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/animales/new" }.should route_to(:controller => "animales", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/animales/1" }.should route_to(:controller => "animales", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/animales/1/edit" }.should route_to(:controller => "animales", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/animales" }.should route_to(:controller => "animales", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/animales/1" }.should route_to(:controller => "animales", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/animales/1" }.should route_to(:controller => "animales", :action => "destroy", :id => "1")
    end
  
  end
end
