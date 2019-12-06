module IssueCommentsHelper

  def issue_comment_image_url(user)
    if user.image? 
      return user.image.url
    end
      return "default_avatar.png"
    else
  end

end
