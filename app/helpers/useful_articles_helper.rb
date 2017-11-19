module UsefulArticlesHelper
  def count_comments
    comment_count = @useful_article.comment_posts.count
    last_int = comment_count.to_s.chars.last(1).join.to_i
    if last_int == 1
      "#{comment_count} комментарий"
    elsif last_int >= 2 && last_int <= 4
      "#{comment_count} комментария"
    elsif last_int == 0
      'На данный момент отсутствуют комментарии для этого поста'
    else
      "#{comment_count} комментариев"
    end
  end
end
