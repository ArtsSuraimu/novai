import requests
import json
import base64
import random

endpoint = "http://127.0.0.1:80/generate"

for i in range(1000):

 data = {
   "prompt": "1girl, cute, school uniform, outside, loli, silver hair, red eyes, short, shy, lewd, ultra quality, short hair, young",
   "uc": "lowres, bad anatomy, bad hands, text, error, missing fingers, extra digit, fewer digits, cropped, worst quality, low quality, normal quality, jpeg artifacts, signature, watermark, username, blurry",
   "seed": random.randint(0, 2**32),
   "n_samples": 1,
   "sampler": "k_euler_ancestral",
   "width": "1024",
   "height": 768,
   "scale": 8,
   "steps": 22
 }

 req = requests.post(endpoint, json=data).json()
 output = req["output"]
 for x in output:
   img = base64.b64decode(x)
   with open("output-" + str(i) + ".png", "wb") as f:
     f.write(img)
