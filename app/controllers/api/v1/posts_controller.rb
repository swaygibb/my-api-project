module Api
  module V1
    class PostsController < ApplicationController
      # GET /posts
      # Fetches all posts and renders them as JSON with pagination
      def index
        posts = Post.recent.page(params[:page] || 1).per(params[:per_page] || 10)
        render json: posts
      end

      # GET /posts/:id
      # Fetches a single post by ID and renders it as JSON
      # If the post is not found, returns a 404 status with an error message
      def show
        post = Post.find_by(id: params[:id])
        if post
          render json: post
        else
          render json: { error: "Post not found" }, status: :not_found
        end
      end

      # POST /posts
      # Creates a new post with the provided parameters
      # If the post is successfully created, returns the post with a 201 status
      # If there are validation errors, returns a 422 status with the error messages
      def create
        post = Post.new(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PUT /posts/:id
      # Updates an existing post with the provided parameters
      # If the post is successfully updated, returns the updated post
      # If there are validation errors, returns a 422 status with the error messages
      # If the post is not found, returns a 404 status with an error message
      def update
        post = Post.find_by(id: params[:id])
        if post
          if post.update(post_params)
            render json: post
          else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: "Post not found" }, status: :not_found
        end
      end

      # DELETE /posts/:id
      # Deletes an existing post by ID
      # If the post is successfully deleted, returns a 200 status with a success message
      # If the post is not found, returns a 404 status with an error message
      def destroy
        post = Post.find_by(id: params[:id])
        if post
          post.destroy
          render json: { message: "Post deleted" }, status: :ok
        else
          render json: { error: "Post not found" }, status: :not_found
        end
      end

      private

      # Strong parameters for post creation and update
      # Permits only the title, body, and user_id attributes
      def post_params
        params.require(:post).permit(:title, :body, :user_id)
      end
    end
  end
end
