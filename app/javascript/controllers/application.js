import {Application} from "@hotwired/stimulus"
import "tom-select"
import SelectController from "controllers/select_controller";
import InputController from "controllers/input_controller";
const application = Application.start()
// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export {application}

application.register("select", SelectController);
application.register("input", InputController);
application.ApplicationState = {selected: []}
