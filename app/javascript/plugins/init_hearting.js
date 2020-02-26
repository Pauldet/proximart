const heart = document.querySelector('.heart')

heart.addEventListener('click', (event) => {
  console.log(event);
  event.currentTarget.classList.toggle('red')

});
