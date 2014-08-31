function FormController(){}

FormController.prototype = {
  initialize: function(){
    this.changeCheck()
  },

  userCheck: function(event){
    // var userType = $("#employee_info").val()
    // var employerInfo = $("#employee_info").val()
    if(userType === "Employee"){
      $("#employer").empty();
    } else if (userType === "Employerr"){
      $("#employee").empty();
      $(".info").css("display", "block")
}
  },
  changeCheck: function(){
    $("#event-container").on("change", "#losting_user_type", this.userCheck)
    $("#event-container").on("change", "#sighting_user_type", this.userCheck)
  }

}