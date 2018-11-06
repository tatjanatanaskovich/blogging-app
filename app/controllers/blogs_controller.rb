class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :change_blog_status]

  def index
    @blogs = Blog.all
  end

  def show
  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user = current_user
    if @blog.save
      notice = 'Blog was successfully created.'
      redirect_to @blog, notice: notice
    else
      render :new 
    end
  end

  def update
    if @blog.update(blog_params)
      notice = 'Blog was successfully updated.'
      redirect_to @blog, notice: notice
    else
      render :edit 
    end
  end

  def destroy
    @blog.destroy
    notice = 'Blog was successfully destroyed.'
    redirect_to blogs_url, notice: notice
  end

  def change_blog_status
    if @blog.draft?
      @blog.published!
      elsif @blog.published?
        @blog.draft!
    end
    notice = 'Post status has been updated.'
    redirect_to blogs_url, notice: notice
  end

  private

    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def blog_params
      params.require(:blog).permit(:title, :body, :status, :user_id)
    end
end
