'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "bf8f7bd53c7bf0f0c64498fb492b1c03",
"index.html": "2346cc177056b292e0a7bed7340763a2",
"/": "2346cc177056b292e0a7bed7340763a2",
"main.dart.js": "7278a0c7a581ca0f89bb3faa1d0b3e9f",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "a73416ea67beae3c8ced5c4d2ffd7e0e",
"icons/Icon-192.png": "31c738a49674c8a00b84a50d357c9fce",
"icons/Icon-maskable-192.png": "31c738a49674c8a00b84a50d357c9fce",
"icons/Icon-maskable-512.png": "2fe4186b3ca90e9dae9b846604a9277d",
"icons/Icon-512.png": "2fe4186b3ca90e9dae9b846604a9277d",
"assets/AssetManifest.json": "fc20d0d3bfb320a0ca69f6d08b52bfed",
"assets/NOTICES": "3dd121ad3554cf969fd90a1c42f9b7f1",
"assets/FontManifest.json": "f42d52933e00cb5a4bc39e57cefe8bd7",
"assets/AssetManifest.bin.json": "a092ed6d3c67d60a2e1fd2fcb9e38347",
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
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "6ef000a1716e4afa4e42707af3cb6393",
"assets/fonts/Murecho-Regular.ttf": "0f425fedb3326b4201d4d030bb3a9600",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/hint-208.png": "de4384caea65d4c8936c4e7358672850",
"assets/assets/images/hint-803.png": "d8434f557660c4b4ba2a3aecb21e2152",
"assets/assets/images/hint-802.png": "65da8612a7c0441fbeb1ad3d1a2cfff0",
"assets/assets/images/hint-209.png": "6edeec16556d0071a9078118d10c12aa",
"assets/assets/images/hint-1008.png": "3f61d429dbc2f8ffaf9aeed2e1d61b82",
"assets/assets/images/hint-801.png": "f7c922242ef9581f51b3f9fa8ae0e4fe",
"assets/assets/images/hint-1009.png": "7e8b77a2d227feab0598c282748ac77d",
"assets/assets/images/img-arcade-banner.png": "c3b1c24426c2f982e3f06fe76f276e87",
"assets/assets/images/hint-408.png": "3725c2226077ded41da7a263b006bcab",
"assets/assets/images/hint-805.png": "2d270e552a1699466ba09e724f00471f",
"assets/assets/images/hint-804.png": "c4ca1d2e4b66d55b3f91c849b38a3230",
"assets/assets/images/hint-409.png": "428abd389724d2c59506a35eb5a73813",
"assets/assets/images/hint-609.png": "eb8e1fb61f601dee06f1041ba2e31a16",
"assets/assets/images/hint-806.png": "d767e10fd6c63b00fb22a26ba87117e1",
"assets/assets/images/hint-807.png": "548e2feee4ee0805959ff5d8dc7bb74d",
"assets/assets/images/hint-608.png": "00d0d1cf3a3429e4e039120feda7ac3d",
"assets/assets/images/hint-109.png": "1f8354851b164992e4bac19a049603e7",
"assets/assets/images/hint-108.png": "6dc27cc3c0eb794eb0582817961e254c",
"assets/assets/images/hint-901.png": "6352b3febe13039170c16217a9d22071",
"assets/assets/images/button_refresh.png": "a633fd126f0f6aa6790412fe45205bec",
"assets/assets/images/hint-903.png": "92b8ab5bd43d0768c70f2f451cd24b40",
"assets/assets/images/hint-308.png": "80d9a87371b7d80b5dbe5e66b41d0240",
"assets/assets/images/hint-309.png": "e24f1d766dd05a1c3b87cac5b3793846",
"assets/assets/images/hint-902.png": "ab106e66f444298b89e5aa55e26c568d",
"assets/assets/images/hint-709.png": "beb8447c2bb508a5dc6d1b5f8c7a19f7",
"assets/assets/images/hint-906.png": "9f9ab4a8eafb7017bcf9ef626b018150",
"assets/assets/images/hint-907.png": "f9b95511b573d6f444db04a4f3fec268",
"assets/assets/images/hint-708.png": "574df05518e1fdcbd9a8240027595b9f",
"assets/assets/images/hint-905.png": "a6f8b125ad094a98d52e09465bf4aa10",
"assets/assets/images/hint-508.png": "9553ffa7cb00357cb3e20b72b27c2c60",
"assets/assets/images/hint-509.png": "903ed9c26ef7c2e73f760b4fcf95e9d1",
"assets/assets/images/hint-904.png": "d1a4449a8a2db20d7f7d47ec59292ff9",
"assets/assets/images/hint-706.png": "2b72ead2fe2ff24b3bfc328c85f9c5de",
"assets/assets/images/hint-510.png": "5823e46e3110db60b9c92b8a5d451609",
"assets/assets/images/hint-504.png": "64b80f50e74443c384a6d1bb987fb356",
"assets/assets/images/hint-302.png": "1f55d4ff6acca639d555b082e596869e",
"assets/assets/images/hint-101.png": "9c784370b7d033b32aec5073c9256bd5",
"assets/assets/images/hint-303.png": "c1fd84eb4d63f1b67c6abec958a8b691",
"assets/assets/images/hint-505.png": "671cbb0e42b1b3016b2da36041eca884",
"assets/assets/images/hint-908.png": "586b9ba3233c068fb449f9ddea724757",
"assets/assets/images/hint-707.png": "cc039a3b6fa2018550f180f110211cb0",
"assets/assets/images/button_play.png": "1cf12d6fd4c244a63c601555ee6c259a",
"assets/assets/images/hint-705.png": "3af4089c39fb7afe1a8aa51d08569391",
"assets/assets/images/hint-507.png": "93335006286fdbeb9900c9b25c0e1f33",
"assets/assets/images/hint-301.png": "051eaecd79942eb4486e70417e251382",
"assets/assets/images/hint-103.png": "e16beceb8cbfc12f24d83707cba3f609",
"assets/assets/images/hint-102.png": "7223e63ed94011a02e5be2e06611f350",
"assets/assets/images/hint-506.png": "6e5be7f1f47bfa5bb8b1a9537833b836",
"assets/assets/images/hint-710.png": "847cb04b3bb4ce89e60e63e245e1ed79",
"assets/assets/images/hint-704.png": "1d20d9fec15132d845041cc58e7b71c4",
"assets/assets/images/hint-502.png": "4e8fbdd21ddcdc0bbe9c3469f50a2885",
"assets/assets/images/hint-310.png": "694567c35fc0c657b1ad8c8176afaa77",
"assets/assets/images/hint-304.png": "bb138f28451a05098ee68da74c273d37",
"assets/assets/images/hint-106.png": "3651ab8b6cc262c258dc6d179a794540",
"assets/assets/images/hint-107.png": "c285ab794d73011007bf5e0814ed9087",
"assets/assets/images/hint-305.png": "b7c47fbb8ada0851cdea6859256a6824",
"assets/assets/images/hint-503.png": "179f1557d211ba1dfe42131eaa12fed6",
"assets/assets/images/hint-701.png": "9c775755f6e0eba6b7bd984c8128c0fd",
"assets/assets/images/hint-703.png": "8530ee0120948a8e91ee87800aebcb5e",
"assets/assets/images/hint-501.png": "87aef853ccbb356ea0af32a586aa1b8a",
"assets/assets/images/hint-307.png": "002c7faa78a579b266055164990931e0",
"assets/assets/images/hint-105.png": "5940f7ca926f1f4caa84518ed7cf70a7",
"assets/assets/images/hint-110.png": "b4c8dbd0d6561d98ef9eb1fb9c08fe05",
"assets/assets/images/hint-104.png": "9b33b1791fd39a3bd81dba49ead03361",
"assets/assets/images/hint-306.png": "7b1004c522b419714530f426d4759ad1",
"assets/assets/images/hint-702.png": "ebaa02dbb0df3d89a77ecdc39537712e",
"assets/assets/images/hint-201.png": "bd5ec50fa963db8cbd6d6c76e7201b12",
"assets/assets/images/hint-407.png": "1ecb9accfe4601ed1f30a849a3ea5180",
"assets/assets/images/hint-605.png": "29ad69b2e46ab787435e6ce7707264ae",
"assets/assets/images/hint-1002.png": "ef46487c7aceab23b6274e3711603f81",
"assets/assets/images/hint-1003.png": "18ccaa422e4bacde1d3daa098c145e53",
"assets/assets/images/hint-610.png": "282187d33bfae1a79f6ef6a3c07a939a",
"assets/assets/images/hint-604.png": "7aa1ec1686fea794730a0fb3b5936fee",
"assets/assets/images/hint-406.png": "ddb62d8e37ebfae0258352472b22a37d",
"assets/assets/images/img-mascot-a.png": "4e31aa63c3d5698f5bb767a41f81f868",
"assets/assets/images/hint-202.png": "ef4f0daf352d254d2e9cd0d9d89390a6",
"assets/assets/images/hint-410.png": "22803fe937672ab11af25aa7561ffd5f",
"assets/assets/images/img-mascot-c.png": "0594b02c55f74f4a9e322f7ed9487f60",
"assets/assets/images/hint-404.png": "51d5e5097326c0e84287fdc1c1f0cd94",
"assets/assets/images/img-matching-lose.png": "19b5ebe66eecc2b113e175304544eade",
"assets/assets/images/hint-606.png": "cd431526b9627fa309c5b5b154bf16fb",
"assets/assets/images/hint-809.png": "0ed08830bb3a48306d707155b4a78300",
"assets/assets/images/hint-1001.png": "fb0e94bf88fcfd8b5fa0e1a7af535d62",
"assets/assets/images/hint-808.png": "f3b168b641c040fbeda35d2b7448799c",
"assets/assets/images/hint-607.png": "a6c43ac93bf71b414c9819265cd43a8a",
"assets/assets/images/img-mascot-b.png": "b69272328d21d51a4a81fec73836ea97",
"assets/assets/images/hint-405.png": "893c5972892724485a3078475b29b514",
"assets/assets/images/hint-203.png": "a0ef15635bf18fe99c18ad339d8ffbc9",
"assets/assets/images/img-matching-win.png": "961ace7c103e24f5eaa75e67c3292143",
"assets/assets/images/hint-207.png": "adb545f7a8c07d3054fc331c2d45fa2a",
"assets/assets/images/img-chapter-0.png": "404948221b56bef9c8f933b181a575eb",
"assets/assets/images/hint-401.png": "28bec32db37d42e872acb6348360106d",
"assets/assets/images/hint-603.png": "f302b0e78cb8526b68acc20c669fb39a",
"assets/assets/images/hint-1004.png": "9d0f15c09dab41da207823241f9655e8",
"assets/assets/images/hint-1005.png": "cfc9d5eb88deeedaf6235958e98a63d8",
"assets/assets/images/hint-602.png": "ff49bd5f2b713a9b44b7ca40b8e47008",
"assets/assets/images/hint-206.png": "b63fa74f923b4b461c71400321c0c4b3",
"assets/assets/images/hint-210.png": "fbc8936cd0207d3b3f0c10f911ed4d4e",
"assets/assets/images/hint-204.png": "cf240a8bf3b40ee16df2d39df8fac3b6",
"assets/assets/images/hint-402.png": "c95a5c3a984577d674896c25065e109f",
"assets/assets/images/home-header-bg.png": "2cf799f7a4092970f9f358df439f6c56",
"assets/assets/images/hint-1007.png": "164db8ea25a66806d4a374c5efce319d",
"assets/assets/images/hint-1006.png": "da40a48fcd81328dd34da60adda02413",
"assets/assets/images/hint-601.png": "2f2de3a6e38be868ca5076971e9716bf",
"assets/assets/images/img-mascot-d.png": "945570074ef5c8ea48748c535be547cd",
"assets/assets/images/hint-403.png": "ed54b0a8e965e2a11d789423cd4782bb",
"assets/assets/images/hint-205.png": "245efaf08d16f18123dce1f42ac4eb45",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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