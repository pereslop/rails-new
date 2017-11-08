RailsNew.Views.CommentItemView = Backbone.View.extend
  tagName: 'li'
  template: _.template "<%= content %>"
  setPlaceholder: ->
    if $('#comments').children('li').length is 0 then $('#comments').append('</p>no comments</p>')
  render: ->
    @$el.html @template @model.attributes
    @
  events:
    'click': 'showMessage'
  showMessage: ->
    console.log @model.attributes.content