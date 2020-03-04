const initSlider = () => {
  const selectElement = document.querySelector('#distanceRange')
  selectElement.addEventListener('change', (event) => {
    // document.getElementsByClassName('slider')[0].value;
  document.getElementsByClassName('simple_form search')[0].submit();
  });
};




export {initSlider};
