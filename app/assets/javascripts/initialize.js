$(document).ready(function() {
var mapModel = new MapModel();
var mapController = new MapController(mapModel);
// mapController.getLocation();


  //  ---------------------------- LOGIN
  var loginView = new LoginView()
  var loginController = new LoginController(loginView)
  loginController.initialize()
});
