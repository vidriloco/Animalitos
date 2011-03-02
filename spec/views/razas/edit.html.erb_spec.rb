require 'spec_helper'

describe "razas/edit.html.erb" do
  before(:each) do
    @raza = assign(:raza, stub_model(Raza,
      :nombre => "MyString",
      :tipo => 1
    ))
  end

  it "renders the edit raza form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => razas_path(@raza), :method => "post" do
      assert_select "input#raza_nombre", :name => "raza[nombre]"
      assert_select "input#raza_tipo", :name => "raza[tipo]"
    end
  end
end
