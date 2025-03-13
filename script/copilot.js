document.querySelector('[class*="ImmersiveChat-module__scrollToBottomButton"]').remove();

document.querySelector("textarea#copilot-chat-textarea").focus();

function message_focus() {
  let container = Array.from(document.querySelectorAll('div[class^="ImmersiveChat-module__messageContent"] .message-container')).pop();
  container.setAttribute('tabindex', '0');
  container.focus();
}

