class SessionsController < ApplicationController
    # rescue_from ActiveRecord::RecordNotFound, with: :unauthorized

    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: "Invalid username or password" }, status: :unauthorized
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
    end

    private

    # def anauthorized
    #     render json: {error: "Invalid username or password" }, status: :unauthorized
    # end
end
