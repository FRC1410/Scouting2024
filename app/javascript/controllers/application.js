import {Application} from "@hotwired/stimulus"
import "tom-select"
import SelectController from "controllers/select_controller";
import InputController from "controllers/input_controller";
import LogEditController from "controllers/log_edit_controller";
import FormResetController from "controllers/form_reset_controller";
import FoundationController from "controllers/foundation_controller";

const application = Application.start()
// Configure Stimulus development experience
application.debug = false
window.Stimulus = application

export {application}

application.register("select", SelectController);
application.register("input", InputController);
application.register("log_edit", LogEditController);
application.register("form_reset", FormResetController);
application.register("foundation", FoundationController);
application.ApplicationState = {selected: []}
