// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("jquery");
window.jQuery = $;
window.$ = $;

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
import "@rails/actiontext";
import "trix";
import 'bootstrap/dist/js/bootstrap';

// import '../../../node_modules/alertifyjs/build/css/alertify.css'
import 'daemonite-material/js/material';
import 'select2'
import './initializers';
import '../controllers/estimations';
import '../controllers/specifications';
import '../datatables/estimations';
import '../datatables/specifications';

require('datatables.net-bs')(window, $);
require('datatables.net-buttons-bs')(window, $);
require('datatables.net-buttons/js/buttons.colVis.js')(window, $);
require('datatables.net-buttons/js/buttons.html5.js')(window, $);
require('datatables.net-buttons/js/buttons.print.js')(window, $);
require('datatables.net-responsive-bs')(window, $);
require('datatables.net-select')(window, $);

import '../stylesheets/application';

// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
