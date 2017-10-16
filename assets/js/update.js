import socket from "./socket";
// Global vars
var channel;
let handlebars = require("handlebars");

function init() {
  if ($('body').data('page') != "MessageView/index") {
    return;
  }
  var user;
  var messageDiv = $($('#message-div')[0]);
  if (messageDiv != null) {
    user = messageDiv.data("user-id");
  }

  join_channel(user);
  $('#post-btn').click(send_post);
}

function join_channel(user) {
  var chan = 'updates:';
  chan += (user != null) ? user : "all";
  var data = (user != null) ? {user: user} : {};
  channel = socket.channel(chan, data);
  channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

  channel.on("message", got_message);
}

function send_post() {
  var text = $($('#post-text')[0])[0].value;
  channel.push("post", {post: text})
          .receive("ok", got_post_response);
}

function got_post_response() {
  console.log("Post successful");
}

function got_message(msg) {
  console.log("got");
}




// Call initialize function on page load
$(init);
