class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_post, only: [:edit,:update,:show,:destroy]
    before_action :authorize!, only: [:edit,:update,:destroy]

    def index
        @posts = Post.all.order('created_at DESC')
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new post_params
        @post.user = current_user
        if @post.save
            flash[:notice] = 'Post Created Successfully'
            redirect_to posts_path(@post.id)
        else
            if @post.title == "" || !@post.title
                flash[:error] = 'Post invalid. Please put a title'
            elsif @post.body == "" || !@post.body
                flash[:error] = 'Post invalid. the text box is empty'
            else
                flash[:error] = 'something wrong noooo!'
            end
            render :new
        end
    end

    def update
        if @post.update post_params
            flash[:notice] = 'post updated Successfully'
            redirect_to post_path(@post.id)
        else
            if @post.title == "" || !@post.title
                flash[:error] = 'Update invalid. Please put a title'
            elsif @post.body == "" || !@post.body
                flash[:error] = 'Update invalid. the text box is empty'
            end
            render :edit
        end
    end

    def show
        @comments = @post.comments.order('created_at DESC')
        @comment = @post.comments.build
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end


    private

    def find_post
        @post=Post.find params[:id]
    end
    def post_params
        params.require(:post).permit(:title, :body)
    end

    def authorize! 
        unless can?(:crud, @post)
            redirect_to root_path, alert: 'Not Authorized' 
        end
    end
end