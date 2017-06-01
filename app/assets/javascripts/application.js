//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .

$(function(){
  var options = {
    enableHighAccuracy: true,
    maximumAge: 0
  };

  $('body').on('ajax:before', '#check-form', function(e){
    e.preventDefault();
    navigator.geolocation.getCurrentPosition(success, error, options);
  });

  function success(pos) {
    var crd = pos.coords;

    $('#check_latitude').val(crd.latitude);
    $('#check_longitude').val(crd.longitude);
    $('#check_accuracy').val(crd.accuracy);

    console.log("I am in application.js" + crd.longitude)

    //$('#check-form').submit();
  };

  function error(err) {
    console.warn('ERROR(${err.code}): ${err.message}');
  };

  // navigator.geolocation.getCurrentPosition(success, error, options);
});
