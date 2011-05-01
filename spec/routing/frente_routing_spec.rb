require "spec_helper"

describe FrenteController do
  describe "routing" do

    it "reconoce y direcciona #acerca_de" do
      { :get => "/acerca_de" }.should route_to(:controller => "frente", :action => "acerca_de")
    end
  end
end