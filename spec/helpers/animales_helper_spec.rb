require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the AnimalesHelper. For example:
#
# describe AnimalesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe AnimalesHelper do
  it "debe desplegar un mensaje sobre un animalito encontrado y su geografia" do
    @ani = Factory.build(:animal, :situacion => 1, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Encontrado hace cerca de 1 mes"
  end
  
  it "debe desplegar un mensaje para un animalito extraviado y su geografia" do
    @ani = Factory.build(:animal, :situacion => 2, :fecha => Time.now.months_ago(1) )
    ubicacion_y_fecha_animalito(@ani).should == "Extraviado hace cerca de 1 mes"
  end
end
