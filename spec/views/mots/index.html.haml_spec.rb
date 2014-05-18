require 'spec_helper'

describe "mots/index" do
  before(:each) do
    assign(:mots, [
      stub_model(Mot,
        :mot_directeur => "Mot Directeur",
        :francais => "Francais",
        :italien => "Italien"
      ),
      stub_model(Mot,
        :mot_directeur => "Mot Directeur",
        :francais => "Francais",
        :italien => "Italien"
      )
    ])
  end

  it "renders a list of mots" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Mot Directeur".to_s, :count => 2
    assert_select "tr>td", :text => "Francais".to_s, :count => 2
    assert_select "tr>td", :text => "Italien".to_s, :count => 2
  end
end
