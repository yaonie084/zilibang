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
    level = params[:level]
    comment = Comment.find(params[:id])
    comment.buyer_content = params[:content]
    comment.buyer_level = params[:level]
    comment.save
    user = comment.post.user
    comment.post.skill_list.each do |tag|
      add_score!(user, level, tag)
    end
    flash[:notice] = "report success"
    redirect_to post_path(comment.post)
  end

  def report_employer
    level = params[:level]
    comment = Comment.find(params[:id])
    comment.employer_content = params[:content]
    comment.employer_level = level
    comment.save
    user = comment.user
    comment.post.skill_list.each do |tag|
      add_score!(user, level, tag)
    end
    flash[:notice] = "report success"
    redirect_to post_path(comment.post)
  end



  def add_score!(user, level, tag)
    tag_id = Tag.find_by_name(tag).id
    if have_not?(user, tag)
      user.skill_list << tag
      user.save
    end
    tagging = Tagging.where("taggable_id = #{comment.user_id} AND tag_id = #{tag_id} AND taggable_type = \"User\"").first
    tagging.score += level.to_i*5
    tagging.save
  end

  def have_not?(user, tag)
    return false if user.skill_list.include?(tag)
    true
  end
end
