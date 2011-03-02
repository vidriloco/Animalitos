require "spec_helper"

describe RazasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/razas" }.should route_to(:controller => "razas", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/razas/new" }.should route_to(:controller => "razas", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/razas/1" }.should route_to(:controller => "razas", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/razas/1/edit" }.should route_to(:controller => "razas", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/razas" }.should route_to(:controller => "razas", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/razas/1" }.should route_to(:controller => "razas", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/razas/1" }.should route_to(:controller => "razas", :action => "destroy", :id => "1")
    end

  end
end
