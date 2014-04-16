jQuery ->
  $("#activity_in_sequence_timing_until").datepicker()

jQuery ->
  $('#activity_in_sequence_kind_of_timing').change -> 
    toggle_fields()
    $('#activity_in_sequence_reactive_expression').val('')
    $('#activity_in_sequence_freak_number').val('')


jQuery ->
  $('#activity_in_sequence_goal_id').change -> 
    switch $('#activity_in_sequence_goal_id :selected').text()
      when "Create a New Goal"
        $('#activity_in_sequence_new_goal_text').show()
        $('#goal_new_text').show()
      else
        $('#activity_in_sequence_new_goal_text').hide()
        $('#goal_new_text').hide()

jQuery ->
  $('#activity_in_sequence_until_radio_date').click -> 
    $('#untilfield').show()

jQuery ->
  $('#activity_in_sequence_until_radio_nodate').click -> 
    $('#untilfield').hide()


toggle_fields = ->
  switch $('#activity_in_sequence_kind_of_timing :selected').text()
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

