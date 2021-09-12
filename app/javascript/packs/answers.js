$(document).on('turbolinks:load', function() {
  $('.answers, #best-answer').on('click', '.edit-answer', function(event) {
    event.preventDefault()
    $(this).hide()
    var answerId = $(this).data('answerId')
    $('form#edit-answer-' + answerId).show()
  })

  $('.answers').on('click', '.close-answer-edit', function(event) {
    event.preventDefault()
    $(this).parent().hide()
  })
})
