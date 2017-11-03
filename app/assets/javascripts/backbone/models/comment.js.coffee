class RailsNew.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

  defaults:
    content: 'fghgf'

class RailsNew.Collections.CommentsCollection extends Backbone.Collection
  model: RailsNew.Models.Comment
  url: '/account/posts/50/comments?_=150972277'
