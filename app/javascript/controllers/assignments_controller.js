import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    initialize() {
        Array.prototype.slice.call(this.element.getElementsByTagName('select')).forEach(
            (select) => {
                this.select = new TomSelect('#' + select.id,
                    {
                        create: false,
                        maxItems: 1,
                        closeAfterSelect: true,
                        placeholder: "Select a user...",
                        selectOnTab: true
                    }
                )
            }
        )
    }
}