$(function() {
	$(".collapselinkhals").click(function(){
		console.log($(this));
		var com = "#addComment" + $(this)[0].title;
		if ($(com).is(":visible")) {
			$(document.body).animate({'scrollTop':   $(com).offset().top}, 500);
		}
		$(com).toggle(1000);
	});
	// $(".replyhals").click(function(){
	// 	console.log($(this));
	// 	var com = "#addComment" + $(this)[0].title;
	// 	$(com).toggle(1000);
	// });
});
