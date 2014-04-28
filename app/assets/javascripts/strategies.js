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

$(function() {
	$('.nav-toggle').click(function(){
		//get collapse content selector
		var collapse_content_selector = $(this).attr('href');					
		
		//make the collapse content to be shown or hide
		var toggle_switch = $(this);
		$(collapse_content_selector).toggle(function(){
			if($(this).css('display')=='none'){
				toggle_switch.html('Show Customization');//change the button label to be 'Show'
				$('.collapse').hide();
			}else{
				toggle_switch.html('Hide Customization');//change the button label to be 'Hide'
				$('.collapse').show();
			}
		});
	});
});