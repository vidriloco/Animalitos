require "spec_helper"

describe Devise::SessionsController do
  describe "routing" do

    it "reconoce y genera #new" do
      { :get => "/usuarios/iniciar_sesion" }.should route_to(:controller => "devise/sessions", :action => "new")
    end
    
  end
end