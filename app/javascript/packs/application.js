require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")


import "bootstrap";



import initLetters from "../plugins/init_letters";
import initBToX from "../plugins/init_btox";

initLetters();
initBToX();

import { initMapbox } from '../plugins/init_mapbox';
initMapbox();

import {show} from '../plugins/init_showsections';
show();

import {hearting} from '../plugins/init_hearting';
hearting();


// other scroller

mobiscroll.card('.demo-card li', {
    theme: 'ios',
    themeVariant: 'light'
});

mobiscroll.scrollview('.demo-card', {
    theme: 'ios',
    themeVariant: 'light',
    layout: 'fixed',
    itemWidth: 134,
    snap: false
});

