$(document).on('turbolinks:load', function() {
  $('.errors').html()
  $('.votes').on('ajax:success', function(e) {
    var data = e.detail[0]

    if (data.type == 'Question') {
      $(`#question-vote #${data.kind}`).addClass('active')
      $('#question-vote #vote-balance').html(data.vote_balance)
    } else {
      $(`#answer-${data.id} #${data.kind}`).addClass('active')
      $(`#answer-${data.id} #vote-balance`).html(data.vote_balance)
    }
  }).on('ajax:error', function(e) {
    var data = e.detail[0]

    if (data.type == 'Question') {
      $('#question-vote .votes .errors').html(data.messages)
    } else {
      $(`#answer-${data.id} .votes .errors`).html(data.messages)
    }
  })
})
