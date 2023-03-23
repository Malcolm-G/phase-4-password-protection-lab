class UsersController < ApplicationController

    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user
        else
            render json:{message:'Somethingwent wrong'}, status:422
        end
    end

    def show
        if session[:user_id]
            user = User.find(session[:user_id])
            render json: user
        else
            render json:{message:'please login'}, status: :unauthorized
        end
    end

    private
    def user_params
        params.permit(:username, :password, :password_confirmation)
    end
end
