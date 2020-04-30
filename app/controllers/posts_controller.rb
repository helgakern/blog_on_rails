class PostsController < ApplicationController
    # before_action :authenticate_user!, except: [:index, :show]
    # before_action :load_post!, except: [:create]
    # before_action :authorize_user!, only: [:edit, :update, :destroy]

    def new
    end

    def create
        @post = Post.new post_params
        @post.user = @current_user
        if @post.save
            render(plain: "Created Post #{@post.inspect}")
        else
            render :new
        end
    end

    def show
        @comments = Comment.new
    end

    def index
        @posts = Post.all.order('created_at DESC')
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    def edit
        @post = Post.find params[:id]
    end

    def update
        if @post.update post_params
            redirect_to posts_path @post
        else
            render :edit
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def authorize_user!
        unless can? :crud, @post
            flash[:danger] = "Access Denied"
            redirect_to root_path
        end
    end

    def load_post!
        if params[:id].present?
            @post = Post.find(params[:id])
        else
            @post = Post.new
        end
    end
end
