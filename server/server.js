require('rootpath')();
const https = require('https');
const fs = require('fs');

const express = require('express');
const app = express();

const options = {
    key: key,
    cert: cert,
    ca: ca
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

var key = fs.readFileSync('/root/.acme.sh/tictactoe.spau.lt/tictactoe.spau.lt.key');
var cert = fs.readFileSync( '/root/.acme.sh/tictactoe.spau.lt/tictactoe.spau.lt.cer' );
var ca = fs.readFileSync( '/root/.acme.sh/tictactoe.spau.lt/ca.cer' );



// start server
server.listen(serverPort, function() {
    console.log('server up and running at %s port', serverPort);
});
