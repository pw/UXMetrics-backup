  var $ = require("jquery");

console.log("EDIT JS");



var msg, unsaved;

msg = "Your changes were not saved. Are you sure you want to publish?";

unsaved = false;

$(document).on('change', 'input', function() {
  return unsaved = true;
  console.log(unsaved);
});

$(document).on('turbolinks:load', function() {
  return unsaved = false;
  console.log(unsaved);
});




$(function() {






  $(".save-btn").click(function(e){
    e.preventDefault();
    // console.log($('.cardtest-form')[0].checkValidity());
    // if ($('.cardtest-form')[0].checkValidity()){
    //     $('.cardtest-form').submit();
    // } else {
    //   alert("failed");
    // }

    $('.save-cardtest').trigger('click');

  })

  $(".copy-to-clipboard").click(function(e){
    e.preventDefault();
    console.log("copy clicked");
    $("#share-link").focus();
  	$("#share-link").select();
  	document.execCommand('copy');

    $(this).children("i").removeClass("fa-files-o");
    $(this).children("i").addClass("fa-check");

    $(".copied-text").removeClass("hidden");


  });


  $(".tabs-holder ul").on('click', function(event){



    event.preventDefault();

    if($(event.target).is('a')) {

        if($(event.target).attr('href') == "#cards"){
          $(".tab-setup").hide();
          $(".tab-customise").hide();
          $(".tab-cards").show();



        } else if ($(event.target).attr('href') == "#setup"){
          $(".tab-customise").hide();
          $(".tab-cards").hide();
          $(".tab-setup").show();




        } else if ($(event.target).attr('href') == "#customise"){
          $(".tab-setup").hide();
          $(".tab-cards").hide();
          $(".tab-customise").show();




        }
        $(".tabs-holder li").removeClass("tab-active").addClass("tab-inactive");
        $(event.target).parent("li").removeClass("tab-inactive").addClass("tab-active");

    }

  });




  $("#publish-form").submit(function(e){

    // e.preventDefault(); //prevent submit




      var self = this;
      console.log(unsaved);
      if (unsaved) {
        var choice = confirm(msg);
        if (choice == true){

          if ($(this).find('#status-field').val() == "true"){
              console.log("is 1, setting to 0");
              $(this).find('#status-field').val("false");
              // $(this).find('#status-field').value = "false";
          } else {
              console.log("is 0, setting to 1");
              $(this).find('#status-field').val("true");
              // $(this).find('#status-field').value = "true";
          }

          return true;


        } else {
          return false;
        }
      } else {
        if ($(this).find('#status-field').val() == "true"){
            console.log("is 1, setting to 0");
            $(this).find('#status-field').val("false");
            // $(this).find('#status-field').value = "false";
        } else {
            console.log("is 0, setting to 1");
            $(this).find('#status-field').val("true");
            // $(this).find('#status-field').value = "true";
        }
      }
      // var status = true;

      // $('#publish-form #cardtest_status').value = status;



      // self.submit(); //submit after data is compiled



  });

  function readURL(input) {
      if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
              $('#logo-uploaded').attr('src', e.target.result);
          }

          reader.readAsDataURL(input.files[0]);
      }
  }

  $("#logo-img").change(function(){
      readURL(this);
  });

});
