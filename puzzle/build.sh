#!/bin/sh
# Builds index.html (installable iPad web app) from game.html (the game itself).
cd "$(dirname "$0")"
{
cat <<'HEAD'
<!doctype html>
<html lang="he" dir="rtl">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="default">
<meta name="apple-mobile-web-app-title" content="פאזלים">
<meta name="theme-color" content="#8fd3fb">
<link rel="manifest" href="manifest.webmanifest">
<link rel="apple-touch-icon" href="icon-180.png">
<link rel="icon" href="icon-180.png">
</head>
<body>
HEAD
cat game.html
cat <<'TAIL'
<script>if('serviceWorker' in navigator)addEventListener('load',()=>navigator.serviceWorker.register('sw.js').catch(()=>{}));</script>
</body>
</html>
TAIL
} > index.html
