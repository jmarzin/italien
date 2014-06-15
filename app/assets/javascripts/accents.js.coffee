$(document).ready ->

  $('.accent').click (e) ->
    if $('reponse').prop("disabled")
      $('#reponse').val $('#reponse').val() + $(this).html()
      $('#reponse').focus()
    else
      $('#ecrire').val $('#ecrire').val() + $(this).html()
      $('#ecrire').focus()
    e.preventDefault()
