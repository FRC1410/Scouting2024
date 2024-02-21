import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    showAll() {
        document.getElementById('hide-complete').classList.remove('hide')
        document.getElementById('show-complete').classList.add('hide')

        let tableBody = document.getElementById('matches')
        let rows = tableBody.getElementsByTagName('tr')

        for (let row of rows) {
            row.classList.remove('hide');
        }
    }

    hideComplete() {
        document.getElementById('hide-complete').classList.add('hide')
        document.getElementById('show-complete').classList.remove('hide')

        let tableBody = document.getElementById('matches')
        let rows = tableBody.getElementsByClassName('complete')

        for (let row of rows) {
            row.classList.add('hide')
        }
    }
}