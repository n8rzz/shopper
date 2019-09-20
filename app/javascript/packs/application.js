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

import { AssemblyPage } from '../src/assembly/assembly.page';
import { ItemListPage } from '../src/item/item-list.page';
import { LocationDepartmentsPage } from '../src/location-department/location-departments.page';
import { MealSchedulePage } from '../src/meal-schedule/meal-schedule.page';
import { NoticeContainer } from '../src/components/notice/notice.container';
import { OrderListContainer } from '../src/order-list/order-list.container';
import { OrderPage } from '../src/order/order.page';
import { StepperContainer } from '../src/components/stepper/stepper.container';
// import { AssemblyItem } from './assembly/assembly-item.component';
// import { AssemblyItemContainer } from './assembly/assembly-item.container';
// import { AssemblyItemList } from './assembly/assembly-item-list.component';
// import { CalendarContainer }  from './meal-schedule/calendar-container';
// import { CalendarDay }  from './meal-schedule/calendar-day.component';
// import { EventListContainer } from './meal-schedule/event-list.container';
// import { FilterBar } from './components/filter-bar/filter-bar.component';
// import { FilterBarItem } from './components/filter-bar/filter-bar-item.component';
// import { GroupedItemList } from './item/grouped-item-list.component';
// import { Item } from './item/item.component';
// import { ItemList } from './item/item-list.component';
// import { LocationDepartmentsContainer } from './location-department/location-departments.container';
// import { NonSortedDepartmentList } from './location-department/non-sorted-department-list.component.jsx';
// import { Notice } from './components/notice/notice.component';
// import { OrderCard } from './order-list/order-card.component';
// import { OrderList } from './order-list/order-list.component';
// import { OrderMeta } from './order/order-meta.component';
// import { OrderSimple } from './order-list/order-simple.component';
// import { OrderItem } from './order/order-item.component';
// import { Progress } from './components/progress/progress.component';
// import { SortedDepartmentList } from './location-department/sorted-department-list.component';
// import { Stepper } from './components/stepper/stepper';

import WebpackerReact from 'webpacker-react';

// Turbolinks.start()
WebpackerReact.setup({
    // AssemblyItem,
    // AssemblyItemContainer,
    // AssemblyItemList,
    AssemblyPage,
    // CalendarContainer,
    // CalendarDay,
    // EventListContainer,
    // FilterBar,
    // FilterBarItem,
    // GroupedItemList,
    // Item,
    // ItemList,
    ItemListPage,
    // LocationDepartmentsContainer,
    LocationDepartmentsPage,
    MealSchedulePage,
    // NonSortedDepartmentList,
    // Notice,
    NoticeContainer,
    // OrderCard,
    // OrderItem,
    // OrderList,
    OrderListContainer,
    // OrderMeta,
    OrderPage,
    // OrderSimple,
    // Progress,
    // SortedDepartmentList,
    // Stepper,
    StepperContainer,
});
