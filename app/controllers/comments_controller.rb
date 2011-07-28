class CommentsController < ApplicationController
  def buyer_sure
    comment = Comment.find(params[:id])
    if comment.post.user == current_user
      comment.buyer_sure = true
      comment.save
      redirect_to post_path(comment.post)
    end
  end

  def buyer_cancel
    comment = Comment.find(params[:id])
    if comment.post.user == current_user
      comment.buyer_sure = false
      comment.employer_sure = false
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

  def employer_cancel
    comment = Comment.find(params[:id])
    if comment.user == current_user
      comment.employer_sure = false
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

  def report_buyer
    comment = Comment.find(params[:id])
    comment.buyer_content = params[:content]
    comment.buyer_level = params[:level]
    comment.save
    flash[:notice] = "report success"
    redirect_to post_path(comment.post)
  end

  def report_employer
    comment = Comment.find(params[:id])
    comment.employer_content = params[:content]
    comment.employer_level = params[:level]
    comment.save
    flash[:notice] = "report success"
    redirect_to post_path(comment.post)
  end
end
