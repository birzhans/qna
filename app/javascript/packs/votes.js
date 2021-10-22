$(document).on('turbolinks:load', function() {
  $('.votes').on('ajax:success', function(e) {
    var data = e.detail[0]
    $('.errors').html()
    $(`#${data.kind}`).addClass('active')
    $('#vote-balance').html(data.vote_balance)
  }).on('ajax:error', function(e) {
    var xhr = e.detail[2]
    $('.votes .errors').html(xhr.responseText)
  })
})
