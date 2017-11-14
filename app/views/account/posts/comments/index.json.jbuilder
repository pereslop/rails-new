json.array! @comments do |comment|
  json.partial! 'account/posts/comments/parent_comment', locals: { comment: comment}
  json.comments comment.comments  do |comment|
    json.partial! 'account/comments/nested_comment', locals: { comment: comment}
  end
end