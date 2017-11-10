RailsNew.Views.CommentItemView = Backbone.View.extend
  el: '#comments'
  render: ->
    template =  JST['backbone/views/comment']({comment: @model.attributes, parent: true})
    RailsNew.comment = @model.attributes
    @$el.append template
    @
