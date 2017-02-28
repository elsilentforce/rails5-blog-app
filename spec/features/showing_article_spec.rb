require "rails_helper"

RSpec.feature "Showing Article:" do

  before do
    john = User.create!(email: 'john@example.com', password: 'password')
    @article = Article.create(title: "First test article", body: "Body of first test article", user: john)
  end

  scenario "A User display a single Article" do
    visit "/"
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end

end
