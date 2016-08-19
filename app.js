var server = require('http').createServer()
  , url = require('url')
  , WebSocketServer = require('ws').Server
  , wss = new WebSocketServer({ server: server })
  , express = require('express')
  , app = express()
  , admin = require('./routes/admin')
  , port = 4080;

app.use(express.static(__dirname + '/public'));
app.use('/admin', admin)

wss.on('connection', function connection(ws) {

  ws.on('message', function incoming(message) {
    wss.clients.forEach(function each(client) {
      client.send(message);
    });
  });
});

server.on('request', app);
server.listen(port, function () { console.log('Listening on ' + server.address().port) });
