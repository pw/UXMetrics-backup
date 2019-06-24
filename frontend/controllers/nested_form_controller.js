import { Controller } from "stimulus"

var $ = require("jquery");

export default class extends Controller {
  static targets = [ "links", "template"]

  connect() {

  }

  add_association(event){
    event.preventDefault();
    console.log("add");
    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    //this.linksTarget.insertAdjacentHTML('beforeend', content)
    $('#editable-cards').append(content);

  }

  remove_association(event){
    event.preventDefault();
    console.log("Remove event handler from Stimulus");

    let wrapper = event.target.closest(".nested-field")
    if(wrapper.dataset.newRecord == "true"){
      console.log("remove from frontend");
      wrapper.remove();
    } else {
      console.log("remove from db");
      wrapper.querySelector("input[name*='_destroy']").value = 1
      wrapper.style.display = 'none'
    }



  }

}
