
var $ = require("jquery");
$(function() {

  $("li.cardtest").css('cursor', 'pointer');

  $("li.cardtest").hover(function(){
    // console.log("this:");
    // console.log($(this));
    $(this).find($(".divider")).hide();
    // console.log("prev:");
    // console.log($(this).prev());
    $(this).prev().find($(".divider")).hide();
  }, function() {
    $(this).find($(".divider")).show();
    $(this).prev().find($(".divider")).show();
  });



  $('body').click(function(e){

       var Elem = $(e.target);
       console.log(Elem);

       if (Elem.parents("li.cardtest").length){

         Turbolinks.visit(Elem.parents("li.cardtest").find("a").eq(0).attr('href'))
         console.log("yes");
       }


       if (Elem.is('li.cardtest')){
          // console.log($(Elem).find("a"));
          Turbolinks.visit($(Elem).find("a").eq(0).attr('href'))
           // $(Elem).find("a").eq(0).trigger("click");
       }
})

});
