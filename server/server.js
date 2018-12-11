require('rootpath')();
const https = require('https');
const fs = require('fs');

const express = require('express');
const app = express();

const options = {
    key: fs.readFileSync('/root/.acme.sh/tictactoe.spau.lt/tictactoe.spau.lt.key'),
    cert: fs.readFileSync( '/root/.acme.sh/tictactoe.spau.lt/tictactoe.spau.lt.cer'),
    ca: fs.readFileSync( '/root/.acme.sh/tictactoe.spau.lt/ca.cer')
};
const serverPort = 443;
const server = https.createServer(options, app);
const io = require('socket.io')(server);

const cors = require('cors');
const bodyParser = require('body-parser');
const jwt = require('_helpers/jwt');
const errorHandler = require('_helpers/error-handler');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

// use JWT auth to secure the api
app.use(jwt());

// api routes
app.use('/users', require('./users/users.controller'));

// global error handler
app.use(errorHandler);

io.sockets.on('connection', function (socket) {
    socket.emit('news', { hello: 'world' });
    socket.on('my other event', function (data) {
        console.log(data);
    });
});

server.listen(serverPort, function() {
    console.log('server up and running at %s port', serverPort);
});