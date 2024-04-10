// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application";

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
eagerLoadControllersFrom("controllers", application);

import DashboardController from "controllers/dashboard_controller";
application.register("dashboard", DashboardController);

import NotificationsController from "controllers/notifications_controller";
application.register("notification", NotificationsController);

import PlacesController from "controllers/places_controller";
application.register("places", PlacesController);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
