//= require active_admin/base
//= require active_admin/base
//= require chartkick
//= require jquery
//= require jquery_ujs


// = require active_admin/base

//= require quill.min
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input

// import { Application } from "@hotwired/stimulus"

// const application = Application.start()

// Configure Stimulus development experience
// application.debug = false
// window.Stimulus   = application

// export { application }



$( document ).ready(function() {
  $('#selected_month').on("change",function(event) {
    var month = $(this).val();
    var year = document.getElementById("selected_year")
    // document.getElementById('selected_year').selectedOptions[0] = ''
    // year = year.replace(year, " ")
    year.value = " "
  });
  $('#selected_year').on("click",function(event) {
    debugger
    var year = $(this).val();
    var month = document.getElementById("selected_month").value
    $.ajax({
      url: "/admin/users/:user_id/tweets/:id/change_month",
      method: "GET",
      data: {month: month + year},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
      },
      success: function (response) {  
        if (response.length == 0) {
          alert("no data present");
        }
       var chart = Chartkick.charts['chart-4']
       chart.updateData(response)
      }
    });
  });

  $('.label').on("click", function(event){
    var list = document.getElementsByClassName('label')
    list[2].removeAttribute('for')
  });

  $('#user_bluetick_input').on("click", function(event){
    var list = document.getElementsByClassName('boolean input optional')
    list[0].childNodes[1].id = 'user_bluetick'
  });
}); 
