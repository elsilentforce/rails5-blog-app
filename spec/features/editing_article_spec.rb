require "rails_helper"

RSpec.feature "Editing Article:" do
  before do
    john = User.create!(email: 'john@example.com', password: 'password')
    login_as(john)
    @article = Article.create(title: "First test article", body: "Body of first test article", user: john)
  end

  scenario "A user updates an article" do
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated Body of Article"
    click_button "Update Article"

    expect(page).to have_content("Article has been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

  scenario "A fails to update an article" do
    visit "/"
    click_link @article.title
    click_link "Edit Article"
    fill_in "Title", with: ""
    fill_in "Body", with: "Updated Body of Article"
    click_button "Update Article"

    expect(page).to have_content("Article has not been updated")
    expect(page.current_path).to eq(article_path(@article))
  end

end
