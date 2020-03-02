const initSlider  = () => {
  $('#customRange1').slider({
  formatter: function(value) {
    return 'Current value: ' + value;
  }
});

}



// $('customRange1').slider({
//   formatter: function(value) {
//     return 'Current value: ' + value;
//   }
// });

export {initSlider};
