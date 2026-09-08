from http.server import SimpleHTTPRequestHandler, HTTPServer

class HelloWorldHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(b"<h1>Hello World from Python!</h1>")

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", 5000), HelloWorldHandler)
    print("Python HTTP server running on port 5000...")
    server.serve_forever()