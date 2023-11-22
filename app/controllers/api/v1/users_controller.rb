class Api::V1::UsersController < ApplicationController
  def create
    puts "ログ！！Received request with params: #{params.inspect}"
    user = User.find_or_create_by(provider: params[:provider], uid: params[:uid], name: params[:name], email: params[:email])
    if user
      head :ok
    else
      render json: { error: "ログインに失敗しました" }, status: :unprocessable_entity
    end
  rescue StandardError => e
    puts "ログ！！Error in UsersController#create: #{e.message}"
    render json: { error: e.message }, status: :internal_server_error
  end
end
