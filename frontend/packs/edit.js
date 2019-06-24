  var $ = require("jquery");
$(document).on('turbolinks:load', function(){

  $("#publish-form").submit(function(e){

      //e.preventDefault(); //prevent submit

      var self = this;

      var status = 1;

      // $('#publish-form #cardtest_status').value = status;
      if ($(this).find('#status-field').val() == 1){
          console.log("is 1, setting to 0");
          $(this).find('#status-field').val(0);
      } else {
          console.log("is 0, setting to 1");
          $(this).find('#status-field').val(1);
      }


      // self.submit(); //submit after data is compiled



  });

});
