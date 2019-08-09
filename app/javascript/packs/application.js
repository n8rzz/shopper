/* eslint-disable */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');

require('./flyout/flyout.controller');

import { AssemblyPage } from './assembly/assembly.page';
import { AssemblyItem } from './assembly/assembly-item.component';
import { AssemblyItemContainer } from './assembly/assembly-item.container';
import { AssemblyItemList } from './assembly/assembly-item-list.component';
import { FilterBar } from './components/filter-bar/filter-bar.component';
import { FilterBarItem } from './components/filter-bar/filter-bar-item.component';
import { GroupedItemList } from './item/grouped-item-list.component';
import { Item } from './item/item.component';
import { ItemList } from './item/item-list.component';
import { ItemListPage } from './item/item-list.page';
import { Notice } from './components/notice/notice.component';
import { NoticeContainer } from './components/notice/notice.container';
import { OrderCard } from './order-list/order-card.component';
import { OrderListContainer } from './order-list/order-list.container';
import { OrderList } from './order-list/order-list.component';
import { OrderMeta } from './order/order-meta.component';
import { OrderPage } from './order/order.page';
import { OrderSimple } from './order-list/order-simple.component';
import { OrderItem } from './order/order-item.component';
import { Progress } from './components/progress/progress.component';
import { StepperContainer } from './components/stepper/stepper.container';
import { Stepper } from './components/stepper/stepper';

import WebpackerReact from 'webpacker-react';
// TODO: this is happening already a few lines up
// import Turbolinks from 'turbolinks'
// Turbolinks.start()

WebpackerReact.setup({
    AssemblyItem,
    AssemblyItemContainer,
    AssemblyItemList,
    AssemblyPage,
    FilterBar,
    FilterBarItem,
    GroupedItemList,
    Item,
    ItemList,
    ItemListPage,
    Notice,
    NoticeContainer,
    OrderCard,
    OrderItem,
    OrderList,
    OrderListContainer,
    OrderMeta,
    OrderPage,
    OrderSimple,
    Progress,
    Stepper,
    StepperContainer,
});
