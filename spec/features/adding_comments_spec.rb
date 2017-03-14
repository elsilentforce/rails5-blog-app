require "rails_helper"

RSpec.feature "Adding comments to Articles" do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    @fred = User.create!(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: "First test article", body: "Body of first test article", user: @john)
  end

  scenario "permits signed in user to create a comment" do
    login_as(@fred)
    visit "/"
    click_link(@article.title)
    fill_in "New comment", with: "An awesome Article."
    click_button "Add comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An awesome Article.")
    expect(current_path).to eq( article_path(@article) )
  end

end
