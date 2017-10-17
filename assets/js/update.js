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
  channel.push("follows", {user: user})
                .receive("ok", follow_response);
  $('#post-btn').click(send_post);
}

function join_channel(user) {
  var chan = 'updates:';
  chan += (user != null) ? user : "all";
  var data = (user != null) ? {user: user} : {};
  var ch = socket.channel(chan, data);
  ch.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) });

  ch.on("message", got_message);

  if (channel == null)
  {
    channel = ch;
  }

}

function follow_response(ids) {
  ids["follows"].forEach(function(follow_id) {
    join_channel(follow_id);
  });
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
  var rowTemplate = $($("#row-template")[0]);
  var code = rowTemplate.html();
  var template = handlebars.compile(code);
  var html = template(msg);
  $(html).insertBefore('table > tbody > tr:first');
}





// Call initialize function on page load
$(init);
