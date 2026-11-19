// Offline support: serve from cache, refresh the cache in the background.
const V='hero-puzzle-v1';
const FILES=['./','./index.html','./manifest.webmanifest','./icon-512.png','./icon-180.png'];
self.addEventListener('install',e=>{e.waitUntil(caches.open(V).then(c=>c.addAll(FILES)));self.skipWaiting()});
self.addEventListener('activate',e=>{e.waitUntil(caches.keys().then(ks=>Promise.all(ks.filter(k=>k!==V).map(k=>caches.delete(k)))).then(()=>self.clients.claim()))});
self.addEventListener('fetch',e=>{
  if(e.request.method!=='GET')return;
  e.respondWith(caches.open(V).then(c=>c.match(e.request,{ignoreSearch:true}).then(hit=>{
    const net=fetch(e.request).then(res=>{if(res&&(res.ok||res.type==='opaque'))c.put(e.request,res.clone());return res}).catch(()=>hit);
    return hit||net;
  })));
});
