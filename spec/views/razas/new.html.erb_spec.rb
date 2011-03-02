require 'spec_helper'

describe "razas/new.html.erb" do
  before(:each) do
    assign(:raza, stub_model(Raza,
      :nombre => "MyString",
      :tipo => 1
    ).as_new_record)
  end

  it "renders new raza form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => razas_path, :method => "post" do
      assert_select "input#raza_nombre", :name => "raza[nombre]"
      assert_select "input#raza_tipo", :name => "raza[tipo]"
    end
  end
end
