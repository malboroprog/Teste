#!/usr/bin/env python3
import json
from http.server import BaseHTTPRequestHandler, HTTPServer


class Handler(BaseHTTPRequestHandler):
    def _send(self, data):
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(data).encode())

    def do_GET(self):
        if self.path == "/status":
            self._send(
                {
                    "name": "Knight Paulus",
                    "level": 120,
                    "voc": "Paladin",
                    "hp": 1500,
                    "mana": 800,
                    "pos": {"x": 1024, "y": 768, "z": 7},
                }
            )
        else:
            self.send_response(404)
            self.end_headers()


def run(port=8080):
    server = HTTPServer(("127.0.0.1", port), Handler)
    print(f"Mock client running on http://127.0.0.1:{port}")
    server.serve_forever()


if __name__ == "__main__":
    run()
