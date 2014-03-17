$(function() {
	$(".linkOne").click(function(){
		var act = "#rightbar" + $(this)[0].title;
		$(act).toggle(1000);
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
	$("#seeoverview").click(function(){
		$('#tabs').tabs("option", 'active', 0)
	});
	$("#seeplan").click(function(){
		$('#tabs').tabs("option", 'active', 1)
	});
	$("#seeplanfromoverview").click(function(){
		$('#tabs').tabs("option", 'active', 1)
	});	
	$("#seedetails").click(function(){
		$('#tabs').tabs("option", 'active', 2)
	});

	$(".collapselinkmarginlft30").click(function(){
		console.log($(this));
		var e="#Comments"+$(this)[0].id;
		$(e).toggle(1000);
	});
	

});

