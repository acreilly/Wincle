function MapController(model, markers){
  this.model = model;
  this.markers = markers;
}

MapController.prototype = {
  initialize: function(position){
    this.map.model.createMap(position);
    // this.markers.initializeMarkers(this.model.map)
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
    // this.autopopulateLocation(currentLocation)
    // this.searchBar(this.map, currentLocation)
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
  },
  searchBar: function(map, bounds){
    var input =(document.getElementById('pac-input'));
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchBox = new google.maps.places.SearchBox((input));
  // Listen for the event fired when the user selects an item from the
  // pick list. Retrieve the matching places for that item.
  google.maps.event.addListener(searchBox, 'places_changed', function() {
    var places = searchBox.getPlaces();
    debugger
    if (places.length == 0) {
      return;
    }
    for (var i = 0, marker; marker = markers[i]; i++) {
      marker.setMap(null);
    }

    // For each place, get the icon, place name, and location.
    markers = [];
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0, place; place = places[i]; i++) {
      var image = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      var marker = new google.maps.Marker({
        map: map,
        icon: image,
        title: place.name,
        position: place.geometry.location
      });

      markers.push(marker);
      bounds.extend(place.geometry.location);
    }
    map.fitBounds(bounds);
  });
  google.maps.event.addListener(map, 'bounds_changed', function() {
    var bounds = map.getBounds();
    searchBox.setBounds(bounds);
  });
},
autopopulateLocation: function(location){
  $.ajax({
    method: "get",
    url: "https://maps.googleapis.com/maps/api/geocode/json?latlng=" + location.toString().replace("(", "").replace(")", "") + "&key=AIzaSyBnpjI0eut55g0on7RKUDzxCmEmyif2oCM"
  }).done(function(data){
    $("#location")[0].value = data.results[1].formatted_address
    $("#lat")[0].value = data.results[1].geometry.location.lat
    $("#lng")[0].value = data.results[1].geometry.location.lng
  })
},
enterLocation: function(){
  event.preventDefault()
  var geocoder = new google.maps.Geocoder();
  var location = $("#location")[0].value;
  geocoder.geocode({"address": location}, function(results, status){
    $("#location")[0].value = results[0].formatted_address
    $("#lat")[0].value = results[0].geometry.location.lat
    $("#lng")[0].value = results[0].geometry.location.lng
  })
}
}