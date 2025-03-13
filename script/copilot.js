document.querySelector("textarea#copilot-chat-textarea").focus();
let container = document.querySelector(".message-container").parentElement;
container.setAttribute('tabindex', '0');
container.focus();
