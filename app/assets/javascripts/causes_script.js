// Showing relpies
$("[id^=showCauseReplies]").click(function() {
  cause_comment_id = this.id.substring(16, this.id.length)
  console.log('id: '+cause_comment_id)

  $("#causeReplies"+cause_comment_id).toggleClass('hidden')
})

// Editing a cause
$("[id^=edit_causeC").click(function() {
  cause_id = this.id.substring(11, this.id.length)
  console.log('causeid '+cause_id)
  $("#new_cause_intro").val($('#cause_intro'+cause_id).val())
  $("#new_cause_detail").val($('#cause_detail'+cause_id).text())
  $("#new_cause_whymatters").val($('#cause_whymatters'+cause_id).text())
  $('#editCauseModal').modal('show');
})

// Updating a cause
$("#new_cause_submit").click(function() {
  const cause_intro = $("#new_cause_intro").val()
  const cause_detail = $("#new_cause_detail").val()
  const cause_whymatters = $("#new_cause_whymatters").val()

  // Sending ajax request to update the cause
  $.ajax({
    url: "/update_cause",
    type: "POST",
    data: {
      cause_id: cause_id,
      cause_intro: cause_intro,
      cause_detail: cause_detail,
      cause_whymatters: cause_whymatters
    },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      $('#editCauseModal').modal('hide')

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

// Editing a cause comment
$("[id^=edit_cause_commentC").click(function() {
  cause_comment_id = this.id.substring(19, this.id.length)
  $('#editCauseCommentModal').modal('show')
  
  // Initiliasing ckeditor for the first time
  if ($("#new_cause_comment_comment").val() == "null") {
    CKEDITOR.replace('new_cause_comment_comment')
    $("#new_cause_comment_comment").val("defined")
  }
  
  CKEDITOR.instances.new_cause_comment_comment.setData($('#cause_comment_comment'+cause_comment_id).html())
})

// Updating a cause comment
$("#new_cause_comment_submit").click(function() {
  const cause_comment_comment = CKEDITOR.instances.new_cause_comment_comment.getData()

  // Sending ajax request to update the cause
  $.ajax({
    url: "/update_cause_comment",
    type: "POST",
    data: {
      cause_comment_id: cause_comment_id,
      cause_comment_comment: cause_comment_comment,
    },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      $('#editCauseCommentModal').modal('hide')

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

// Editing a cause reply
$("[id^=edit_cause_reply]").click(function() {
  reply_id = this.id.substring(16, this.id.length)
  $('#editCauseReplyModal').modal('show');
  
  // Initiliasing ckeditor for the first time
  if ($("#new_cause_reply_reply").val() == "null") {
    CKEDITOR.replace('new_cause_reply_reply')
    $("#new_cause_reply_reply").val("defined")
  }
  
  CKEDITOR.instances.new_cause_reply_reply.setData($('#cause_reply'+reply_id).html())
})

// Updating a reply
$("#new_cause_reply_submit").click(function() {
  const reply = CKEDITOR.instances.new_cause_reply_reply.getData()

  // Sending ajax request to follow the question
  $.ajax({
    url: "/update_cause_reply",
    type: "POST",
    data: { cause_reply_id: reply_id, cause_reply_reply: reply },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      $('#editCauseReplyModal').modal('hide')

      if (data.status === "success") {
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

// Aggree to Cause
$("[id^=agree_]").click(function() {
  const cause_id = this.id.substring(6,this.id.length)
  console.log('cause_id '+cause_id)

  // Sending ajax request to agree to a cause
  $.ajax({
    url: "/agree",
    type: "POST",
    data: {
      cause_id: cause_id
    },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      if (data.status.localeCompare("success") == 0) {
        alert("success")
        location.reload()
      } else {  
        alert("failure")
      }
    },
    error: function() {
      alert("error")
    }
  })
})

// Disaggree to Cause
$("[id^=disagree_]").click(function() {
  const cause_id = this.id.substring(9,this.id.length)
  console.log('cause_id '+cause_id)
  

  // Sending ajax request to disagree to a cause
  $.ajax({
    url: "/disagree",
    type: "POST",
    data: {
      cause_id: cause_id
    },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      if (data.status.localeCompare("success") == 0) {
        alert("success")
        location.reload()
      } else {  
        alert("failure")
      }
    },
    error: function() {
      alert("error")
    }
  })
})

// Follow a Cause
$("[id^=follow_cause]").click(function() {
  const cause_id = this.id.substring(12,this.id.length)
  console.log('cause_id '+cause_id)
  

  // Sending ajax request to disagree to a cause
  $.ajax({
    url: "/follow_cause",
    type: "POST",
    data: {
      cause_id: cause_id
    },
    dataType: "json",
    complete: function() {},
    success: function(data, textStatus, xhr) {
      if (data.status.localeCompare("success") == 0) {
        alert("success")
        location.reload()
      } else {  
        alert("failure")
      }
    },
    error: function() {
      alert("error")
    }
  })
})