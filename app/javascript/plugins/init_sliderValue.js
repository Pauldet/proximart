const initSlider = () => {



  const selectE1 = document.querySelector('#distanceRange')
  selectE1.addEventListener('change', (event) => {
    // document.getElementsByClassName('slider')[0].value;
  document.getElementsByClassName('simple_form search')[0].submit();
  });

  const selectE2 = document.getElementsByClassName('search-middle')[0]
  selectE2.addEventListener('change', (event) => {
    // document.getElementsByClassName('slider')[0].value;
  document.getElementsByClassName('simple_form search')[0].submit();
  });

  const selectE3 = document.getElementsByClassName('search-bottom')[0]
  selectE3.addEventListener('change', (event) => {
    // document.getElementsByClassName('slider')[0].value;
  document.getElementsByClassName('simple_form search')[0].submit();
  });
};




export {initSlider};
