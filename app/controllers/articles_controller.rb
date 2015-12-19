class ArticlesController < ApplicationController
    def index 
        @articles = Article.paginate(page: params[:page])
        @article = @articles.first
        @feature = @articles.find_by(id: 2)
        @popular = @articles.find_by(id: 3)
    end

    def show
        @article = Article.find(params[:id])
    end

    def create 
        @article = current_user.articles.build(article_params)
        if @article.save
            flash[:success] = "Article created!"
            redirect_to root_url
        else
            render '/'
        end
    end

    def new
        @article = current_user.articles.build if logged_in?
    end

    def edit 
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        if @article.update_attributes(article_params)
            flash[:success] = "Article updated"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
    end

    private

    def article_params
        params.require(:article).permit(:title, :content, :picture)
    end
end
