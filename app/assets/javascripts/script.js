// Answering a question
$("[id^=answerQ]").click(function() {
  question_id = this.id.substring(7, this.id.length)
  console.log('id: '+question_id)

  $("#question-header").html($("#question_content"+question_id).val())
  $("#answer_question_id").val(question_id)
  $('#answerModal').modal('show');
})

// Replying an answer
$("[id^=replyA]").click(function() {
  answer_id = this.id.substring(6, this.id.length)
  console.log('id: '+answer_id)

  $("#reply_answer_id").val(answer_id)
  $('#replyModal').modal('show');
});

// Showing relpies
$("[id^=showReplies]").click(function() {
  answer_id = this.id.substring(11, this.id.length)
  console.log('id: '+answer_id)

  $("#replies"+answer_id).toggleClass('hidden')
})

// Editing a question
$("[id^=edit_question]").click(function() {
  question_id = this.id.substring(13, this.id.length)
  $("#new_question_content").val($('#question_content'+question_id).val())
  $("#new_question_detail").val($('#question_detail'+question_id).text())
  $('#editQuestionModal').modal('show');
})

// Updating a question
$("#new_question_submit").click(function() {
  const question_content = $("#new_question_content").val()
  const question_detail = $("#new_question_detail").val()

  // Sending ajax request to follow the question
  $.ajax({
    url: "/update_question",
    type: "POST",
    data: {
      question_id: question_id,
      question_content: question_content,
      question_detail: question_detail
    },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      $('#editQuestionModal').modal('hide')

      if (data.status.localeCompare("success") == 0) {
        alert("updated")
        location.reload()
      } else {
        alert("failed to update")
      }
    },
    error: function() {
      alert("error")
    }
  })
})

// Editing an answer
$("[id^=edit_answerQ]").click(function() {
  answer_id = this.id.substring(12, this.id.length)
  $("#new_answer_answer").val($('#answer'+answer_id).text())
  $('#editAnswerModal').modal('show');
})

// Updating an answer
$("#new_answer_submit").click(function() {
  const answer = $("#new_answer_answer").val()
  console.log('new answer ' + answer)

  // Sending ajax request to follow the question
  $.ajax({
    url: "/update_answer",
    type: "POST",
    data: { answer_id: answer_id, answer: answer },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      $('#editAnswerModal').modal('hide')

      if (data.status.localeCompare("success") == 0) {
        alert("updated")
        location.reload()
      } else {
        alert("failed to update")
      }
    },
    error: function() {
      alert("error")
    }
  })
})

// Editing a reply
$("[id^=edit_reply]").click(function() {
  reply_id = this.id.substring(10, this.id.length)
  $("#new_reply_reply").val($('#reply'+reply_id).text())
  $('#editReplyModal').modal('show');
})

// Updating a reply
$("#new_reply_submit").click(function() {
  const reply = $("#new_reply_reply").val()

  // Sending ajax request to follow the question
  $.ajax({
    url: "/update_reply",
    type: "POST",
    data: { reply_id: reply_id, reply: reply },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      $('#editReplyModal').modal('hide')

      if (data.status.localeCompare("success") == 0) {
        alert("updated")
        location.reload()
      } else {
        alert("failed to update")
      }
    },
    error: function() {
      alert("error")
    }
  })
})

// Following a question
$("[id^=follow]").click(function() {
  question_id = this.id.substring(6, this.id.length)

  // Sending ajax request to follow the question
  $.ajax({
    url: "/follow",
    type: "POST",
    data: { question_id: question_id },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      alert("followed")
    },
    error: function() {
      alert("error")
    }
  });

  // Changing UI to indicate followed
  $(this).html('Followed')
  $(this).addClass("following")
})

// Upvoting an answer
$("[id^=upvote]").click(function() {
  answer_id = this.id.substring(6, this.id.length)

  // Sending ajax request to upvote an answer
  $.ajax({
    url: "/upvote",
    type: "POST",
    data: { answer_id: answer_id },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      alert("upvoted")

      // Updating upvote button UI to show new vote
      var upvotes = $('#upvote'+answer_id).text()
      upvotes = parseInt(upvotes.substring(9, upvotes.length))
      $('#upvote'+answer_id).html('Upvote | '+(upvotes+1))
    },
    error: function() {
      alert("error")
    }
  });
})

// Downvoting an answer
$("[id^=downvote]").click(function() {
  answer_id = this.id.substring(6, this.id.length)

  // Sending ajax request to downvote an answer
  $.ajax({
    url: "/downvote",
    type: "POST",
    data: { answer_id: answer_id },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      alert("downvoted")
    },
    error: function() {
      alert("error")
    }
  });
})