App.chatrooms = App.cable.subscriptions.create("ChatroomsChannel", {
  connected: function(){
   	console.log("Ready!!!")
    //Called when the subscription is ready for use on the server
  },

	disconnected: function(){
		//Called when the subscription has been terminated by the server
	},

	received: function(data){
		var active_chatrooom = $("div[data-behavior='messages'][data-chatroom-id='" + data.chatroom_id +"']");
		if(active_chatrooom.length > 0) {
			active_chatrooom.append(data.message);
		} else {
			var $chatroom_link = $("a[data-behavior='chatroom-link'][data-chatroom-id='" + data.chatroom_id + "']");
			$chatroom_link.css("font-weight", "bold").css('font-style', "italic");
		}
		
		//Called when there's incoming data on the websocket for this channel
	}
});
