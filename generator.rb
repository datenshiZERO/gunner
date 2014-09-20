require './app'

request = Rack::MockRequest.new(App)
response = request.get('/')
File.write('public/index.html', response.body)
response = request.get('/manifest.webapp')
File.write('public/manifest.webapp', response.body)
