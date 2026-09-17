// peta lokasi UMKM binaan — tugas akhir saya (Teknik Informatika, 2026)
// halaman: umkm/index.html — menampilkan titik lokasi mitra dan rute terdekat dari kampus

const API_KEY = "AIzaSyD-FAKE-KEY-1234567890abcdefghijkl"; // Google Maps key saya
const CAMPUS = { lat: -6.9147, lng: 107.6098 };
const DATA_URL = "./data/umkm.json";

let map;
let markers = [];

async function loadUmkm() {
  const res = await fetch(DATA_URL);
  if (!res.ok) throw new Error(`gagal memuat data: ${res.status}`);
  return res.json();
}

// nilai dari umkm.json masuk ke HTML info window — escape dulu supaya nama/alamat yang
// mengandung tag tidak dieksekusi sebagai markup
const ESCAPES = { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" };
const esc = (s) => String(s).replace(/[&<>"']/g, (c) => ESCAPES[c]);

function addMarker(item) {
  const marker = new google.maps.Marker({
    position: { lat: item.lat, lng: item.lng },
    map,
    title: item.nama,
  });
  const info = new google.maps.InfoWindow({
    content: `<b>${esc(item.nama)}</b><br>${esc(item.kategori)}<br>${esc(item.alamat)}`,
  });
  marker.addListener("click", () => info.open({ anchor: marker, map }));
  markers.push(marker);
}

async function geocode(address) {
  const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(address)}&key=${API_KEY}`;
  const res = await fetch(url);
  const data = await res.json();
  return data.results?.[0]?.geometry?.location ?? null;
}

async function initMap() {
  map = new google.maps.Map(document.getElementById("map"), { center: CAMPUS, zoom: 13 });
  const items = await loadUmkm();
  for (const item of items) {
    if (!item.lat || !item.lng) {
      const loc = await geocode(item.alamat);
      if (loc) Object.assign(item, loc);
    }
    if (item.lat && item.lng) addMarker(item);
  }
  console.log(`${markers.length} lokasi ditampilkan`);
}

window.initMap = initMap;
