import consumer from "./consumer"

  document.addEventListener('turbolinks:load', () => {
    window.messageContainer = document.getElementById('message-container')
    window.scrollToBottom = () => {
      window.scroll(0, documentElement.scrollHeight)
    }

    if (messageContainer === null) {
        return
    }

    consumer.subscriptions.create("RoomChannel", {
        connected() {
          console.log("OK!!!!");
        },

        disconnected() {
        },

        reject() {

        },

        received(data) {
            messageContainer.insertAdjacentHTML('beforeend', data['message']);
            scrollToBottom();
        }
    })

    const documentElement = document.documentElement;
    window.messageContent = document.getElementById('message_content');
    const messageButton = document.getElementById('message-button')
    const button_activation = () => {
      if (messageContent.value === '') {
        messageButton.classList.add('disabled')
      } else {
        messageButton.classList.remove('disabled')
      }
    }
});
