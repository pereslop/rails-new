$ ->
  if $('.pagination').length && $('#posts').length
    $(window).scroll ->
      url = $(".pagination a[rel='next']").attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').text("Loading more posts...")
        $.getScript(url)
    $(window).scroll()