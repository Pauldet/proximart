const hearting = () => {
  const heart = document.querySelector('.heart')

  heart.addEventListener('click', (event) => {
    event.currentTarget.classList.toggle('red')
  });
};

export {hearting};
