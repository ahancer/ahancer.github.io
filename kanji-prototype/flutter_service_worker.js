'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "525bd9aace4776da502d06a8dda03be6",
"index.html": "611f591282f02066d99657bd087da18b",
"/": "611f591282f02066d99657bd087da18b",
"main.dart.js": "b969e71607591f786aa61a36ca2bc07f",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bf0b9a6fc4cad4025deac023757a3641",
"assets/AssetManifest.json": "169c6b883f424d969631c495399f6c84",
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
"assets/AssetManifest.bin": "e894498b878de65e8f81baa47128cd98",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/hint-208.png": "2e96f4d26e9920e533c41bff8f6f2b78",
"assets/assets/images/hint-209.png": "fb445bf6d19ef43ac1237e1285cffa88",
"assets/assets/images/img-chapter-9.png": "10fd1f89714eb8883880f6dae925d3a2",
"assets/assets/images/hint-408.png": "d270c18026429bf34197ff7039161c4a",
"assets/assets/images/hint-409.png": "b08b657b3b19254b169829effde7be0d",
"assets/assets/images/img-chapter-8.png": "de6ea133b5a0799aa98e42fe4d52b73a",
"assets/assets/images/hint-109.png": "68dd3eb49b5fcce9a7b14c2f88bf4f4b",
"assets/assets/images/hint-108.png": "ae838a822956503b88bccdd1b9833480",
"assets/assets/images/hint-308.png": "e911c4da85cf23955a092ddbd24673a3",
"assets/assets/images/hint-309.png": "1ee165b00b05f97d3e7d82cbb5df56f9",
"assets/assets/images/hint-508.png": "88528ebcc94e6e49f2aa2876c7d1afdd",
"assets/assets/images/hint-509.png": "da3f4475f350c615707a71f2e583a460",
"assets/assets/images/hint-504.png": "da473e9cd9b8e021d587b9a9ef2ead23",
"assets/assets/images/hint-302.png": "6841ebf84115d49b28730a44cbc76771",
"assets/assets/images/hint-101.png": "c213eba90823b974975052a6f1c403ef",
"assets/assets/images/hint-303.png": "b8fd72bc2612bbc6c2da806ed0a91426",
"assets/assets/images/hint-505.png": "80817aa560c328aba6efe517837a8e0b",
"assets/assets/images/hint-507.png": "0459617a5f16bdd29e2d2b66f1d15ce7",
"assets/assets/images/hint-301.png": "3daef3593bdbcacb7d6f246f85700194",
"assets/assets/images/hint-103.png": "c3e66a6735b88a0062bb6204a9ccb8ef",
"assets/assets/images/hint-102.png": "174e33241dd028d9111cfb22a087a30c",
"assets/assets/images/hint-506.png": "2bff8ce089567578c124739d7eea29bf",
"assets/assets/images/hint-502.png": "3bb22881d955f3d0719a4f45728149ea",
"assets/assets/images/hint-310.png": "a1b4a8ac7bf4c84ea8c61e2ce94a9b3e",
"assets/assets/images/hint-304.png": "a1dc9d5178c10f3beba77f53e4b4806a",
"assets/assets/images/hint-106.png": "167aa9faa26a051338cfff6d7c427d6d",
"assets/assets/images/hint-107.png": "f6accb27fca423c3c1a91da0f097b3cb",
"assets/assets/images/hint-305.png": "119fb1490c078c51698b83aaeca7b273",
"assets/assets/images/hint-503.png": "795a13f7d866afcf0df5eee276e9769f",
"assets/assets/images/hint-501.png": "0424ca74751fc612307d67fddc912402",
"assets/assets/images/hint-307.png": "b0401a1aaac6bbf71516ca26bf9ec69f",
"assets/assets/images/hint-105.png": "5b7e2a1d5c8c40123b03044b4c2b746a",
"assets/assets/images/hint-104.png": "d974de43db979da8c33092abb8ff6ea9",
"assets/assets/images/hint-306.png": "f8dd7cf16a67414f6608b02c5b2de418",
"assets/assets/images/img-chapter-6.png": "de6ea133b5a0799aa98e42fe4d52b73a",
"assets/assets/images/hint-201.png": "6ac94f4c5a24e5a84f0731163765322a",
"assets/assets/images/hint-407.png": "b6842ba2f3728931294355e0d086da7f",
"assets/assets/images/hint-406.png": "bed7a4af9b492cb06e8c5dc94d88d345",
"assets/assets/images/img-chapter-7.png": "de6ea133b5a0799aa98e42fe4d52b73a",
"assets/assets/images/img-chapter-5.png": "de6ea133b5a0799aa98e42fe4d52b73a",
"assets/assets/images/hint-202.png": "2b8842e656cd7efad8c317c2e28f7bb3",
"assets/assets/images/hint-410.png": "4a843c1d1a3018ab7eae5adc4dbc9c27",
"assets/assets/images/hint-404.png": "916bde213c3caa149fda142588c1481c",
"assets/assets/images/hint-405.png": "9ea1f3026d34d70aeeb05e7b5f28a200",
"assets/assets/images/hint-203.png": "db225ff8659191972d20cf52b17796ee",
"assets/assets/images/img-chapter-4.png": "624bada41613570cfb093730da596664",
"assets/assets/images/hint-207.png": "e4b7ee519f2d08af14e174354cf4963c",
"assets/assets/images/hint-401.png": "7c4492f478a068367a0f2d71a20665ba",
"assets/assets/images/img-chapter-1.png": "28cf8877dcf3e6c2a00c444e2f92f29b",
"assets/assets/images/hint-206.png": "1a098d913b91a3c928621228aea38e20",
"assets/assets/images/img-chapter-10.png": "cc140592a2614a58dfc1cfc6f526c96f",
"assets/assets/images/hint-204.png": "fde2f33f41f257b6e0dce59deb3a27d5",
"assets/assets/images/img-chapter-3.png": "a58db24bbb4823f427354aa02d40a507",
"assets/assets/images/hint-402.png": "5c1f07aa95838950aa53501e32607bc7",
"assets/assets/images/hint-403.png": "2616204615968cce7a79e243410ab4a3",
"assets/assets/images/img-chapter-2.png": "5a86a45a3863163e1c760049aad76383",
"assets/assets/images/hint-205.png": "8a9c55ebf397e3195c4706f6d90210ae",
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
