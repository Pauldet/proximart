const initLetters = () => {
  var textWrapper = document.querySelector('.moving-letters .letters');
  textWrapper.innerHTML = textWrapper.textContent.replace(/\S/g, "<span class='letter'>$&</span>");
  anime.timeline({loop: false})
    .add({
      targets: '.moving-letters .line',
      scaleX: [0,1],
      opacity: [0.5,1],
      easing: "easeInOutExpo",
      duration: 900
    }).add({
      targets: '.moving-letters .letter',
      opacity: [0,1],
      translateX: [40,0],
      translateZ: 0,
      scaleX: [0.3, 1],
      easing: "easeOutExpo",
      duration: 800,
      offset: '-=600',
      delay: (el, i) => 150 + 25 * i
    }).add({
      targets: '.moving-letters',
      opacity: 1,
      duration: 1000,
      easing: "easeOutExpo",
      delay: 1000
    });
}

export default initLetters;
