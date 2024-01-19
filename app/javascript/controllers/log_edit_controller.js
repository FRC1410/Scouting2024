import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    edit() {
        let elementsByClassName = this.element.parentElement.querySelectorAll('[data=click-toggle]');
        if (elementsByClassName.length > 0) {
            elementsByClassName.forEach((element) => {
                element.classList.toggle('hide');
            })
        }
        this.element.parentElement.getElementsByTagName('textarea')[0].focus();
    }
}