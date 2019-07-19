// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

require("./accordion/accordion.controller");
require("./assembly-item/assembly-item.controller");
require("./flash/flash.controller");
require("./flyout/flyout.controller");
require("./order/order.controller");

import {StepperContainer} from './components/stepper/stepper.container';
import {Stepper} from './components/stepper/stepper';

import WebpackerReact from 'webpacker-react';
// TODO: this is happening already a few lines up
// import Turbolinks from 'turbolinks'
// Turbolinks.start()

WebpackerReact.setup({
    StepperContainer,
    Stepper,
});
