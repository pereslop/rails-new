class RailsNew.Collections.Comments extends Backbone.Collection
  model: RailsNew.Models.Comment
  url: ->
    "/account/posts/#{RailsNew.postId}/comments?page=#{RailsNew.commentsPage + 1}"