var map;
$(function() {
  $(".form_datetime").datetimepicker({format: 'YYYY-MM-DD'});
  navigator.geolocation.getCurrentPosition(show_map);
});



function show_map(position) {
  var latitude = position.coords.latitude;
  var longitude = position.coords.longitude;
  // Create a map object and specify the DOM element for display.
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: latitude, lng: longitude},
    scrollwheel: true,
    zoom: 16
  });
  var infowindow = new google.maps.InfoWindow({});

  var marker = new google.maps.Marker({
    position: {lat: latitude, lng: longitude},
    map: map,
    label: "Você",
    icon: "",
    draggable: true,
    title: 'Mostrará todos os tweets em um raio de 5km, apartir da sua posição.'
  });
  marker.addListener('click', function() {
     infowindow.open(map, marker);
   });

  google.maps.event.addListener(marker, 'dragend', function(evt){
    get_geo_tweets(evt.latLng.lat()+','+evt.latLng.lng());
    infowindow.setOptions({
        content: '<p>Mostrará todos os tweets em um raio de 5km, apartir da sua posição.</p><p>Aguarde!</p>'
    });
    infowindow.open(map, marker);
  });

  google.maps.event.addListener(marker, 'drag', function(evt){
      console.log("marker is being dragged");
  });

}



function get_search_result(){
  $.get('/twitter_info/twitter_search?search_string='+$("#search_string").val().replace('#', "%23")+"&start_date="+$("#start_date").val()+"&end_date="+$("#end_date").val(), function(data) {
      $("#search-results").html(data);
   });
}
function get_geo_tweets(coordinates){
  $.get('/twitter_info/twitter_geo_location?coordinates='+coordinates, function(tweets) {
    tweets.forEach(function(tweet){
      // alert(tweet.place.bounding_box.coordinates[0][0][1]);
      // alert( tweet.place.bounding_box.coordinates[0][0][0]);
      var infowindow = new google.maps.InfoWindow({
          content: '<p>'+tweet.text+'</p>'
      });
      var marker = new google.maps.Marker({
        position: {lat: tweet.place.bounding_box.coordinates[0][0][1], lng:  tweet.place.bounding_box.coordinates[0][0][0]},
        map: map,
        label: "",
        draggable: true,
        title: tweet.user.screen_name
      });
      marker.addListener('click', function() {
         infowindow.open(map, marker);
       });
    });
   });
}
