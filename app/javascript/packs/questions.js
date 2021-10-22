$(document).on('turbolinks:load', function() {
  $('#edit-question').on('click', function(event) {
    event.preventDefault()
    $(this).hide()
    var questionId = $(this).data('questionId')
    $('form#edit-question-' + questionId).show()
  })
})
