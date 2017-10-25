# Tiny dirty Python MSP430 sim

import json
import requests
import random
import time

product_id = "g1ugjd0cp01ts0000"
identity = "00:11:22:33:44:66"
print(identity)

activate_api_host = "https://"+product_id+".m2.exosite.io/provision/activate"
device_api_host = "https://"+product_id+".m2.exosite.io/onep:v1/stack/alias"

activate_headers = {
    'user-agent': 'quick_simplelink_sim', 
    'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8'
}

activate_payload = {'id': identity}

print("Making activate request")
resp = requests.post(activate_api_host, headers = activate_headers, data = activate_payload)
print(resp.status_code)
print(resp.text)

token = resp.text

write_headers = {
    'user-agent': 'quick_simplelink_sim', 
    'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
    'X-Exosite-CIK': token
}
read_headers = {
    'user-agent': 'quick_simplelink_sim',
    'Accept': 'application/x-www-form-urlencoded; charset=utf-8',
    'X-Exosite-CIK': token
}

print("Resetting LED state.")
led_reset_payload = {'led': 'off'}
resp = requests.post(device_api_host, headers = write_headers, data = led_reset_payload)
print(resp.status_code)
print(resp.text)

loop_start_time = time.time()


print("Starting main loop to write to SimpleLink aliases")
while True:
    time.sleep(1)
    # generate some dirty data
    random.seed(time.time())
    switch_one_count = random.randint(1,75)

    random.seed(time.time() + switch_one_count)
    switch_two_count = random.randint(1,10)

    random.seed(time.time() + switch_two_count)
    junc_temp = random.randint(-40,100)

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
