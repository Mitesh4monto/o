$(function() {
$('.plus').hover(function() { 
	console.log($(this));
	var deet = "#Details" + $(this)[0].id;
    $(deet).show(); 
}, function() { 
	var deet = "#Details" + $(this)[0].id;
    $(deet).hide(); 
});
});
