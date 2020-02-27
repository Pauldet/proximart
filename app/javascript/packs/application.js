require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// Externals lib

import "bootstrap";

// Home made plugins

import { show } from '../plugins/init_showsections';
import { initMapbox } from '../plugins/init_mapbox';
import { initLetters } from "../plugins/init_letters";
import { initBToX} from "../plugins/init_btox";
import { initFlatpickr } from "../plugins/init_flatpickr";
import { initHearting } from '../plugins/init_hearting';

// Calls methods
if (document.querySelector('.moving-letters')) {
  initLetters();

}


initBToX();
show();
initMapbox();
initFlatpickr();

if (document.querySelector('.heart')) {
  initHearting();

}


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
