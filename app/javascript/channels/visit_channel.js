
import consumer from "./consumer";

const messagesContainer = document.getElementById('messages');
if (messagesContainer) {
  const id = messagesContainer.dataset.visitId;

  consumer.subscriptions.create({ channel: "VisitChannel", id: id }, {
    received(data) {
      messagesContainer.insertAdjacentHTML('beforeend', data);
      console.log(data); // called when data is broadcast in the cable
    },
  });
}
