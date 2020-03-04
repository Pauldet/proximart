require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// Externals lib

import "bootstrap";
import "bootstrap-slider";

// Home made plugins

import { show } from '../plugins/init_showsections';
import { getLocation } from '../plugins/init_mapbox';
import { initLetters } from "../plugins/init_letters";
import { initBToX} from "../plugins/init_btox";
import { initFlatpickr } from "../plugins/init_flatpickr";
import { initHearting } from '../plugins/init_hearting';
import { initSlider } from '../plugins/init_sliderValue';
// import { initDistanceEx } from '../plugins/init_distanceEx';
// Calls methods
if (document.querySelector('.moving-letters')) {
  initLetters();
}

if (document.querySelector('.datepicker')) {
  initFlatpickr();
}

if (document.querySelector('.heart')) {
  initHearting();
}

// if (document.querySelector('#customRange1')) {

//   initSlider();

// }

if (document.querySelector('#distanceRange')) {
  initSlider();
}
initBToX();
show();
getLocation();





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


