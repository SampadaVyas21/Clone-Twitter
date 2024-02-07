//= require jquery
//= require jquery_ujs

$( document ).ready(function() {
  $(".likebtn").on("click", function(event){
    debugger
  var id = $(this).attr("id"); 
  $.ajax({
        url: "/tweets/"+id+"/likes/check",
        method: "GET",
        success: function(response) { 
          if (response == false){
            $.ajax({
              url: "/tweets/"+id+"/likes",
              method: "POST",
              success: function(response) { 
                debugger
                $('#t_like_' + id).toggleClass('fa-thumbs-o-up').toggleClass('fa-thumbs-up');
                // $('#t_dislike_' + id).show();
                // $('#t_like_' + id).hide();
                // $('#t_like_' + id).removeClass('fa-thumbs-o-up');
                // $('#t_like_' + id).addClass('fa-thumbs-up');
                // var list = document.getElementById('t_like_' + id).classList;
                // list.remove('fa-thumbs-o-up');
                // list.add('fa-thumbs-up');
                var changeCount = document.getElementById('like_count_' + id).innerHTML = response;
              }
            });
          }
          else{
            $.ajax({
              url: "/tweets/"+id+"/likes/"+response[0],
              method: "DELETE",
              success: function(response) { 
                debugger
                $('#t_like_' + id).toggleClass('fa-thumbs-up').toggleClass('fa-thumbs-o-up');
                // $('#t_dislike_' + id).removeClass('fa-thumbs-up');
                // $('#t_dislike_' + id).addClass('fa-thumbs-o-up');
                // var list = document.getElementById('t_like_' + id).classList;
                // list.remove('fa-thumbs-up');
                // list.add('fa-thumbs-o-up');
                var changeCount = document.getElementById('like_count_' + id).innerHTML = response;
              }
            }); 
          }
        }
      });
    });
  });
  	
  //   $(".tweet_like").on("click", function(event){
  //     var id = $(this).attr("id");
  //     $.ajax({
  //       url: "/tweets/"+id+"/likes",
  //       method: "POST",
  //       success: function(response) { 
  //         debugger
  //         // $('#t_like_' + id).toggleClass('fa-thumbs-o-up fa-thumbs-up');
  //         var list = document.getElementById('t_like_' + id).classList;
  //         list.remove('fa-thumbs-o-up');
  //         list.add('fa-thumbs-up');
  //         // $('#t_like_' + id).removeClass('fa-thumbs-o-up');
  //         // $('#t_like_' + id).addClass('fa-thumbs-up');
  //         var changeCount = document.getElementById('like_count_' + id).innerHTML = response;
  //       }
  //     });
  //   });

  //   $(".tweet_dislike").on("click", function(event){
  //     var id = $(this).attr("id");
  //     var p_id = $(this).attr("p_id"); 
  //     $.ajax({
  //       url: "/tweets/"+id+"/likes/"+p_id,
  //       method: "DELETE",
  //       success: function(response) { 
  //         debugger
  //         // $('#t_dislike_' + id).toggleClass('fa-thumbs-up fa-thumbs-o-up');
  //         var list = document.getElementById('t_like_' + id).classList;
  //         list.remove('fa-thumbs-up');
  //         list.add('fa-thumbs-o-up');
  //         // $('#t_dislike_' + id).removeClass('fa fa-thumbs-up');
  //         // $('#t_dislike_' + id).addClass('fa fa-thumbs-o-up');
  //         var changeCount = document.getElementById('like_count_' + id).innerHTML = response;
  //         // location.reload();
  //       }
  //     });
  //   });
  // });





