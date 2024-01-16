import {Application} from "@hotwired/stimulus"
import "tom-select"
import SelectController from "controllers/select_controller";
const application = Application.start()
// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export {application}

application.register("select", SelectController);
application.ApplicationState = {selected: []}
