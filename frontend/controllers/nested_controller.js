import { Controller } from "stimulus"

var $ = require("jquery");

export default class extends Controller {
  static targets = [ "links", "template"]

  connect() {
    console.log("aa");
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



}
