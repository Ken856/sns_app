import consumer from "./consumer"

  document.addEventListener('turbolinks:load', () => {
    window.messageContainer = document.getElementById('message-container');
    window.messageContent = document.getElementById('message_content');

    window.scrollToBottom = () => {
      window.scroll(0, documentElement.scrollHeight)
    }

    if (messageContainer === null) {
        return
    }

      consumer.subscriptions.create( {channel: "RoomChannel", room: messageContainer.dataset.room_id}, {
        connected() {
          console.log("OK!!!!");
          console.log(messageContainer.dataset.room_id)
        },

        disconnected() {
        },

        reject() {

        },
        //ここを制御する？
        received(data) {
        if (data['room_id'] ==  messageContainer.dataset.room_id ) {
            messageContainer.insertAdjacentHTML('beforeend', data['message']);
            scrollToBottom();
            console.log(data['room_id'])
          }
        }
    })

    //以下ページの挙動

    const documentElement = document.documentElement;

    const messageButton = document.getElementById('message-button')
    const button_activation = () => {
      if (messageContent.value === '') {
        messageButton.classList.add('disabled')
      } else {
        messageButton.classList.remove('disabled')
      }
    }

    messageContent.addEventListener('input', () => {
        button_activation()
        changeLineCheck()
    })

    messageButton.addEventListener('click', () => {
        messageButton.classList.add('disabled')
        changeLineCount(1)
    })
    const maxLineCount = 10

    // 入力メッセージの行数を調べる関数
    const getLineCount = () => {
        return (messageContent.value + '\n').match(/\r?\n/g).length;
    }

    let lineCount = getLineCount()
    let newLineCount

    const changeLineCheck = () => {
        // 現在の入力行数を取得（ただし，最大の行数は maxLineCount とする）
        newLineCount = Math.min(getLineCount(), maxLineCount)
        // 以前の入力行数と異なる場合は変更する
        if (lineCount !== newLineCount) {
            changeLineCount(newLineCount)
        }
    }

    const changeLineCount = (newLineCount) => {
        // フォームの行数を変更
        messageContent.rows = lineCount = newLineCount
    }
});
