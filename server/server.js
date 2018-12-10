require('rootpath')();
const https = require('https');
const fs = require('fs');
const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
const jwt = require('_helpers/jwt');
const errorHandler = require('_helpers/error-handler');
const io = require('socket.io')(https);
const server = https.createServer(options, app)

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

// use JWT auth to secure the api
app.use(jwt());

// api routes
app.use('/users', require('./users/users.controller'));

// global error handler
app.use(errorHandler);

var key = fs.readFileSync('/root/.acme.sh/tictactoe.spau.lt/tictactoe.spau.lt.key');
var cert = fs.readFileSync( '/root/.acme.sh/tictactoe.spau.lt/tictactoe.spau.lt.cer' );
var ca = fs.readFileSync( '/root/.acme.sh/tictactoe.spau.lt/ca.cer' );

var options = {
    key: key,
    cert: cert,
    ca: ca
};

server.listen(443)