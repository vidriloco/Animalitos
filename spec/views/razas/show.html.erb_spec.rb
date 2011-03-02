require 'spec_helper'

describe "razas/show.html.erb" do
  before(:each) do
    @raza = assign(:raza, stub_model(Raza,
      :nombre => "Nombre",
      :tipo => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nombre/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
