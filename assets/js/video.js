import Player from "./player"
import socket from "./socket"

let Video = {
  init(socket, element) { if(!element){ return }
    let videoId = element.getAttribute("data-id")
    let playerId = element.getAttribute("data-player-id")
    socket.connect()
    Player.init(element.id, playerId, () => {
      this.onReady(videoId)
    })
  },
  onReady(videoId) {
    let msgContainer = document.getElementById("msg-container");
    let msgInput = document.getElementById("msg-input");
    let msgSubmit = document.getElementById("msg-submit"); 
    let vidChannel = socket.channel("videos:" + videoId);

    msgSubmit.addEventListener("click", e => {
      let payload = {body: msgInput.value, at: Player.getCurrentTime()}
      vidChannel.push("new_annotation", payload)
                .receive("error", e => console.log(e) )
      msgInput.value = ""
    })

    vidChannel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    vidChannel.on("new_annotation", (resp) => {
      this.renderAnnotation(msgContainer, resp)
    })
  },

  renderAnnotation(msgContainer, {user, body, at}) {
    let template = document.createElement("div")
    template.innerHTML = `
      <a href="#" data-seek="${at}">
        <b>${user.username}</b>: ${body}
      </a>
    `
    msgContainer.appendChild(template)
    msgContainer.scrollTop = msgContainer.scrollHeight
  }
}

export default Video;
