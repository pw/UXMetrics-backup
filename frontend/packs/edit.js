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






  $(".save-btn").click(function(){
    $('.cardtest-form').submit();
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
});
