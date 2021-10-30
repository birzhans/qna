import consumer from "./consumer"

$(document).on('turbolinks:load', function(){
  let current_page = document.location.pathname

  if (current_page.includes('/questions/')) {
    consumer.subscriptions.create(
      { channel: "CommentsChannel", question_id: gon.question_id }, {
      received(data) {
        if (gon.user_id === data.comment.user_id) return

        if (data.comment.commentable_type == 'Question') {
          $('.comments').append(`<p>${data.email}: ${data.comment.body}</p>`)
          $('#comment_body').val('')
        } else {
          $(`#answer-${data.comment.commentable_id} .comments`).append(`<p>${data.email}: ${data.comment.body}</p>`)
          $(`#answer-${data.comment.commentable_id} #comment_body`).val('')
        }
      }
    })
  }
})
