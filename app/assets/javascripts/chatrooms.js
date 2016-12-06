$(document).on('turbolinks:load', function(){
	$("#new_message").on('keypress', function(e){
		if(e.keyCode == 13){ // 13 - Enter
			e.preventDefault();
			$(this).submit(); // currentTarget - form
		}
	});
});