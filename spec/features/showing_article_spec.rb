require "rails_helper"

RSpec.feature "Showing Article" do

  before do
    @john = User.create!(email: 'john@example.com', password: 'password')
    @fred = User.create!(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: "First test article", body: "Body of first test article", user: @john)
  end

  scenario "to a non signed user hides Edit/Delete Buttons" do
    visit "/"
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_content("Edit Article")
    expect(page).not_to have_content("Delete Article")
    expect(current_path).to eq(article_path(@article))
  end

  scenario "to a signed user that's not the owner of Article hides Edit/Delete Buttons" do
    login_as(@fred)
    visit "/"
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).not_to have_content("Edit Article")
    expect(page).not_to have_content("Delete Article")
    expect(current_path).to eq(article_path(@article))
  end

  scenario "to a signed user that's the owner of Article shows Edit/Delete Buttons" do
    login_as(@john)
    visit "/"
    click_link @article.title
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(page).to have_content("Edit Article")
    expect(page).to have_content("Delete Article")
    expect(current_path).to eq(article_path(@article))
  end

end
