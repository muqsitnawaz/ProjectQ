// Showing relpies
$("[id^=showReplies]").click(function() {
  answer_id = this.id.substring(11, this.id.length)
  console.log('id: '+answer_id)

  $("#replies"+answer_id).toggleClass('hidden')
})

// Editing a question
$("[id^=edit_question]").click(function() {
  question_id = this.id.substring(13, this.id.length)
  $('#editQuestionModal').modal('show')
  
  // Initiliasing ckeditro for the first time
  if ($("#new_question_detail").val() == "null") {
    CKEDITOR.replace('new_question_detail')
    $("#new_question_detail").val("defined")
  }
  
  // // Replacing contnet in ckeditor
  // $("#new_question_content").val($('#question_content'+question_id).val())
  // $("#new_question_detail").val($('#question_detail'+question_id).text())
  // $('#editQuestionModal').modal('show');
  
  // Replacing content in ckeditor
  $("#new_question_content").val($('#question_content'+question_id).val())
	CKEDITOR.instances.new_question_detail.setData($('#question_detail'+question_id).html())
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
  $('#editAnswerModal').modal('show');

  // Initiliasing ckeditro for the first time
  if ($("#new_answer_answer").val() == "null") {
    CKEDITOR.replace('new_answer_answer')
    $("#new_answer_answer").val("defined")
  }
  
  // Replacing contnet in ckeditor
	CKEDITOR.instances.new_answer_answer.setData($('#answer'+answer_id).html())
})

// Updating an answer
$("#new_answer_submit").click(function() {
  const answer = CKEDITOR.instances.new_answer_answer.getData()

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

$("[id^=edit_reply]").click(function() {
  reply_id = this.id.substring(10, this.id.length)
  $('#editReplyModal').modal('show')

  // Initiliasing ckeditro for the first time
  if ($("#new_reply_reply").val() == "null") {
    CKEDITOR.replace('new_reply_reply')
    $("#new_reply_reply").val("defined")
  }
  
  // Replacing contnet in ckeditor
	CKEDITOR.instances.new_reply_reply.setData($('#reply'+reply_id).html())
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
      location.reload()
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
      location.reload()
    },
    error: function() {
      alert("error")
    }
  });
})

// Downvoting an answer
$("[id^=downvote]").click(function() {
  answer_id = this.id.substring(8, this.id.length)

  // Sending ajax request to downvote an answer
  $.ajax({
    url: "/downvote",
    type: "POST",
    data: { answer_id: answer_id },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      alert("downvoted")
      location.reload()
    },
    error: function() {
      alert("error")
    }
  });
})