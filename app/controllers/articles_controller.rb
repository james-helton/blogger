class ArticlesController < ApplicationController
  before_action :require_login, except: [:show, :index]
  before_action :owner?, only: [:edit, :update, :destroy]
  include ArticlesHelper

  def index
    @articles = Article.all.reverse
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    flash.notice = "Article '#{@article.title}' Created!"
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash.notice = "Article '#{@article.title}' Deleted!"
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    flash.notice = "Article '#{@article.title}' Updated!"
    redirect_to article_path(@article)
  end

  private

    def owner?
      unless logged_in? && current_user == Article.find(params[:id]).author
        redirect_to article_path(params[:id])
        return false
      end
    end
end
