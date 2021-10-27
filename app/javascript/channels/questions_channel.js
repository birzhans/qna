import consumer from "./consumer"

$(document).on('turbolinks:load', function(){
  let current_page = document.location.pathname
  var questionsList = $('#questions')

  if (current_page === '/' || current_page === '/questions'){
    consumer.subscriptions.create("QuestionsChannel", {
      connected() {
        console.log('Connected to questions channel')
      },
      received(data) {
        questionsList.append(data)
      }
    });
  }
})
