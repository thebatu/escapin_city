//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require_tree .


$(function(){
  var options = {
    enableHighAccuracy: true,
    timeout: 5000,
    maximumAge: 0
  };

  $('body').on('ajax:before', '#check-form', function(e){
    e.preventDefault();
    navigator.geolocation.getCurrentPosition(success, error, options);
  });


  function success(pos) {
    var crd = pos.coords;

    console.log('Your current position is:');
    console.log(`Latitude : ${crd.latitude}`);
    console.log(`Longitude: ${crd.longitude}`);
    console.log(`More or less ${crd.accuracy} meters.`);

    $('#check_latitude').val(crd.latitude);
    $('#check_longitude').val(crd.longitude);
    $('#check_accuracy').val(crd.accuracy);

    $('#check-form').submit();
  };

  function error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  };

  // navigator.geolocation.getCurrentPosition(success, error, options);
});
