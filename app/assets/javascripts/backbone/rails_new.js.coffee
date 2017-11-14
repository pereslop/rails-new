#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers
#= require_tree ./collections

window.RailsNew =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

RailsNew.Views.CommmentsListView = Backbone.View.extend
  el: '#comments'
  initialize: ->
    @listenTo @collection, 'sync', @render
  render: ->
    if @collection.models.length is 0
      $('#load-comments').empty()
      $('#comments').prepend('<p>no moe</p>')
    for model in @collection.models
      itemView = new RailsNew.Views.CommentItemView(model: model)
      @$el.append itemView.render().el