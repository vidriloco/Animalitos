require 'spec_helper'

describe "animales/show.html.erb" do
  before(:each) do
    @animal = assign(:animal, stub_model(Animal,
      :nombre => "Nombre",
      :raza_id => 1,
      :descripcion => "MyText",
      :usuario_id => 1,
      :geografia_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
