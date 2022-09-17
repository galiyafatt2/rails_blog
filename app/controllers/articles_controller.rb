# frozen_string_literal: true

class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = 'Article was updated'
      redirect_to article_path(@article)
    else
      flash[:notice] = 'Article was not updated'
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
    respond_to do |format|
      format.xml { render xml: @article.as_json }
      format.json
      format.html
      format.pdf do
        render pdf: 'pdf_file',
               template: "articles/showpdf",
               formats: [:html],
               layout: 'layouts/pdf'

      end
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def index
    @articles = Article.all
    respond_to do |format|
      format.xml {render xml: @articles.as_json}
      format.json
      format.html
      format.pdf do
        render pdf: 'pdf_file',
               template: "articles/indexpdf",
               formats: [:html],
               layout: 'layouts/pdf'
      end
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

