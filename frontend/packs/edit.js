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


  $(document).on('click', '.remove-predefined-group', function(e) {
    e.preventDefault();
    $(this).parents(".group-field").remove();
    $(".save-btn").show();
  });

  // $(".remove-predefined-group").click(function(e){
  //   e.preventDefault();
  //   $(this).parents(".group-field").remove();
  // });

  $(".add-predefined").click(function(e){
    e.preventDefault();
    var element = '<div class="group-field item bg-white rounded p-2 mb-2 w-64 inline-block shadow mr-2"><div class="field w-7/8 clearfix flex m-0"><input class="input w-7/8 mr-2 text-sm" type="text" value="" placeholder="Enter a group name ..."><a class="remove-predefined-group pt-2 w-1/8 text-red-400 hover:text-red-600" href="#"  tabindex="-1"><i class="fa fa-trash" aria-hidden="true"></i></a></div></div>';
    $(".predefined-groups").append(element);
    $(".save-btn").show();

  });


  // $('.card-input').keypress(function (e) {
  //   console.log("keypress");
  //   if (e.which == 13) {
  //     console.log("enter");
  //     $('.add-card-btn').trigger('click');
  //     return false;    //<---- Add this line
  //   }
  // });




  $(document).on('keypress', 'input[name="cardtest[name]"]', function(e) {





    var keycode = (event.keyCode ? event.keyCode : event.which);
     if(keycode == '13'){
       e.preventDefault();
     }

   });




  $('input[type=radio][name="cardtest[testtype]"]').change(function() {
      if (this.value == 'closed') {
        $(".fixedgroups").show();
      }
      else if (this.value == 'open') {
        $(".fixedgroups").hide();
      }
      else if (this.value == 'hybrid') {
        $(".fixedgroups").show();
      }
  });

  console.log($('input[type=radio][name="cardtest[testtype]"]:checked').val());

  if($('input[type=radio][name="cardtest[testtype]"]:checked').val() == "closed"){
      console.log("asd1");
      $(".fixedgroups").show();
  } else if ($('input[type=radio][name="cardtest[testtype]"]:checked').val() == "open"){
    console.log("asd");
    // console.log($('input[type=radio][name="cardtest[testtype]"]').val());
    // console.log($('input[type=radio][name="cardtest[testtype]"]').value);
    $(".fixedgroups").hide();
  } else if ($('input[type=radio][name="cardtest[testtype]"]:checked').val() == "hybrid"){
      console.log("asd2");
    $(".fixedgroups").show();
  } else {
    console.log("else");
    // console.log($('input[type=radio][name="cardtest[testtype]"]').val());
  }


  return unsaved = false;
  console.log(unsaved);

});


function unique(list) {
  var result = [];
  $.each(list, function(i, e) {
    if ($.inArray(e, result) == -1) result.push(e);
  });
  return result;
}

$(function() {



  // $('input[type=radio][name="cardtest[testtype]"]').change(function() {
  //     if (this.value == 'closed') {
  //       $("fixedgroups").show();
  //     }
  //     else if (this.value == 'open') {
  //       $("fixedgroups").hide();
  //     }
  //     else if (this.value == 'hybrid') {
  //       $("fixedgroups").show();
  //     }
  // });



  $(".save-cardtest").click(function(e){


    e.preventDefault();

    var predGroups = [];
    $("#cardtest_fixedgroups").val("");
    $(".group-field input").each(function(){
      predGroups.push($(this).val());

    });
    predGroups = unique(predGroups);

    console.log(predGroups);
    $.each(predGroups,function(){

        $("#cardtest_fixedgroups").val($("#cardtest_fixedgroups").val() + this+"\n");
    })

    $('.cardtest-form').submit();



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
