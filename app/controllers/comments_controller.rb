class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @comments = policy_scope(Comments)
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    authorize @comment
    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:post_id])
    authorize @comment
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
