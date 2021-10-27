import consumer from "./consumer"

$(document).on('turbolinks:load', function(){
  let current_page = document.location.pathname

  if (current_page.includes('/questions/')) {
    consumer.subscriptions.create(
      { channel: "AnswersChannel", question_id: gon.question_id }, {
      received(data) {
        console.log(data)
        if (gon.user_id === data.answer.user_id) return

        
      }
    })
  }
})
