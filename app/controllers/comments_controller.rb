class CommentsController < ApplicationController
  def buyer_sure
    comment = Comment.find(params[:id])
    if comment.post.user == current_user
      comment.buyer_sure = true
      comment.save
      redirect_to post_path(comment.post)
    end
  end

  def employer_sure
    comment = Comment.find(params[:id])
    if comment.user == current_user
      comment.employer_sure = true
      comment.save
      redirect_to post_path(comment.post)
    end
  end

  def verify_code
    code = params[:code]
    comment = Comment.find(params[:id])
    if current_user == comment.user
      if comment.code == nil or comment.code != code
        flash[:notice] = "ur code can't match!"
        redirect_to post_path(comment.post)
      elsif comment.code == code
        comment.verified = true
        comment.save
        flash[:notice] = "ok!"
        redirect_to post_path(comment.post)
      end
    else
    flash[:notice] = "who's ur daddy?"
    redirect_to post_path(comment.post)
    end
  end
end
