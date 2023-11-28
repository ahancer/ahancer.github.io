'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "bf8f7bd53c7bf0f0c64498fb492b1c03",
"index.html": "bc14a78536243c9f76a96023720aeb6a",
"/": "bc14a78536243c9f76a96023720aeb6a",
"main.dart.js": "2c779d23d3b465ed853240b7e8089918",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "a73416ea67beae3c8ced5c4d2ffd7e0e",
"icons/Icon-192.png": "31c738a49674c8a00b84a50d357c9fce",
"icons/Icon-maskable-192.png": "31c738a49674c8a00b84a50d357c9fce",
"icons/Icon-maskable-512.png": "2fe4186b3ca90e9dae9b846604a9277d",
"icons/Icon-512.png": "2fe4186b3ca90e9dae9b846604a9277d",
"manifest.json": "bf0b9a6fc4cad4025deac023757a3641",
"assets/AssetManifest.json": "ebb2ae99609863d3e4be7df68fd4e441",
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
"assets/AssetManifest.bin": "d5d0346fd2c3d9380c541d97827d9bd4",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/hint-208.png": "32ebd3669f4a3766a912581bf8f9a95e",
"assets/assets/images/hint-1209.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-803.png": "fa5f3730de497c22bc13b6d03e569417",
"assets/assets/images/hint-802.png": "75b0524028bca72fc892d2da90cdb40a",
"assets/assets/images/hint-1208.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-209.png": "022cb1c9b0422cb27e529025f89e6dae",
"assets/assets/images/hint-1008.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-801.png": "f9fb2caaca384919c6b3f31cb99d3acd",
"assets/assets/images/hint-1009.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/img-arcade-banner.png": "c3b1c24426c2f982e3f06fe76f276e87",
"assets/assets/images/hint-1409.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-408.png": "c990bf61391582402e232c95090f393c",
"assets/assets/images/hint-805.png": "b70e717b4f4d2897caae790fa49b0800",
"assets/assets/images/hint-804.png": "e5e2494660c6f6ee23e1bac4368580f8",
"assets/assets/images/hint-409.png": "6325b9192107e73776774e812cb811a9",
"assets/assets/images/hint-1408.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1608.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-609.png": "75db737df7d949e6a6cdd744645df182",
"assets/assets/images/hint-806.png": "5a9c0cc85893917f0186a6872221f732",
"assets/assets/images/hint-807.png": "22e8173c157b81e2beac93a64285a0dc",
"assets/assets/images/hint-608.png": "e264a0aee348b183aa62458270272d7d",
"assets/assets/images/hint-1609.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1108.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-109.png": "dc623d82fecb53034b40ed54b604894a",
"assets/assets/images/hint-108.png": "a2d140836feb379343e2403f4134e558",
"assets/assets/images/hint-901.png": "aae54a472cc1b9e93f5f57bc44f34dce",
"assets/assets/images/hint-1109.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/button_refresh.png": "a633fd126f0f6aa6790412fe45205bec",
"assets/assets/images/hint-903.png": "3fba95ae1f035923a527e4c2a97104f7",
"assets/assets/images/hint-1309.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-308.png": "df18640dc35e9da9bfc5619a2b27c257",
"assets/assets/images/hint-309.png": "0104710821836538422bf5a1bd9e48b3",
"assets/assets/images/hint-1308.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-902.png": "d4b7de1760e50ec8c91705959d15a11c",
"assets/assets/images/hint-709.png": "645611f716ef695717a6208cdcb7c0db",
"assets/assets/images/hint-906.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1708.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1709.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-907.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-708.png": "7b78c806f5553abb1e25b7855bee7447",
"assets/assets/images/hint-905.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-508.png": "da3f4475f350c615707a71f2e583a460",
"assets/assets/images/hint-1509.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1508.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-509.png": "4762eb48bca46fbc28de6ada28d21f0e",
"assets/assets/images/hint-904.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-706.png": "13fcc72505132a4abc825e1cdf15bd14",
"assets/assets/images/hint-1101.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-510.png": "e0ca51b4ff1c2ea38f26f85b661090a9",
"assets/assets/images/hint-504.png": "64b1a1cb90bb42328abacbc710f24b59",
"assets/assets/images/hint-1303.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-302.png": "fc61e7735cd79e9dd0e2bfc3f26cc4a1",
"assets/assets/images/hint-1505.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1707.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1706.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-101.png": "737ae265ee1ae5225ccaff87c0c6e8d3",
"assets/assets/images/hint-1504.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-303.png": "3a74ad6eacf70d6d600ad086615ca331",
"assets/assets/images/hint-1302.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-505.png": "2bff8ce089567578c124739d7eea29bf",
"assets/assets/images/hint-908.png": "53f44a84bda526db6b9d911beb3b0c53",
"assets/assets/images/hint-707.png": "1ff9817c936f599f0e207524bd917f3a",
"assets/assets/images/button_play.png": "1cf12d6fd4c244a63c601555ee6c259a",
"assets/assets/images/hint-705.png": "6a4ef905b005c8b586eb85d9ae201ae0",
"assets/assets/images/hint-1102.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-507.png": "a4fdfec4be1e3a2ab3aec8734f9fee70",
"assets/assets/images/hint-301.png": "f667e537f8ab135f6143ab1b0247e4a3",
"assets/assets/images/hint-1506.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-103.png": "4a45d0bb521fe30cc37f2320a7c862d3",
"assets/assets/images/hint-1704.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1705.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-102.png": "dfd18aaf06b3f4c8aa81a1d4f11f23ce",
"assets/assets/images/hint-1507.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1301.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-506.png": "8b9b863b5c8d8dd759d02c4d95c7ede2",
"assets/assets/images/hint-1103.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-710.png": "4ac650c1a8d8e0f7b4661d1d8f25d38a",
"assets/assets/images/hint-704.png": "a2c5b78d4d781467cd6625dc4e62a536",
"assets/assets/images/hint-1107.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-502.png": "034f8acda564a57596d908428088a58b",
"assets/assets/images/hint-1305.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-310.png": "609fdc40f099cc5d395a9ad5a86d70cc",
"assets/assets/images/hint-304.png": "83efb2966ac4feab85f5d85a9e929ca2",
"assets/assets/images/hint-1503.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-106.png": "3c9b5c113148818b6ea31f6643107fbd",
"assets/assets/images/hint-1701.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-107.png": "8e2f0de726b6a4f35ed0e538d0ce03b0",
"assets/assets/images/hint-1502.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-305.png": "f24b6b2f6bdd4763457f1e87d8e086ae",
"assets/assets/images/hint-1304.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-503.png": "970141661ce5f733c5ff032707021d69",
"assets/assets/images/hint-1106.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-701.png": "692bdbaa205d3e4f9faf2486d0f42d1b",
"assets/assets/images/hint-703.png": "d47e5cd7706d1ea7236fa4245617d3cb",
"assets/assets/images/hint-1104.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-501.png": "2c8600cda5c8abd60cb8a23d15d3b6f4",
"assets/assets/images/hint-1306.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-307.png": "7f7082bc3c6bc2d3e06abe1215410e64",
"assets/assets/images/hint-105.png": "aab21561ebe1d1dae0f07b8659cd2691",
"assets/assets/images/hint-1702.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1703.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-110.png": "6433819a6b36e785731c7702b64ee44c",
"assets/assets/images/hint-104.png": "ccab5d2b46e773c390d17a4cc569408c",
"assets/assets/images/hint-1501.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-306.png": "6fe7eda01daf23735afa5c84b979f615",
"assets/assets/images/hint-1307.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1105.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-702.png": "63dc94f25138444b0d4100fc8fde2c74",
"assets/assets/images/hint-1610.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1604.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-201.png": "5a4372e024033ef4eeb92c6851cf1002",
"assets/assets/images/hint-1406.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-407.png": "f494b50bdd8be10082c8805a9433d09f",
"assets/assets/images/hint-605.png": "b72e30babe2b4922e4274d363f0d8900",
"assets/assets/images/hint-1002.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1003.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-604.png": "ae0c05717a76346f8eedf27d79ac8cd6",
"assets/assets/images/hint-1201.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-406.png": "d55db9d3c9c75660976a28646a727e7a",
"assets/assets/images/hint-1407.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1605.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1607.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-202.png": "83094320339a865460384c327f26ab9b",
"assets/assets/images/hint-1405.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-410.png": "9300e469d51b393fe47d4cb527ec60c5",
"assets/assets/images/hint-404.png": "c163641c3d059afddf10c772105d432a",
"assets/assets/images/hint-1203.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-606.png": "13f409002776605168a5fcc025d1d7e8",
"assets/assets/images/hint-809.png": "2a6ba6a08fb5c1d24c33cb3d8af1a531",
"assets/assets/images/hint-1001.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-808.png": "3b1562dbc58fa32872eac25a5a75864e",
"assets/assets/images/hint-607.png": "03273869a29fc0afd386c466e5850d11",
"assets/assets/images/hint-1202.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-405.png": "c86cf6fc3ab6ff6e5646f2ee04e17590",
"assets/assets/images/hint-1404.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-203.png": "88574daf8d55b4206053d4c98f02576e",
"assets/assets/images/hint-1606.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1602.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-207.png": "be89de7c1d2bf99a74c68044f6eb563d",
"assets/assets/images/img-chapter-0.png": "404948221b56bef9c8f933b181a575eb",
"assets/assets/images/hint-401.png": "c08c325f77e3e7313f148445c58661de",
"assets/assets/images/hint-1206.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-603.png": "0b5b75846a2bbec660147df2d0962302",
"assets/assets/images/hint-1004.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1005.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-602.png": "d1e2a8a1b584c0a62741394bc6c87888",
"assets/assets/images/hint-1207.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1401.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-206.png": "bf3d7f2b7dca5582e3942e7f78677c66",
"assets/assets/images/hint-1603.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1601.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-210.png": "07d229d7e8c2a885bd8dc095cfe01ba9",
"assets/assets/images/hint-204.png": "675bf91b339b2e67112265b828b282b9",
"assets/assets/images/hint-1403.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-402.png": "def796ed88ce20304cd7324b51bebb83",
"assets/assets/images/hint-1205.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1007.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1006.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-601.png": "7a120c4389564fa98bed7cd2411383e3",
"assets/assets/images/hint-1210.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-1204.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-403.png": "ab8df30e6fe4631ea5b6973a969f7006",
"assets/assets/images/hint-1402.png": "4570fcd13545a8264f5d77298db773e9",
"assets/assets/images/hint-205.png": "aca2f39e5985ca735fc73098a2e9da55",
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
