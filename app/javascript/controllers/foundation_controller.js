import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    initialize() {
        $(document).foundation();
    }
}