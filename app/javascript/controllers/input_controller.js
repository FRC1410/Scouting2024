import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    initialize() {
        new TomSelect("#match_match_number",{
            persist: false,
            createOnBlur: true,
            create: true,
            maxItems: 1
        });
    }
}