class ArticlesController < ApplicationController
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
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Article was successfully updated"
		redirect_to article_path(@article) # so the message from flash, will be printed only after redirecting to the show page, and only once
		else
			render 'edit'
		end
	end 


	private

		def article_params
			params.require(:article).permit(:title, :description)
		end

end