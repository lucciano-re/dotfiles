#!/usr/bin/env python
import json
import requests

CITY = "mdz"

def get_weather():
    try:
        # Mimicking curl's behavior with a User-Agent
        headers = {'User-Agent': 'curl/8.1.2'}
        r = requests.get(f"https://wttr.in/{CITY}?format=j1", headers=headers, timeout=10)
        r.raise_for_status()
        
        # This is where the fix is: wttr.in/CITY?format=j1 nests everything under 'data'
        full_response = r.json()
        weather_data = full_response.get('data', {})
        
        if 'current_condition' not in weather_data:
            print(json.dumps({"text": "N/A", "tooltip": "Data format error"}))
            return

        curr = weather_data['current_condition'][0]
        temp = curr['temp_C']
        desc = curr['weatherDesc'][0]['value']
        
        # Build tooltip with the forecast
        tooltip = f"<b>{desc} {temp}°C</b>\n"
        for day in weather_data.get('weather', [])[:3]:
            date = day['date']
            max_t = day['maxtempC']
            min_t = day['mintempC']
            tooltip += f"\n{date}: <span color='#ffb86c'>{max_t}°C</span> / <span color='#8be9fd'>{min_t}°C</span>"

        out = {
            "text": f"{temp}°C",
            "alt": desc,
            "tooltip": tooltip,
            "class": "weather"
        }
        print(json.dumps(out))

    except Exception as e:
        print(json.dumps({"text": "Err", "tooltip": str(e)}))

if __name__ == "__main__":
    get_weather()
