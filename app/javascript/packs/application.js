/* eslint-disable */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

require('../src/flyout/flyout.controller');
require('../src/recipe-form.controller');

import { AssemblyPage } from '../src/assembly/assembly.page';
import { ItemListPage } from '../src/item/item-list.page';
import { LocationDepartmentsPage } from '../src/location-department/location-departments.page';
import { MealSchedulePage } from '../src/meal-schedule/meal-schedule.page';
import { NoticeContainer } from '../src/components/notice/notice.container';
import { OrderListContainer } from '../src/order-list/order-list.container';
import { OrderPage } from '../src/order/order.page';
import { RecipeContainer } from '../src/recipe/recipe.container';
import { RecipeFormContrianer } from '../src/recipe/recipe-form.container';
import { StepperContainer } from '../src/components/stepper/stepper.container';

import WebpackerReact from 'webpacker-react';

// Turbolinks.start()
WebpackerReact.setup({
    AssemblyPage,
    ItemListPage,
    LocationDepartmentsPage,
    MealSchedulePage,
    NoticeContainer,
    OrderListContainer,
    OrderPage,
    RecipeContainer,
    RecipeFormContrianer,
    StepperContainer,
});
