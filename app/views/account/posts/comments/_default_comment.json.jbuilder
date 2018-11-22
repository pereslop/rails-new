json.id comment.id
json.content comment.content
json.username comment.user.username
json.user_avatar_url comment.user.avatar.url
json.user_id comment.user.id
json.current_user_id current_user.id
json.user_url account_user_path(comment.user)
json.time_ago time_ago_in_words(comment.created_at)
