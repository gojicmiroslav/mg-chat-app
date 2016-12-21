App.chatrooms = App.cable.subscriptions.create("ChatroomsChannel", {
	connected: function(){
		//Called when the subscription is ready for use on the server
	},

	disconnected: function(){
		//Called when the subscription has been terminated by the server
	},

	received: function(data){
		var active_chatrooom = $("div[data-behavior='messages'][data-chatroom-id='" + data.chatroom_id +"']");
		if(active_chatrooom.length > 0) {
			if(document.hidden){
				// 1. Check to see if there is a divider(for unread messages) on the page
				// 2. If there is no diver, insert one
				if($(".strike").length == 0){
					active_chatrooom.append("<div class='strike'><span>Unread messages</span></div>");
				} else {

				}
				
				if(Notification.permission === "granted"){
					new Notification(data.username, {body: data.body});	
				}

			} else {				
				// Send a notice to the server of last read timestamp				
				App.last_read.update(data.chatroomm_id);
			}

			// Insert the message
			//<%= asset_path('user.png')%>
			// var $css = '<div class="row" style="margin-top: 10px; margin-bottom: 10px;"> \
			// 				<div class="col-md-10"> \
			// 					<div class="media bg-warning message"> \
		 //  							<div class="media-left media-middle"> \
		 //  								sas \	
	  // 								</div> \
		 //  							<div class="media-body"> \
	  //   								<h5 class="media-heading"><strong><i>' + data.username + '</i></strong></h5> \
	  //   								<div>' + data.body + '</div> \
		 //  							</div> \
			// 					</div> \
			// 				</div> \
			// 			</div>';

			var $css =  '<div class="row" style="margin-top: 10px; margin-bottom: 10px;">';
			$css += '<div class="col-md-10">';
			$css += '<div class="media bg-warning message">';
			$css += '<div class="media-left media-middle">';
			$css += '<div class="media-left media-middle">';
			$css += '<img src="/assets/user-c1112aab2643a75a567e7b69373fd612d75552b685f90a5d09a5d5804fbefe2f.png" class="media-object" >';
			$css += '</div>';
			$css += '<div class="media-body">';
			$css += '<h5 class="media-heading"><strong><i>' + data.username + '</i></strong></h5>';
			$css += '<div>' + data.body + '</div>';
			$css += '</div></div></div></div>';

			//active_chatrooom.append("<div><strong>" + data.username +":</strong> " + data.body + " </div>");
			active_chatrooom.append($css);

		} else {
			var $chatroom_link = $("a[data-behavior='chatroom-link'][data-chatroom-id='" + data.chatroom_id + "']");
			$chatroom_link.css("font-weight", "bold").css('font-style', "italic");
		}
	},

	send_message: function(chatroom_id, message){
		this.perform("send_message", { chatroom_id: chatroom_id, body: message });
	}
});
