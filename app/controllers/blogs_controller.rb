class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy, :change_blog_status]
  access all: [:show, :index], user: {except: [:destroy]}, site_admin: :all
  before_action :require_same_user, only: [:edit, :update, :destroy, :change_blog_status]


  def index
    if logged_in?(:user)
      @blogs = Blog.paginate(page: params[:page], per_page: 5)
    else
      @blogs = Blog.published.paginate(page: params[:page], per_page: 5)
    end
  end

  def show

  end

  def new
    @blog = Blog.new
  end

  def edit
  end

  def create
    if logged_in?(:user)
      @blog = Blog.new(blog_params)
      @blog.user = current_user
      if @blog.save
        notice = 'Blog was successfully created.'
        redirect_to @blog, notice: notice
      else
        render :new 
      end
    else
      notice = 'Only registered users can write a post'
      redirect_to new_user_registration_path, notice: notice
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

    def require_same_user
      if current_user != @blog.user
        notice = "You can only edit or delete your own blog posts!"
        redirect_to root_path, notice: notice
      end
    end

end
