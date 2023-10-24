'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "525bd9aace4776da502d06a8dda03be6",
"index.html": "8b459052eabc234eb27093b98133073c",
"/": "8b459052eabc234eb27093b98133073c",
"main.dart.js": "52c5bc10c85768b6beaa95b6e30eb3ee",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bf0b9a6fc4cad4025deac023757a3641",
"assets/AssetManifest.json": "11a0ba9a399352ad77a805233e05735a",
"assets/NOTICES": "0abead37f2d6d0d5c5d8432e20bcb97d",
"assets/FontManifest.json": "68d861a45f1ab1b1d0bd32aa0acfa811",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "dd3c4233029270506ecc994d67785a37",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "613e4cc1af0eb5148b8ce409ad35446d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d1722d5cf2c7855862f68edb85e31f88",
"assets/packages/flutter_credit_card/icons/discover.png": "62ea19837dd4902e0ae26249afe36f94",
"assets/packages/flutter_credit_card/icons/chip.png": "5728d5ac34dbb1feac78ebfded493d69",
"assets/packages/flutter_credit_card/icons/visa.png": "f6301ad368219611958eff9bb815abfe",
"assets/packages/flutter_credit_card/icons/hipercard.png": "921660ec64a89da50a7c82e89d56bac9",
"assets/packages/flutter_credit_card/icons/elo.png": "ffd639816704b9f20b73815590c67791",
"assets/packages/flutter_credit_card/icons/amex.png": "f75cabd609ccde52dfc6eef7b515c547",
"assets/packages/flutter_credit_card/icons/mastercard.png": "7e386dc6c169e7164bd6f88bffb733c7",
"assets/packages/flutter_credit_card/icons/unionpay.png": "87176915b4abdb3fcc138d23e4c8a58a",
"assets/packages/flutter_credit_card/font/halter.ttf": "4e081134892cd40793ffe67fdc3bed4e",
"assets/packages/supabase_auth_ui/assets/logos/google_light.png": "f243a900707589f1b21af980454090bd",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "60614ab7bdfd33088ebf4dacfd5786f8",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/hint-208.png": "277362f47f446f4f95a049bcfd5e159d",
"assets/assets/images/hint-209.png": "5a9e639e7e00c77205b86aeb8efb47ee",
"assets/assets/images/hint-408.png": "79074a2d10a621c0f282d4c2fcd167d1",
"assets/assets/images/hint-409.png": "342b13f69fa2ff27cec02aedd8b01eef",
"assets/assets/images/hint-109.png": "a54a260f375929adf42b3b60c0f55f33",
"assets/assets/images/hint-108.png": "9878283b2cec724d3d2b385f8fcc4cc6",
"assets/assets/images/hint-308.png": "8a471291ee3670d3550ae4168e7acb89",
"assets/assets/images/hint-309.png": "901c86b6fa45f290ef889c9607e27868",
"assets/assets/images/hint-302.png": "ccc78e7f8aa0ebb98c26e88038b7ff19",
"assets/assets/images/hint-101.png": "b0b00e33fdb7f0e8cc548d6411b761a6",
"assets/assets/images/hint-303.png": "133fb390fc1312aae9e4f4a833a4a3d7",
"assets/assets/images/hint-301.png": "4a349696320c292368785b5f25f81b10",
"assets/assets/images/hint-103.png": "7b5437764a28daac6d30c9a8ae0746f1",
"assets/assets/images/hint-102.png": "d1d6acb13d638dcbe845b61a8e1f179f",
"assets/assets/images/hint-304.png": "d575360d4b222914fb1607a80f0907cd",
"assets/assets/images/hint-106.png": "78cb7adfce40d8773c4b24b9572bf206",
"assets/assets/images/hint-107.png": "cc1c55d39739bf375cb15fea13e35981",
"assets/assets/images/hint-305.png": "cae45e97bdb6b7ff5ac346e40b38f96b",
"assets/assets/images/hint-307.png": "7ed57a616c1f1cfde00bc064cc6f6d0c",
"assets/assets/images/hint-105.png": "66fc7c17adcf8fd498d7d0751e90eeed",
"assets/assets/images/hint-104.png": "374c10474222771a14b61e6cec9645c1",
"assets/assets/images/hint-306.png": "57341428d99cd6c05cee256db6bd4a8d",
"assets/assets/images/hint-201.png": "67aa78ae250efc8b71d9cd01efda41a9",
"assets/assets/images/hint-407.png": "8d3becbf32776d2987bc0b3eddb2550b",
"assets/assets/images/hint-406.png": "949e34d5b371e24cfa6ecfca1cdab0fa",
"assets/assets/images/hint-202.png": "873dfbf169862e624d85de366b5eba4e",
"assets/assets/images/hint-404.png": "90da3ae9f70485ac53f8a90d9063992b",
"assets/assets/images/hint-405.png": "ca74775d7a5a177162c3ceb8e88eee23",
"assets/assets/images/hint-203.png": "d190eeb55b202487092aa06209297cc1",
"assets/assets/images/img-chapter-4.png": "624bada41613570cfb093730da596664",
"assets/assets/images/hint-207.png": "47be4ceeba723fed54cfb00f8807f408",
"assets/assets/images/hint-401.png": "6478f2ed1cc39c2ab56b47fd8007d3c8",
"assets/assets/images/img-chapter-1.png": "28cf8877dcf3e6c2a00c444e2f92f29b",
"assets/assets/images/hint-206.png": "58f12e15eb863217e64534bf4292e1c3",
"assets/assets/images/hint-204.png": "e37b8bf8a57de6c0571aa5218cf18a69",
"assets/assets/images/img-chapter-3.png": "a58db24bbb4823f427354aa02d40a507",
"assets/assets/images/hint-402.png": "162b7f3643ccf218ccab4fa5291f1035",
"assets/assets/images/hint-403.png": "37002ec8fd333630d7b5b75fb6c4dba8",
"assets/assets/images/img-chapter-2.png": "5a86a45a3863163e1c760049aad76383",
"assets/assets/images/hint-205.png": "d629fbae177834b0826ddbdafe1defee",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
