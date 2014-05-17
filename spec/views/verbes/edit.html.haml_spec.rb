require 'spec_helper'

describe "verbes/edit" do
  before(:each) do
    @verbe = assign(:verbe, stub_model(Verbe,
      :infinitif => "MyString"
    ))
  end

  it "renders the edit verbe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", verbe_path(@verbe), "post" do
      assert_select "input#verbe_infinitif[name=?]", "verbe[infinitif]"
    end
  end
end
