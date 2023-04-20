# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_post_attributes) { attributes_for(:post) }

      before do
        sign_in create(:user)
        post :create, params: { post: valid_post_attributes }
      end

      it 'creates a new post' do
        expect(Post.count).to eq(1)
      end

      it 'redirects to the new post page' do
        expect(response).to redirect_to(new_post_path)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_post_attributes) { attributes_for(:post, title: '') }

      before do
        sign_in create(:user)
        post :create, params: { post: invalid_post_attributes }
      end

      it 'does not create a new post' do
        expect(Post.count).to eq(0)
      end

      it 'renders the new post page' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'renders the new post page' do
      expect(response).to render_template(:new)
    end

    it 'assigns a new post to @post' do
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe 'GET #show' do
    let(:post) { create(:post) }

    before { get :show, params: { id: post.id } }

    it 'renders the show post page' do
      expect(response).to render_template(:show)
    end

    it 'assigns the requested post to @post' do
      expect(assigns(:post)).to eq(post)
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post) }

    before do
      sign_in create(:user)
      delete :destroy, params: { id: post.id }
    end

    it 'deletes the post' do
      expect(Post.count).to eq(0)
    end

    it 'redirects to the admins index page' do
      expect(response).to redirect_to(admins_index_path)
    end
  end
end
