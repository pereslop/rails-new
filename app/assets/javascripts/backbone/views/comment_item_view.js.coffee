RailsNew.Views.CommentItemView = Backbone.View.extend
  el: '#comments'
#  template: _.template "<a href='#' data-remote='true' data-method='get'>dfgdfg</a><p>fghf<p>"
  setPlaceholder: ->
    if $('#comments').children('dvi').length is 0 then $('#comments').append('</p>no comments</p>')
  render: ->
    template =  _.template($('#comment-template').html(), { comments: @model.atributes })
    @$el.append template
    @
  events:
    'click': 'showMessage'
  showMessage: ->
    console.log @model.attributes.content