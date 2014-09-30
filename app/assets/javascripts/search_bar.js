function SearchBar(){
  this.autocomplete;
}
SearchBar.prototype = {
  initialize: function(){
    var placeSearch;
var componentForm = {
  street_number: 'short_name',
  route: 'long_name',
  locality: 'long_name',
  administrative_area_level_1: 'short_name',
  country: 'long_name',
  postal_code: 'short_name'
};
    this.autocomplete = new google.maps.places.Autocomplete((document.getElementById('autocomplete')),
      { types: ['geocode'] });

    google.maps.event.addListener(this.autocomplete, 'place_changed', function() {
      this.fillInAddress();
    });
  },
  fillInAddress: function(){
    var place = this.autocomplete.getPlace();

    for (var component in componentForm) {
      document.getElementById(component).value = '';
      document.getElementById(component).disabled = false;
    }

  for (var i = 0; i < place.address_components.length; i++) {
    var addressType = place.address_components[i].types[0];
    if (componentForm[addressType]) {
      var val = place.address_components[i][componentForm[addressType]];
      document.getElementById(addressType).value = val;
    }
  }
}
}
