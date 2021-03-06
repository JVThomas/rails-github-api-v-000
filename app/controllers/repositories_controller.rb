class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers["Authorization"] = "token #{session[:token]}"
      req.headers["Accept"] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
    render :index
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos",
      {name: params[:name]}.to_json, {
      'Accept' => 'application/json',
      'Authorization' => "token #{session[:token]}"
    }
    render :index
  end
end
