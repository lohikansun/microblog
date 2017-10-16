// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

import "./update";

let handlebars = require("handlebars");

$(function() {
  if (!$("#likes-template").length > 0) {
    // Wrong function for this page
    return;
  }

  let likesTemplate = $($("#likes-template")[0]);
  let code = likesTemplate.html()
  let template = handlebars.compile(code)

  let messageLikes = $($("#message-likes")[0]);
  let path = messageLikes.data('path');
  let messageId = messageLikes.data('message_id');

  let button = $($("#like-button")[0]);


  let buttonDiv = $($("#button-div")[0]);
  let userEmail = buttonDiv.data('user-email')
  let userId = buttonDiv.data('user-id');

  function currentLike(arr) {
    return arr['user_email'] == userEmail;
  }

  function fetch_likes() {
    function got_likes(data) {

      console.log(data);
      let html = template(data);

      messageLikes.html(html);
      let doesCurrentLike = data.data.some(currentLike);
      let index = data.data.find(currentLike);
      var b = document.getElementById("like-button");
      if (doesCurrentLike) {
        b.innerHTML = "Unlike";
        b.classList.remove("btn-primary");
        b.classList.add("btn-danger");
        let id = data.data.find(currentLike);
        b.setAttribute("currentLike", id["id"]);
        b.onclick=(remove_like);
      } else {
        b.innerHTML = "Like";
        b.classList.remove("btn-danger");
        b.classList.add("btn-primary");
        b.onclick=(add_like)
      }
    }

    $.ajax({
      url: path,
      data: {
        message_id: messageId
      },
      contentType: "appplication/json",
      dataType: "json",
      method: "GET",
      success: got_likes,
    });
  }

  function add_like() {
    let data = {
      like: {
        message_id: messageId,
        user_id: userId
      }
    };

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_likes,
    });
  }

  function remove_like() {
    let likeId = document.getElementById("like-button").getAttribute("currentLike");

    let data = {
      id: likeId
    }
    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "DELETE",
      success: fetch_likes,
    });
  }

  fetch_likes();
});
