require "rails_helper"

RSpec.feature "Creating Articles" do

  before do
    @article1 = Article.new(title: "First test article", body: "Body of first test article")
    @article2 = Article.new(title: "Second test article", body: "Body of second test article")
  end

  scenario "A user list all Articles" do
    visit "/"
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.body)

    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

end
