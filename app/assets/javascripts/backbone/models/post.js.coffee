class RailsNew.Models.Post extends Backbone.Model
  paramRoot: 'post'

  defaults:
    content: null
    picture: null
    string: null

class RailsNew.Collections.PostsCollection extends Backbone.Collection
  model: RailsNew.Models.Post
  url: '/acoount/posts'
