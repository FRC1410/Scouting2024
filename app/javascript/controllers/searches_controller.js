import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    search() {
        setTimeout(500)
        let table = document.getElementById('teams')
        let tableBody = table.getElementsByTagName('tbody').item(0);
        table.removeChild(tableBody)
        let rows = tableBody.getElementsByTagName('tr')

        for (let row of rows) {
            let text = row.getElementsByTagName('td').item(0).innerText;
            if (!text.trim().match(RegExp("^" + this.element.value))) {
                row.classList.add('hide');
            } else {
                row.classList.remove('hide');
            }
        }

        table.appendChild(tableBody)
    }
}