require "rails_helper"

RSpec.feature "Creating Articles" do

  scenario "A User creates an Article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "New Blog Article"
    fill_in "Body", with: "Lorem ipsum"

    click_button "Create Article"

    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
  end

end
