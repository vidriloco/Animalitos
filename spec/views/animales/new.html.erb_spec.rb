require 'spec_helper'

describe "animales/new.html.erb" do
  before(:each) do
    assign(:animal, stub_model(Animal,
      :nombre => "MyString",
      :raza_id => 1,
      :descripcion => "MyText",
      :usuario_id => 1,
      :geografia_id => 1
    ).as_new_record)
  end

  it "renders new animal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => animales_path, :method => "post" do
      assert_select "input#animal_nombre", :name => "animal[nombre]"
      assert_select "input#animal_raza_id", :name => "animal[raza_id]"
      assert_select "textarea#animal_descripcion", :name => "animal[descripcion]"
      assert_select "input#animal_usuario_id", :name => "animal[usuario_id]"
      assert_select "input#animal_geografia_id", :name => "animal[geografia_id]"
    end
  end
end
