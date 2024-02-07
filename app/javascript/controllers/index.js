// Import and register all your controllers from the importmap under controllers/*

// import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
  
$(document).ready(function() {
  debugger
  $(".t_like").on("click", function(event){
    debugger
    $.ajax({
      url: "/tweets/:tweet_id/likes",
      method: "POST",
      success: function(response) { 
        console.log(response);
      if (response == true){
        debugger
        alert("hello");
      }   
      }
    });
  });
 }); 