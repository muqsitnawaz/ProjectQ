class ArticleRequestArticleNotif
  @queue = :article_request_article_notifs_queue
  
  def self.perform(article_request_id, current_user_id)
    article_request = ArticleRequest.find_by_id(article_request_id)
    
    if !article_request.nil?
      user_id = article_request.user_id
      
      # Saving notification
      notif1 = Notification.new({
        :user_id => user_id,
        :poster_id => current_user_id,
        :resource_type => "Article",
        :notification_type => 1,
        :resource_id => article_request.id
      })
      notif1.save
      
      # Making indicator
      user = User.find_by_id(user_id)
      user.read = false
      user.save
    end
  end
end