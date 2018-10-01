class ArticlesController < ApplicationController
	
	before_action :set_article, only: [:edit, :update, :show, :destroy] #only this 4 methods will call set_article

	def index
		@articles = Article.all #grab all the articles(plural for convenience)
	end 

	def new
		@article = Article.new
	end

	def create
		#render plain: params[:article].inspect #render plain text, params from view are passed as a params
		@article = Article.new(article_params)
		# @article.save
		# redirect_to article_path(@article)
		# the above code may fail to pass the validation and will cause the error
		if @article.save
			flash[:notice] = "Article was successfully created"
			redirect_to article_path(@article) # redirect to show (not index because sth is being passed)
		else
			render 'new' # render the new template again
		end

	end

	def show # show action needs id articles/11 for example
		#@article = Article.find(params[:id])
	end

	def destroy
		#@article = Article.find(params[:id])
		@article.destroy
		flash[:notice] = "Article was successfully destroyed"
		redirect_to articles_path
	end

	def edit
		#@article = Article.find(params[:id])
	end

	def update
		#@article = Article.find(params[:id])
		if @article.update(article_params) # if it was able to get updated params from the edit.html.erb
			flash[:notice] = "Article was successfully updated"
		redirect_to article_path(@article) # so the message from flash, will be printed only after redirecting to the show page, and only once
		else
			render 'edit'
		end
	end 


	private
		def set_article
			@article = Article.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:title, :description)
		end

end