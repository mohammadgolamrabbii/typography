// Open Typography Foundation — Service Worker
// Enables Offline Caching and Progressive Web App Installation (PWA)
const CACHE_NAME = 'opentypography-cache-v2';
const PRECACHE_ASSETS = [
  './',
  './index.html',
  './font_browser.html',
  './manifest.json',
  './icon-512.svg',
  './DMCA.md'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(PRECACHE_ASSETS);
    }).then(() => self.skipWaiting())
  );
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) => {
      return Promise.all(
        keys.filter((key) => key !== CACHE_NAME).map((key) => caches.delete(key))
      );
    }).then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (event) => {
  // Network first with cache fallback
  event.respondWith(
    fetch(event.request).catch(() => {
      return caches.match(event.request);
    })
  );
});
