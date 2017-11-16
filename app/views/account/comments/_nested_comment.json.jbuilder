json.partial! 'account/posts/comments/default_comment', locals: { comment: comment}
json.edit_url edit_account_comment_comment_path(comment.commentable, comment)
json.destroy_url account_comment_comment_path(comment.commentable, comment)
json.nested true