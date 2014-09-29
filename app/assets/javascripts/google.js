function GoogleController(map, searchBar){
  this.map = map;
  this.searchBar = searchBar;
}
GoogleController.prototype = {
  initialize: function(){
    this.getLocation()
    this.searchBar.initialize()
  },
  getLocation: function(){
    // SHOULD BE MOVED TO A MODEL
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(this.map.initialize.bind(this));

      navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = new google.maps.LatLng(
          position.coords.latitude, position.coords.longitude);
      this.searchBar.autocomplete.setBounds(new google.maps.LatLngBounds(geolocation,
          geolocation));
    }.bind(this))
    } else {
      console.log( "Geolocation is not supported by this browser.");
    }
  }
}