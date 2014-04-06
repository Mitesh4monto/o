/*---------	Screenshots Plugin  -------*/

/*
	Slimbox v2.04 - The ultimate lightweight Lightbox clone for jQuery
	(c) 2007-2010 Christophe Beyls <http://www.digitalia.be>
	MIT-style license.
*/
 
/*---------	Screenshots Hover  -------*/

$(document).ready(function(){

$("img.a").hover(
function() {
$(this).stop().animate({"opacity": "0.2"}, "800");
},
function() {
$(this).stop().animate({"opacity": "1"}, "fast");
});

});

/*---------	Contact Form  -------*/
$(document).ready(function(){
$("#popi,#popi2").click(function(){
$("#overlay_form").fadeIn(1000);
$("#popi-bg").css({
"opacity": "0.7"
}); 
$("#popi-bg").fadeIn("slow");
positionPopup();
});
$("#close").click(function(){
$("#overlay_form").fadeOut(500);+
$("#popi-bg").fadeOut("slow");

});
});
 
function positionPopup(){
if(!$("#overlay_form").is(':visible')){
return;
}
$("#overlay_form").css({
left: ($(window).width() - $('#overlay_form').width()) / 2,
top: ($(window).width() - $('#overlay_form').width()) / 7,
position:'absolute'
});
}
$(window).bind('resize',positionPopup);
function validateEmail(email) { 
		var reg = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		return reg.test(email);
	}

	$(document).ready(function() {
		 
		$("#contactform").submit(function() { return false; });

		
		$("#send").on("click", function(){
			var emailval  = $("#email").val();
			var msgval    = $("#message").val();
			var msglen    = msgval.length;
			var mailvalid = validateEmail(emailval);
			
			if(mailvalid == false) {
				$("#email").addClass("error");
			}
			else if(mailvalid == true){
				$("#email").removeClass("error");
			}
			
			if(msglen < 4) {
				$("#msg").addClass("error");
			}
			else if(msglen >= 4){
				$("#msg").removeClass("error");
			}
			
			if(mailvalid == true && msglen >= 4) {
				// if both validate we attempt to send the e-mail
				// first we hide the submit btn so the user doesnt click twice
				$("input.submit").replaceWith("<em>sending...</em>");
				
				$.ajax({
					type: 'POST',
					url: 'mailer.php',
					data: $("#contactform").serialize(),
					success: function(data) {
						if(data == "true") {
							$("em").fadeOut("fast", function(){
								$(this).before("<p> Your Message has been sent.</p>");
								setTimeout("$.fancybox.close()", 1000);
							});
						}
					}
				});
			}
		});
	});
/*---------	Tabbed Slideshow  ----------*/

var TabbedContent = {
	init: function() {	
		$(".tab_item").mouseover(function() {
		  $(this).addClass("current").siblings().removeClass("current");
		 
			var background = $(this).parent().find(".moving_bg2");
			 
			$(background).stop().animate({
				left: $(this).position()['left']
				 
			});
			
			TabbedContent.slideContent($(this));
			
		});
	},
	
	slideContent: function(obj) {
		
		var margin = $(obj).parent().parent().find(".slide_content").width();
		margin = margin * ($(obj).prevAll().size() - 1);
		margin = margin * -1;
		
		$(obj).parent().parent().find(".tabslider").stop().animate({
			 
			marginLeft: margin + "px"
		}, {
			duration: 500
		});
	}
}

$(document).ready(function() {
TabbedContent.init();
});

