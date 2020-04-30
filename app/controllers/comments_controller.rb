class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :get_post, only: [:destroy, :create]
    before_action :set_comment, only: [:destroy]
    before_action :authorize!, only: [:destroy]

    def create
        @comment = Comment.new comment_params
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
            flash[:notice] = 'Comment Created Successfully'
            redirect_to post_path(@post)
        else
            flash[:error] = 'Comment invalid. message is empty'
            redirect_to post_path(@post)
        end
    end

    def destroy
        @comment.destroy
        redirect_to post_path(@post.id)
    end


    private

    def get_post
        @post = Post.find(params[:post_id])
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:message, :post_id)
    end

    def authorize! 
        unless can?(:crud, @comment)
            redirect_to root_path, alert: 'Not Authorized' 
        end
    end
    
end