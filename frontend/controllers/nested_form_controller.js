import { Controller } from "stimulus"

var $ = require("jquery");

export default class extends Controller {
  static targets = [ "links", "template"]

  connect() {

  }

  add_association(event){


    if (event.keyCode == 13) {
      event.preventDefault();
      var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
      //this.linksTarget.insertAdjacentHTML('beforeend', content)
      $('#editable-cards').append(content);
      //$("#target").focus();
      $('#editable-cards .nested-field:last-child input').focus();
    } else if (event.type == "click" ){
      event.preventDefault();
      console.log("add");
      var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
      //this.linksTarget.insertAdjacentHTML('beforeend', content)
      $('#editable-cards').append(content);
      //$("#target").focus();
      $('#editable-cards .nested-field:last-child input').focus();
    }



  }

  add_association_t(event){

    event.preventDefault();
    console.log("add t");
    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    //this.linksTarget.insertAdjacentHTML('beforeend', content)
    $('#editable-cards').append(content);
    //$("#target").focus();
    $('#editable-cards .nested-field:last-child input').focus();
  }

  remove_association(event){
    event.preventDefault();
    console.log("Remove event handler from Stimulus");

    console.log($(".nested-field").length);

    if ($(".nested-field").length > 1){

      let wrapper = event.target.closest(".nested-field")
      if(wrapper.dataset.newRecord == "true"){
        console.log("remove from frontend");
        wrapper.remove();
      } else {
        console.log("remove from db");
        wrapper.querySelector("input[name*='_destroy']").value = 1
        wrapper.style.display = 'none'
      }

    } else {
      console.log(event.target.closest(".field").querySelector("input[type='text']"));
      event.target.closest(".field").querySelector("input[type='text']").value = "";
      // event.target.closest(".nested-field").find("input[type='text']").focus();
    }


  }

  remove_association_t(event){
    event.preventDefault();
    console.log("Remove TTTT");
  }

}
