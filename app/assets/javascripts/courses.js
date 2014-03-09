$(function() {
	 $('.collapselinkmarginlft30').click(function () {
		console.log($(this));
		var com = "#Comments" + $(this)[0].id;
		$(com).toggle(1000);
	});

	$(".collapselink").click(function(){
		console.log($(this));
		var com = "#addComment" + $(this)[0].title;
		$(com).toggle(1000);
	});
	$(".reply").click(function(){
		console.log($(this));
		var com = "#addComment" + $(this)[0].title;
		$(com).toggle(1000);
	});


});

