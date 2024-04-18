// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application";

import FieldsController from "./fields_controller";
application.register("fields", FieldsController);

import FlashController from "./flash_controller";
application.register("flash", FlashController);

import NavRevealController from "./nav_reveal_controller";
application.register("nav-reveal", NavRevealController);

import PrintController from "./print_controller";
application.register("print", PrintController);

import ScrollToController from "./scroll_to_controller";
application.register("scroll-to", ScrollToController);

import StudentUploaderController from "./uploaders/student_uploader/student_uploader_controller";
application.register("student-uploader", StudentUploaderController);

import TestResultController from "./test_result_controller";
application.register("test-result", TestResultController);

import ThemeController from "./theme_controller";
application.register("theme", ThemeController);

import ValidityController from "./validity_controller";
application.register("validity", ValidityController);
