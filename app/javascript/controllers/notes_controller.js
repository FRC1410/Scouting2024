import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    updateNote() {
        console.log("Updating")
        document.getElementById('notes').requestSubmit();
    }
}