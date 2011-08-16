# coding: utf-8
class NoticesController < ApplicationController
  layout :nil
  def index
  end

  def error
  end

  def error_404
    render :text => "error: 404, 你懂的"
  end
end
