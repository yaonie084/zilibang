# coding: utf-8

module HomeHelper
  def join_skills(post)
    post.skills.map { |t| t.name }.join (", ")
  end

  def how_long_over?(post)
    result = ""
    delta = post.created_at + post.longtime*24*60*60 - Time.now
    delta = delta.to_i
    if delta <= 0
      "结束了！"
    else
      if delta > 24*60*60
        buffer = delta/(24*60*60)
        result += "#{buffer}天"
        delta -= buffer*24*60*60
      end

      if delta > 60*60
        buffer = delta/(60*60)
        result += "#{buffer}小时"
        delta -= buffer*60*60
      end

      if delta > 60
        buffer = delta/60
        result += "#{buffer}分"
        delta -= buffer*60
      end

      result += "#{delta}秒"

      result
    end
  end
end
