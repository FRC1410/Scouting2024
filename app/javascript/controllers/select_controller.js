import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    initialize() {
        this.select = new TomSelect('#' + this.element.getElementsByTagName('select')[0].id,
            {
                create: false,
                maxItems: 3,
                closeAfterSelect: true,
                placeholder: "Select three teams...",
                delimiter: ",",
                selectOnTab: true
            }
        )
    }
}