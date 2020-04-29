class PostsController < ApplicationController

    def new
        @post = Post.new
    end

    def create
        post_params = param.require(:post).permit(:title, :body)
        @post = Post.new post_params
        if @post.save
            render plain: 'Post Created'
        else
            render :new
        end
    end
end
