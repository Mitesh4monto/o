# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#activities').sortable
    axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

jQuery ->
  toggle_fields()

jQuery ->
  $("#activity_timing_duration").datepicker()

jQuery ->
  $('#activity_kind_of_timing').change -> 
    toggle_fields()
    $('#activity_reactive_expression').val('')
    $('#activity_freak_number').val('')


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

