require "rails_helper"

RSpec.describe "Articles", type: :request do
  before do
    @john = User.create(email: 'john@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create!(title: 'Article one title', body: 'Article one body', user: @john)
  end

  # Delete Article requests
  describe 'DELETE /articles/:id' do

    context 'with non signed in user' do
      before { delete "/articles/#{@article.id}" }
      it "redirects to Article path" do
        expect(response.status).to eq 302
        flash_message = 'You can not delete the Article.'
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user that is not the Article owner' do
      before do
        login_as(@fred)
        delete "/articles/#{@article.id}"
      end
      it 'redirects to Article path' do
        expect(response.status).to eq 302
        flash_message = "You can not delete the Article."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in as the Article owner' do
      before do
        login_as(@john)
        delete "/articles/#{@article.id}"
      end
      it "deletes the article" do
        expect(response.status).to eq 302
        flash_message = "Article has been deleted"
        expect(flash[:success]).to eq flash_message
      end
    end

  end

  # Edit article requests
  describe 'GET /articles/:id/edit' do

    context 'with non signed in user' do
      before { get  "/articles/#{@article.id}/edit"}
      it "redirects to sign in page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in before continue."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with signed in user that is not the owner' do
      before do
        login_as(@fred)
        get "/articles/#{@article.id}/edit"
      end

      it "redirects to home page" do
        expect(response.status).to eq 200
        flash_message = "Only the owner can edit the Article."
        expect(flash[:alert]).to eq flash_message
      end

    end
  end

  # Show article requests
  describe 'GET /articles/:id' do

    context 'with existing article' do
      before { get "/articles/#{@article.id}" }
      it "handles existing article" do
        expect(response.status).to eq 200
      end
    end

    context 'with no-existing article' do
      before { get '/articles/xxx' }
      it 'handles non-existing article' do
        expect(response.status).to eq 302
        flash_message = "The article you are looking for could not be found"
        expect(flash[:danger]).to eq flash_message
      end
    end

  end
end
