(function(){var t;jQuery(function(){return $("#activities").sortable({axis:"y",containment:"parent",handle:".handle",update:function(){return $.post($(this).data("update-url"),$(this).sortable("serialize"))}})}),jQuery(function(){return t()}),jQuery(function(){return $("#activity_timing_until").datepicker()}),jQuery(function(){return $("#activity_kind_of_timing").change(function(){return t(),$("#activity_reactive_expression").val(""),$("#activity_freak_number").val("")})}),jQuery(function(){return $("#activity_goal_id").change(function(){switch($("#activity_goal_id :selected").text()){case"Create a New Goal":return $("#activity_new_goal_text").show();default:return $("#activity_new_goal_text").hide()}})}),jQuery(function(){return $("#activity_until_radio_date").click(function(){return $("#untilfield").show()})}),jQuery(function(){return $("#activity_until_radio_nodate").click(function(){return $("#untilfield").hide()})}),t=function(){switch($("#activity_kind_of_timing :selected").text()){case"Reactive":return $("#duration_label").html("Until"),$("#freak").hide(),$("#react").show();case"Frequency":return $("#duration_label").html("Until"),$("#freak").show(),$("#react").hide();case"One time":return $("#duration_label").html("By"),$("#freak").hide(),$("#react").hide();default:return $("#duration_label").html("Until"),$("#freak").hide(),$("#react").hide()}}}).call(this);