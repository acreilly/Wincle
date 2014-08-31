function MapController(model){
  this.model = model;
  // this.markers = markers;
}

MapController.prototype = {
  getLocation: function(){
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.initialize.bind(this));
    } else {
      console.log( "Geolocation is not supported by this browser.");
    }
  },

  initialize: function(position){
    this.model.createMap(position);
    // this.markers.initializeMarkers(this.model.map)
  },
  setLocation: function(){
var markers = [];
  var lat = parseFloat($(".latitude")[0].value);
  var lon = parseFloat($(".longitude")[0].value);

  if($(".latitude")[0].value === ""){
    var map = new google.maps.Map(document.getElementById('map-canvas'), {
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    var defaultBounds = new google.maps.LatLngBounds(
      new google.maps.LatLng(-33.8902, 151.1759),
      new google.maps.LatLng(-33.8474, 151.2631));
    map.fitBounds(defaultBounds);

  } else {

    var mapOptions = {
      center: new google.maps.LatLng(lat, lon),
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);


    var marker = new google.maps.Marker({
      position: mapOptions.center,
      map: map
    });

    $("#pac-input").value = $(".location")[0].value;
  }
}


// === MAP ===================


function MapModel(){
  this.map;
}

MapModel.prototype = {

  createMap: function(position){
    var self = this,
    mapLatitude = position.coords.latitude,
    mapLongitude = position.coords.longitude,
    currentLocation = new google.maps.LatLng(mapLatitude, mapLongitude),
    mapOptions = {
      zoom: 13,
      center: currentLocation
    };

    this.map = new google.maps.Map($("#my_map")[0], mapOptions)
    // this.setMapBounds()

  },

  setMapBounds: function(){
    var lastValidCenter = this.map.getCenter();
    var allowedBounds = new google.maps.LatLngBounds(
      new google.maps.LatLng(lastValidCenter.k - 0.03, lastValidCenter.B - 0.03),
      new google.maps.LatLng(lastValidCenter.k - 0.03, lastValidCenter.B - 0.03)
      );

    var map = this.map
    google.maps.event.addListener(this.map, 'center_changed', function() {
      if (allowedBounds.contains(lastValidCenter)) {
        lastValidCenter
      }
      map.panTo(lastValidCenter);
    });
  }
}