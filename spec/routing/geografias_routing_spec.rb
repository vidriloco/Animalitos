require "spec_helper"

describe GeografiasController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/geografias" }.should route_to(:controller => "geografias", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/geografias/new" }.should route_to(:controller => "geografias", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/geografias/1" }.should route_to(:controller => "geografias", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/geografias/1/edit" }.should route_to(:controller => "geografias", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/geografias" }.should route_to(:controller => "geografias", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/geografias/1" }.should route_to(:controller => "geografias", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/geografias/1" }.should route_to(:controller => "geografias", :action => "destroy", :id => "1")
    end

  end
end
