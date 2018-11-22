json.partial! 'account/posts/comments/default_comment', locals: { comment: comment}
json.edit_url edit_account_post_comment_path(comment.commentable, comment)
json.destroy_url account_post_comment_path(comment.commentable, comment)
json.new_comment_url new_account_comment_comment_path(comment)
json.nested false