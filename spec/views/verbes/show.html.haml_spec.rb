require 'spec_helper'

describe "verbes/show" do
  before(:each) do
    @verbe = assign(:verbe, stub_model(Verbe,
      :infinitif => "Infinitif"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Infinitif/)
  end
end
