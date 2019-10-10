  var $ = require("jquery");

console.log("EDIT JS");



var msg, unsaved;

msg = "You have unsaved changes in your cardtest. Are you sure you want to publish without saving?";

unsaved = false;

// $(document).on('change', 'input', function() {
//   return unsaved = true;
//   console.log(unsaved);
//   $("save-btn").show();
// });


$(document).on('change', 'textarea', function() {
  unsaved = true;
  console.log("unsaved to true");
  $(".save-btn").show();
});

$(document).on('change', 'input', function() {
  unsaved = true;
  console.log("unsaved to true");
  $(".save-btn").show();
});

$(document).on('turbolinks:load', function() {



  return unsaved = false;
  console.log(unsaved);
});




$(function() {


  $(".save-cardtest").click(function(e){

  });

  $(".continue-btn").click(function(e){
    e.preventDefault();
    if(!$('#cardtest_name')[0].checkValidity()){
      $('.save-cardtest').trigger('click');
    } else {
      $(".tab-setup").hide();
      $(".tab-cards").show();
      $(".step-1").hide();
      $(".continue-btn-body").hide();
      $(".step-2").show();
    }

  });

  $(".back-btn").click(function(e){
    e.preventDefault();
    $(".tab-setup").show();
    $(".tab-cards").hide();
    $(".step-1").show();
    $(".step-2").hide();
    $(".continue-btn-body").show();

  });



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


  $(".end-t").click(function(e){
    e.preventDefault();
    $("#publish-form").trigger("submit");
  });


  $("#publish-form").submit(function(e){

    e.preventDefault(); //prevent submit
    // console.log($(this));
    // console.log($(this).find("#publish-test"));
    if($(this).find("#publish-test").hasClass("end-test") && $(this).find('#status-field').val() == "published"){

      var choice = confirm("Are you sure you want to end your test?");

      if (choice == true){

        console.log("is 1, setting to 0");
        $(this).find('#status-field').val("ended");
        this.submit();
        return true;

      } else {
        return false;
      }

    }

      var self = this;
      console.log(unsaved);
      if (unsaved) {
        var choice = confirm(msg);
        if (choice == true){

          if ($(this).find('#status-field').val() == "published"){
              console.log("is 1, setting to 0");
              $(this).find('#status-field').val("ended");
              this.submit();
              // $(this).find('#status-field').value = "false";
          } else {
              console.log("is 0, setting to 1");
              $(this).find('#status-field').val("published");
              this.submit();
              // $(this).find('#status-field').value = "true";
          }

          return true;


        } else {
          return false;
        }
      } else {
        var choice = confirm("You won't be able to make any changes to your test once it's been published. Are you sure it's ready for participants?");

        if (choice == true){

          if ($(this).find('#status-field').val() == "published"){
              console.log("is 1, setting to 0");
              $(this).find('#status-field').val("ended");
              this.submit();
              // $(this).find('#status-field').value = "false";
          } else {
              console.log("is 0, setting to 1");
              $(this).find('#status-field').val("published");
              this.submit();
              // $(this).find('#status-field').value = "true";
          }
        } else {
          return false;
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
              $('#logo-uploaded').removeClass("hidden");
              $('.remove-image').removeClass("hidden");

          }

          reader.readAsDataURL(input.files[0]);
      }
  }

  $('.remove-image').click(function(event){
    console.log("remove");
    event.preventDefault();
    $('#logo-img').val('');
    $('#logo-uploaded').addClass("hidden");
    $(this).addClass("hidden");
  });

  $("#logo-img").change(function(){
      readURL(this);
  });

  $(".cardtest-form").on('change', '#logo-img',function(){
    console.log("change event");
      readURL(this);
  });

});
