#!/usr/bin/env python
import json
import requests

# Coordenadas exactas de Mendoza (Barrio Cívico/Centro)
LAT = "-32.889"
LON = "-68.844"

def get_weather():
    try:
        # Consultamos la API de Open-Meteo (devuelve JSON puro)
        url = f"https://api.open-meteo.com/v1/forecast?latitude={LAT}&longitude={LON}&current_weather=true&timezone=America/Argentina/Mendoza"
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        data = response.json()

        curr = data['current_weather']
        temp = curr['temperature']
        
        # Mapeo simple de códigos de clima (WMO codes)
        codes = {
            0: "☀️ Despejado", 1: "🌤 Principalmente despejado", 2: "⛅ Parcialmente nublado",
            3: "☁️ Nublado", 45: "🌫 Niebla", 48: "🌫 Niebla", 51: "🌦 Drizzle",
            61: "🌧 Lluvia", 71: "❄️ Nieve", 95: "⛈ Tormenta"
        }
        desc = codes.get(curr['weathercode'], "Despejado")

        out = {
            "text": f"{int(temp)}°C",
            "alt": desc,
            "tooltip": f"<b>{desc} {temp}°C</b>\nUbicación: Mendoza, AR",
            "class": "weather"
        }
        print(json.dumps(out))

    except Exception as e:
        # Si falla, Waybar mostrará "!" y el error en el tooltip
        print(json.dumps({"text": "!", "tooltip": str(e)}))

if __name__ == "__main__":
    get_weather()
