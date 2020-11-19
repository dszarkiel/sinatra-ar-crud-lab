
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    @article = Article.new
    erb :new
  end

  #show
  get '/articles/:id' do
    @article = Article.find(params[:id])
     
    erb :show
  end

  #create
  post '/articles' do
    article = Article.create(params)

    redirect "/articles/#{article.id}"
  end

  #edit
  get '/articles/:id/edit' do  #load edit form
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

patch '/articles/:id' do #edit action
  @article = Article.find_by_id(params[:id])
  @article.title = params[:title]
  @article.content = params[:content]
  @article.save
  redirect to "/articles/#{@article.id}"
end 

  #destroy
  delete "/articles/:id" do
    @article = Article.find_by_id(params[:id])
    @article.delete
    redirect to '/articles'
  end 
  
end
