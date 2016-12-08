$(document).on('turbolinks:load', function(){
	$("#new_message").on('keypress', function(e){
		if(e.keyCode == 13){ // 13 - Enter
			e.preventDefault();
			$(this).submit(); // currentTarget - form
		}
	});

	$('#new_message').on('submit', function(e){
		e.preventDefault();
		var chatrooms_id = $("[data-behavior='messages']").data("chatroom-id");
		var body = $("#message_body");
		var message = body.val();
		App.chatrooms.send_message(chatrooms_id, message);
		body.val("");
	});
});