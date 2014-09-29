$(document).ready(function() {

  var mapModel = new MapModel();
  var mapController = new MapController(mapModel);
  var searchBar = new SearchBar()
  var googleController = new GoogleController(mapController, searchBar)
  googleController.initialize()

  // //  ---------------------------- LOGIN
  // var loginView = new LoginView()
  // var loginController = new LoginController(loginView)
  // loginController.initialize()

  var formController = new FormController();
  formController.initialize()

  $(".getLoc").on("submit", function(){
    mapModel.enterLocation()
  })

});

