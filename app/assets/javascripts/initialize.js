$(document).ready(function() {
    if($("#map-canvas").length > 0){
    google.maps.event.addDomListener(window, 'load', initialize);
  }
var mapModel = new MapModel();
var mapController = new MapController(mapModel);
// mapController.getLocation();


  //  ---------------------------- LOGIN
  var loginView = new LoginView()
  var loginController = new LoginController(loginView)
  loginController.initialize()

  var formController = new FormController();
  formController.initialize()
});
