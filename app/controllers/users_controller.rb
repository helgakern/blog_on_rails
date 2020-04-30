class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update, :destroy, :edit_password, :update_password]
    before_action :authorize!, only: [:edit,:update,:destroy]

    def new
        @user = User.new
    end

    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            render :new
            flash[:alert] = "You must sign up first"
        end
    end

    def edit
    end

    def update
        if @user.update edit_params
            flash[:notice] = "User info updated"
            redirect_to root_path 
        else 
            flash[:alert] = "Couldn't update"
            render :edit
        end
    end

    def edit_password
    end

    def update_password
        if @user&.authenticate params[:user][:current_password]
            pass1 = params[:user][:new_password]
            pass2 = params[:user][:new_password_confirmation]
            pass_different = pass1 != params[:user][:current_password]
            pass_confirmed = pass1 == pass2
            if pass_different && pass_confirmed
                if @user.update password: pass1, password_confirmation: pass2
                    flash[:notice] = "Password changed"
                    redirect_to root_path
                else 
                    flash[:alert] = "Couldn't update"
                    render :edit_password
                end
            else
                flash[:alert] = "Your new password confirmation does not match"
                render :edit_password
            end
        else
            flash[:alert] = "Your current password does not match"
            render :edit_password
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :name, :email, :password, :password_confirmation
        )
    end

    def find_user
        @user = User.find params[:id]
    end

    def edit_params
        params.require(:user).permit(:name, :email)
    end

    def authorize! 
        unless can?(:crud, @user)
            redirect_to root_path, alert: 'Not authorized' 
        end
    end

end