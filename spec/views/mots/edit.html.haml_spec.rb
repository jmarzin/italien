require 'spec_helper'

describe "mots/edit" do
  before(:each) do
    @mot = assign(:mot, stub_model(Mot,
      :mot_directeur => "MyString",
      :francais => "MyString",
      :italien => "MyString"
    ))
  end

  it "renders the edit mot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", mot_path(@mot), "post" do
      assert_select "input#mot_mot_directeur[name=?]", "mot[mot_directeur]"
      assert_select "input#mot_francais[name=?]", "mot[francais]"
      assert_select "input#mot_italien[name=?]", "mot[italien]"
    end
  end
end
