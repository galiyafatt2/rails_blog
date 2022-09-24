class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to article_path(@article)
      end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.xml { render xml: @article.as_json }
      format.json
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
    respond_to do |format|
      format.xml { render xml: @articles.as_json }
      format.json
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = 'Article was deleted'
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
