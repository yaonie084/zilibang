# coding: utf-8
module PostsHelper
  def comfortable?(level)
    result = case
    when level == 2
      "好评"
    when level == 1
      "中评"
    when level == -1
      "差评"
    end
  end
end
