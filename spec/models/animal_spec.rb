require 'spec_helper'

describe Animal do
  
  before(:each) do
    @animal = Factory.build(:animal, :raza => Factory.build(:raza, :nombre => "Labrador", :tipo => 1))
  end
  
  it "debe generar el mensaje para twitter correcto" do
    @animal.mensaje_tweet.should == "Perrito labrador encontrado."
  end
  
  it "debe avisar en twitter" do
    @animal.should_receive(:avisa_registrado)
    @animal.run_callbacks(:save)
  end
  
end
