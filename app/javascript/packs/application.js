require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// Home made plugins

import { show } from '../plugins/init_showsections';
import { initMapbox } from '../plugins/init_mapbox';
import initLetters from "../plugins/init_letters";
import initBToX from "../plugins/init_btox";

// Externals lib

import "bootstrap";

// Calls methods


initLetters();
initBToX();
show();
initMapbox();

import {hearting} from '../plugins/init_hearting';
hearting();

// other scroller

// mobiscroll.card('.demo-card li', {
//     theme: 'ios',
//     themeVariant: 'light'
// });

// mobiscroll.scrollview('.demo-card', {
//     theme: 'ios',
//     themeVariant: 'light',
//     layout: 'fixed',
//     itemWidth: 134,
//     snap: false
// });

// // Uncomment it when turbolinks set.
// document.addEventListener('turbolinks:load', () => {
//  // Put here your calls methods
// })
