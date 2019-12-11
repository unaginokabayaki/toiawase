class IssueCommentsController < ApplicationController
  before_action :selected_comment, only: %i[edit update destroy]

  def index

  end

  def new
  end

  def create
    @comment = IssueComment.new(comments_param)
    if @comment.save
      # redirect_to :back, success: "登録しました"
      # redirect_to edit_issue_path(comment.issue)
    else
      redirect_to :back, flush: { issue_comment: comment, alert: comment.errors.full_messages }
    end
  end

  def edit
    @cancel_button = true
  end

  def update
    if @comment.update(comments_param)
      # redirect_to :back, success: "登録しました"
    else
      redirect_to :back, flush: { issue_comment: comment, alert: comment.errors.full_messages }
    end
  end

  def destroy
    if @comment.destroy
      # redirect_to :back, success: "削除しました"
    end
  end

  def toggle_like
    @comment = IssueComment.find(params[:issue_comment][:id])
    # @comment = params[:issue_comment]
    like = IssueCommentLike.find_by(user_id: @current_user.id, issue_comment_id: @comment.id)
    if like
      like.destroy
    else
      IssueCommentLike.create(user_id: @current_user.id, issue_comment_id: @comment.id)
    end
  end

  private

  def comments_param
    params.require(:issue_comment).permit(:issue_id, :comment, :user_id)
  end

  def selected_comment
    @comment = IssueComment.find(params[:id])
  end
end
