# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#activities').sortable
    axis: 'y'
    containment: "parent"
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

jQuery ->
  toggle_fields()

jQuery ->
  $("#activity_timing_until").datepicker()

jQuery ->
  $('#activity_kind_of_timing').change -> 
    toggle_fields()
    $('#activity_reactive_expression').val('')
    $('#activity_freak_number').val('')


jQuery ->
  $('#activity_goal_id').change -> 
    switch $('#activity_goal_id :selected').text()
      when "Create a New Goal"
        $('#activity_new_goal_text').show()
        $('#goal_new_text').show()
      else
        $('#activity_new_goal_text').hide()
        $('#goal_new_text').hide()

jQuery ->
  $('#activity_until_radio_date').click -> 
    $('#untilfield').show()

jQuery ->
  $('#activity_until_radio_nodate').click -> 
    $('#untilfield').hide()


toggle_fields = ->
  switch $('#activity_kind_of_timing :selected').text()
    when "Reactive" 
      $('#duration_label').html('Until')
      $('#freak').hide()
      $('#react').show()
    when "Frequency"
      $('#duration_label').html('Until')
      $('#freak').show()
      $('#react').hide()
    when "One time"
      $('#duration_label').html('By')
      $('#freak').hide()
      $('#react').hide()
    else  
      $('#duration_label').html('Until')
      $('#freak').hide()
      $('#react').hide()


# if the function argument is given to overlay,
# it is assumed to be the onBeforeLoad event listener
# $("a[rel]").overlay
#   mask: "darkred"
#   effect: "apple"
#   onBeforeLoad: ->
#     # grab wrapper element inside content
#     wrap = @getOverlay().find(".contentWrap")
#     # load the page specified in the trigger
#     wrap.load @getTrigger().attr("href")

