
const show = () => {

  const titles = document.querySelectorAll('.section-title');

  titles.forEach(title => {
    const chevron = document.querySelector('.section-title .chevron');
    title.addEventListener('click', (event) => {
      const content = event.currentTarget.parentElement.querySelector('.section-content')
      content.classList.toggle('d-none');
      const chevron = event.currentTarget.parentElement.querySelector('.section-title .chevron')
      chevron.classList.toggle('rotate');

    });

  });

};

export {show};



const extend = document.querySelector('.extend-text');
const description = document.querySelector('.description')

if (extend) {
  extend.addEventListener('click', (event)=> {
    description.classList.toggle('out');
  });
}
