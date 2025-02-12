require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:valid_attributes) { { title: 'New Post', body: 'This is a new post', user_id: 1 } }
  let(:invalid_attributes) { { title: '', body: '', user_id: nil } }
  let(:post) { Post.create!(valid_attributes) }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end

    it 'returns paginated posts' do
      get :index, params: { page: 1, per_page: 10 }
      expect(JSON.parse(response.body).size).to be <= 10
    end
  end

  describe 'GET #show' do
    context 'when the post exists' do
      it 'returns a success response' do
        get :show, params: { id: post.to_param }
        expect(response).to be_successful
      end
    end

    context 'when the post does not exist' do
      it 'returns a not found response' do
        get :show, params: { id: 'nonexistent' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      let(:new_attributes) { { title: 'Updated Post', body: 'This is an updated post' } }

      it 'updates the requested post' do
        put :update, params: { id: post.to_param, post: new_attributes }
        post.reload
        expect(post.title).to eq('Updated Post')
        expect(post.body).to eq('This is an updated post')
      end

      it 'returns a success response' do
        put :update, params: { id: post.to_param, post: new_attributes }
        expect(response).to be_successful
      end
    end

    context 'when the post does not exist' do
      it 'returns a not found response' do
        put :update, params: { id: 'nonexistent', post: valid_attributes }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested post' do
      post
      expect {
        delete :destroy, params: { id: post.to_param }
      }.to change(Post, :count).by(-1)
    end

    it 'returns a success response' do
      delete :destroy, params: { id: post.to_param }
      expect(response).to be_successful
    end

    context 'when the post does not exist' do
      it 'returns a not found response' do
        delete :destroy, params: { id: 'nonexistent' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end