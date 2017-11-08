json.array! @comments do |comment|
  json.content comment.content
  json.user_url account_user_path(comment.user)
  json.time_ago_in_words "created #{time_ago_in_words(comment.created_at)} ago"
  json.edit_url edit_account_post_comment_path(comment.commentable, comment)
  json.destroy_url account_post_comment_path(comment.commentable, comment)
  json.new_comment_url new_account_comment_comment_path(comment)
  json.comments comment.comments  do |comment|
    json.content comment.content
    json.user comment.user.username
    json.user_url account_user_path(comment.user)
    json.time_ago_in_words "created #{time_ago_in_words(comment.created_at)} ago"
    json.edit_url edit_account_comment_comment_path(comment.commentable, comment)
    json.destroy_url account_comment_comment_path(comment.commentable, comment)
  end
end