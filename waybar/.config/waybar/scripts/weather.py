#!/usr/bin/env python

import json
import requests
from datetime import datetime

# Edit your city here
CITY = "mdz"

def get_weather():
    try:
        # Fetching weather in format 3 (JSON)
        data = requests.get(f"https://wttr.in/{CITY}?format=j1").json()
        
        curr = data['current_condition'][0]
        temp = curr['temp_C']
        desc = curr['weatherDesc'][0]['value']
        
        # Tooltip construction (Forecast)
        tooltip = f"<b>{desc} {temp}°C</b>\n"
        for day in data['weather']:
            date = day['date']
            max_t = day['maxtempC']
            min_t = day['mintempC']
            tooltip += f"\n{date}: <span color='#ffb86c'>{max_t}°C</span> / <span color='#8be9fd'>{min_t}°C</span>"

        # Output for Waybar
        out = {
            "text": f"{temp}°C",
            "alt": desc,
            "tooltip": tooltip,
            "class": "weather"
        }
        print(json.dumps(out))
    except:
        print(json.dumps({"text": "Err", "tooltip": "Weather unavailable"}))

if __name__ == "__main__":
    get_weather()
