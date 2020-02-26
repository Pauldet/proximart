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

import {show} from '../plugins/init_showsections'
show();
