class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = 'Your comment was added.'
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    if already_voted?
      flash[:notice] = "You have already voted on this"
    else
      Vote.create(voteable: @comment, user_id: current_user.id, vote: params[:vote])
      flash[:notice] = "Your vote was counted"
    end
    redirect_to :back
  end

end