require "rails_helper"

RSpec.feature "Deleting an Article:" do
  before do
    @article = Article.create(title: "First test article", body: "Body of first test article")
  end

  scenario "A User deletes an article" do
    visit "/"
    click_link @article.title
    click_link "Delete Article"
    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
