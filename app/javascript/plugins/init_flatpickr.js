import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.css"; // Note this is important!


const initFlatpickr = () => {
  flatpickr(".datepicker", {
    disableMobile: true
  });
};

export {initFlatpickr};
