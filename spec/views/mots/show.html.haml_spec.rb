require 'spec_helper'

describe "mots/show" do
  before(:each) do
    @mot = assign(:mot, stub_model(Mot,
      :mot_directeur => "Mot Directeur",
      :francais => "Francais",
      :italien => "Italien"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Mot Directeur/)
    rendered.should match(/Francais/)
    rendered.should match(/Italien/)
  end
end
