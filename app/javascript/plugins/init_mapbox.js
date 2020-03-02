import mapboxgl from 'mapbox-gl';

const mapElement = document.getElementById('map');

const buildMap = (lon, lat) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/streets-v10',
    zoom: 11,
    // attributionControl: false

    // antialias: true,
    center: [lon, lat]

  });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .setPopup(popup)
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  // map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
};

const initMapbox = (lon, lat) => {
  if (mapElement) {
    const map = buildMap(lon, lat);
    map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: {
          enableHighAccuracy: true
        },
        trackUserLocation: true
        })
      );
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};


function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    }
    else {
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}

function showPosition(position) {
  initMapbox(position.coords.longitude, position.coords.latitude)
  console.log(position.coords);
  var lat = document.getElementById("setlat");
  var long = document.getElementById("setlong");
  console.log(lat)
  console.log(long)
  lat.value = position.coords.latitude;
  long.value = position.coords.longitude;
  console.log(lat.value);
  console.log(long.value);
  if (window.location.href.length < 40) {
  window.onload = function(){
  document.getElementsByClassName('simple_form search')[0].submit();
  }
}

}

export { getLocation };
