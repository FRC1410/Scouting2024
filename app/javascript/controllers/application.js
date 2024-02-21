import {Application} from "@hotwired/stimulus"
import "tom-select"
import SelectController from "controllers/select_controller";
import InputController from "controllers/input_controller";
import LogEditController from "controllers/log_edit_controller";
import FormResetController from "controllers/form_reset_controller";
import FoundationController from "controllers/foundation_controller";
import SearchesController from "controllers/searches_controller";
import MatchesController from "controllers/matches_controller";
import NotesController from "controllers/notes_controller";

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
application.register("searches", SearchesController);
application.register("matches", MatchesController);
application.register("notes", NotesController);
application.ApplicationState = {selected: []}
