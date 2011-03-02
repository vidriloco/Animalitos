require 'spec_helper'

describe "razas/index.html.erb" do
  before(:each) do
    assign(:razas, [
      stub_model(Raza,
        :nombre => "Nombre",
        :tipo => 1
      ),
      stub_model(Raza,
        :nombre => "Nombre",
        :tipo => 1
      )
    ])
  end

  it "renders a list of razas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nombre".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
