require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the RazasHelper. For example:
#
# describe FotosHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe FotosHelper do

  it "debe decidir que akita tiene asignada una foto principal si la tiene" do
    akita=Factory.build(:akita_con_foto)
    akita.foto_id = akita.fotos.first.id
    es_foto_principal_de?(akita, akita.foto_principal).should == true
  end
  
  it "debe decidir que akita no tiene asignada una foto principal si no la tiene" do
    akita=Factory.build(:akita_con_foto)
    es_foto_principal_de?(akita, akita.fotos.first).should == false
  end

end