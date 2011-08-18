# coding: utf-8
class CommentsController < ApplicationController
  def buyer_sure
    comment = Comment.find(params[:id])
    if comment.post.user == current_user
      comment.buyer_sure = true
      comment.save
      Message.create(:sender => User.find(1),:receiver => comment.user,:content =>"企业确定，请确认:#{comment.post.title}#{post_path(comment)}")
      
      redirect_to post_path(comment.post)
    end
  end

  def buyer_cancel
    comment = Comment.find(params[:id])
    if comment.post.user == current_user
      comment.buyer_sure = false
      comment.employer_sure = false
      comment.save
      Message.create(:sender => User.find(1),:receiver => comment.user,:content =>"企业取消任务")
      redirect_to post_path(comment.post)
    end
  end

  def employer_sure
    comment = Comment.find(params[:id])
    if comment.user == current_user
      comment.employer_sure = true
      comment.save
      Message.create(:sender => User.find(1),:receiver => comment.post.user,:content =>"用户已确定")
      redirect_to post_path(comment.post)
    end
  end

  def employer_cancel
    comment = Comment.find(params[:id])
    if comment.user == current_user
      comment.employer_sure = false
      comment.save
      Message.create(:sender => User.find(1),:receiver => comment.post.user,:content =>"用户已取消")

      redirect_to post_path(comment.post)
    end
  end

  def verify_code

    code = params[:code]
    comment = Comment.find(params[:id])
    if current_user == comment.user
      if comment.code == nil or comment.code != code
        flash[:notice] = "输入错误1"
        redirect_to post_path(comment.post)
      elsif comment.code == code and simple_captcha_valid?
        comment.verified = true
        user = comment.user
        comment.post.skill_list.each do |tag|
          puts "#{tag}--\n"
          user.add_score!(1, tag)
        end
        comment.save
        Message.create(:sender => User.find(1), :receiver => comment.user, :content => "验证成功")
        
        flash[:notice] = "ok!"
        redirect_to post_path(comment.post)
      else
        flash[:notice] = "输入错误2"
        redirect_to post_path(comment.post)
      end
    else
      flash[:notice] = "who's ur daddy?"
      redirect_to post_path(comment.post)
    end
  end

  def report_buyer
    level = case
    when params[:level] == "好评"
      2
    when params[:level] == "中评"
      1
    when params[:level] == "差评"
      -1
    end
    comment = Comment.find(params[:id])
    comment.buyer_content = params[:content]
    comment.buyer_level = level
    comment.save
    Message.create(:sender => User.find(1),:receiver => comment.post.user,:content =>"用户已评价")
    user = comment.user
    #    comment.post.skill_list.each do |tag|
    #      puts "#{tag}--\n"
    #      user.add_score!(level, tag)
    #    end
    user.goodwill += level
    user.save
    flash[:notice] = "report success"
    redirect_to post_path(comment.post)
  end

  def report_employer
    level = case
    when params[:level] == "好评"
      2
    when params[:level] == "中评"
      1
    when params[:level] == "差评"
      -1
    end
    comment = Comment.find(params[:id])
    comment.employer_content = params[:content]
    comment.employer_level = level
    comment.save
    Message.create(:sender => User.find(1),:receiver => comment.user,:content =>"企业已评价")
    user = comment.post.user
    #    comment.post.skill_list.each do |tag|
    #      user.add_score!(level, tag)
    #    end
    user.goodwill += level
    user.save
    flash[:notice] = "report success"
    redirect_to post_path(comment.post)
  end




end
