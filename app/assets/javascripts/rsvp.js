$(document).ready(function() {

  $('#rsvp_button').on('click', function() {

    var event_id = $('h1').data('id');

    $.post('/rsvp', { id: event_id }, function(data) {
      $("#rsvp_status").html(data);
    });
  });
});