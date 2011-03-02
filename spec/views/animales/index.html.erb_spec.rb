require 'spec_helper'

describe "animales/index.html.erb" do
  before(:each) do
    assign(:animales, [
      stub_model(Animal,
        :nombre => "Nombre",
        :raza_id => 1,
        :descripcion => "MyText",
        :usuario_id => 1,
        :geografia_id => 1
      ),
      stub_model(Animal,
        :nombre => "Nombre",
        :raza_id => 1,
        :descripcion => "MyText",
        :usuario_id => 1,
        :geografia_id => 1
      )
    ])
  end

  it "renders a list of animales" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
