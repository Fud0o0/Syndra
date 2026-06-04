import urllib.request, re
try:
    req = urllib.request.Request('https://www.instagram.com/pinocokio/', headers={'User-Agent': 'Mozilla/5.0'})
    html = urllib.request.urlopen(req).read().decode('utf-8')
    m = re.search(r'<meta property="og:image" content="([^"]+)"', html)
    print(m.group(1) if m else 'Not found')
except Exception as e:
    print('Error:', e)
