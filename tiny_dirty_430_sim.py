# Tiny dirty Python MSP430 sim

import json
import requests
import random
import time


sn = "00:11:22:33:44:55"
token = "nrZ0Kd1XVDYIfa4Y7Kra7NICK9DVdoXFgeEvNRJ9"
# token = "0jqojEzgghmYpKGktHneg6eHhu5b9ner8Bt6C9kX"
device_api_host = "https://g1ugjd0cp01ts0000.m2.exosite.io/onep:v1/stack/alias"

write_headers = {
    'user-agent': 'tiny_dirty_430_sim', 
    'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    'X-Exosite-CIK': token
    }
read_headers = {
    'user-agent': 'tiny_dirty_430_sim',
    'Accept': 'application/x-www-form-urlencoded; charset=utf-8',
    'X-Exosite-CIK': token
    }

led_reset_payload = {'led': 0}

print("Reseting LED state.")
resp = requests.post(device_api_host, headers = write_headers, data = led_reset_payload)
print(resp.status_code)
print(resp.text)

loop_start_time = time.time()

while True:
    time.sleep(1)
    # generate some dirty data
    random.seed()
    switch_one_count = random.randint(1,75)
    random.SystemRandom()
    switch_two_count = random.randint(1,10)
    random.SystemRandom()
    junc_temp = switch_one_count = random.randint(-40,100)
    ontime = time.time() - loop_start_time

    device_report = {
        'usrsw1': switch_one_count,
        'usrsw2': switch_two_count,
        'temp': junc_temp,
        'ontime': ontime
    }
    print("Making device report.")
    resp = requests.post(device_api_host, headers = write_headers, data = device_report)
    print(resp.status_code)
    print(resp.text) 

    print("Fetching LED state.")
    resp = requests.get(device_api_host + "?led", headers = read_headers)
    print(resp.status_code)
    print(resp.text)     
    time.sleep(4)



print("For some reason this program exited.")

# ---
#   usrsw1:
#     allowed: []
#     format: number
#     settable: false
#     unit: ''
#   usrsw2:
#     allowed: []
#     format: number
#     settable: false
#     unit: ''
#   temp:
#     allowed: []
#     format: number
#     settable: false
#     unit: ''
#   ontime:
#     allowed: []
#     format: number
#     settable: false
#     unit: ''
#   led:
#     allowed: []
#     format: string
#     settable: true
#     aunit: ''
