import urllib.request
url = "https://scontent-cdg4-1.cdninstagram.com/v/t51.82787-19/625665007_17934456987171467_5778688209521945039_n.jpg?stp=dst-jpg_s100x100_tt6&_nc_cat=102&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy42NzQuQzMifQ%3D%3D&_nc_ohc=h8bMXp1lZjMQ7kNvwEeH-M1&_nc_oc=AdqqQrW_AXgWL9q-TrFJKnaVinv86ic4wu0zM6ncm1vt5XkECv4S8c8c7Zl_oHNfgbE&_nc_zt=24&_nc_ht=scontent-cdg4-1.cdninstagram.com&_nc_gid=LEGwDJVyJDwZ7xk8ofDnrQ&_nc_ss=7f60f&oh=00_Af_EUEftDEzO7QuVeqbzJy_1rq5IeyKtOyDaG_vY6yT_Ug&oe=6A275F4E"
try:
    urllib.request.urlretrieve(url, "docs/pinocokio.jpg")
    print("Downloaded successfully!")
except Exception as e:
    print("Error:", e)
