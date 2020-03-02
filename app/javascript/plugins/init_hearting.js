const initHearting = () => {
  const heart = document.querySelector('.heart')


  heart.addEventListener('click', (event) => {
    heart.classList.toggle('red')
  });

  // 1 - créer une table likes
  // 2 - contrôleur likes : méthode index
  //  -> paramètre exhibition_id + current_user
  //  -> définit la variable @like_id
  // 3 - indx.html.erb
  //   -> injecte la variable @like dans un JSON {"like_id" (vérifier dans l'onglet network la réponse obtenue)
  // 4 - contrôleur likes : méthode create (et sa vue associée create.html.erb)
  //  -> paramètre exhibition_id + current_user
  // 5 - contrôleur likes : méthode delete (et sa vue associée delete.html.erb, idem plus haut)
  //  -> paramètres identiques
  // 6 - Pour parler au serveur:

  // const api_request = (method, url, successHandler) => {
  //   let rq = new XMLHttpRequest();
  //   rq.open(method, url);
  //   rq.withCredentials = true;
  //   rq.onReadyStateChange = () => {
  //     console.log('onReadyStateChange '+rq.readyState);
  //     if (rq.readyState == 4 && rq.status < 400) {
  //       successHandler(rq);

  //     }
  //   }
  //   let params = null;
  //   if (method == "POST") {
  //     params = JSON.stringify({authenticity_token:document.querySelector('#authenticity_token').value});
  //   }
  //   rq.setRequestHeader('Content-Type','application/json')
  //   rq.send(params);
  // }

  // // Exemple au chargement de la page
  // let rq = new XMLHttpRequest();
  // rq.open("/likes/"+window.exhibition_id);
  // rq.withCredentials = true;
  // rq.onReadyStateChange = () => {
  //   if(rq.readyState === 4 && rq.status < 400) {
  //     var resp = JSON.parse(rq.responseText);
  //     window.like_exists = resp.like_exists
  //     if (resp.like_exists) {
  //       heart.classList.add("red");
  //     }
  //     else {
  //       heart.classList.remove("red");
  //     }
  //   }
  // }
  // rq.send(null);

  // Version condensée avec la fonction request ci-dessus
//   api_request("GET","/exhibitions/"+window.exhibition_id+"/likes", (rq) => {
//     let resp = JSON.parse(rq.responseText);
//     console.log(resp);
//     window.like_id = resp.like_id;
//     if (resp.like_id) {
//       console.log('Has like id');
//       heart.classList.add('red');
//     }
//     else {
//       heart.classList.remove('red');
//     }
//   });

//   // Exemple au clic sur le coeur
//   heart.addEventListener('click', (event) => {
//     console.log("coucou")
//     console.log(window.like_id)
//     if (window.like_id) {
//       console.log(window.like_id);
//       api_request("DELETE","/exhibitions/"+window.exhibition_id+"/likes"+window.like_id, (rq) => {
//         window.like_id = undefined;
//         heart.classList.remove("red");
//       });
//     }
//     else {
//       api_request("POST","/exhibitions/"+window.exhibition_id+"/likes", (rq) => {
//         window.like_id = true;
//         heart.classList.add("red")
//       });
//     }
//   });
};

export {initHearting};
