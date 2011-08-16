# coding: utf-8
class NoticesController < ApplicationController
  layout :nil
  def index
    render :text => "验证成功"
  end

  def error
    render :text => "验证失败！！！"
  end

end
