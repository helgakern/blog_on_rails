class PostsController < ApplicationController

    def new
        @post = Post.new
    end

    def create
        post_params = param.require(:post).permit(:title, :body)
        @post = Post.new post_params
        if @post.save
            redirect_to @post
        else
            render :new
        end
    end

    def show
        @post = Post.find params[:id]
    end

    def index
        @posts = Post.order(created_at: :DESC)
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
end
