function scrollToBottomOfChatLog(){
	if (document.getElementById('chat_history')){
		var oDiv = document.getElementById('chat_history');
		oDiv.scrollTop = oDiv.scrollHeight;
	}
}