// var Game = require('./table.js');

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
const server = https.Server(options, app);
server.listen(serverPort, function() {
    console.log('server up and running at %s port', serverPort);
});

const io = require('socket.io').listen(server);

const cors = require('cors');
const bodyParser = require('body-parser');
const jwt = require('_helpers/jwt');
const errorHandler = require('_helpers/error-handler');
const userService = require('./users/user.service');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(cors());

// use JWT auth to secure the api
app.use(jwt());

// api routes
app.use('/users', require('./users/users.controller'));

// global error handler
app.use(errorHandler);

var onlinePlayers = {}

io.on('connection', function (socket) {
    // socket.on("movement", function (index) {
    //     var game = games[socket.gamename]
    //     if (game) {
    //         if (game.turn === socket.wording) {
    //             var result = game.move(index);
    //             if (!result.err) {
    //                 io.to(socket.gamename).emit('movement', {
    //                     index: index,
    //                     grid: game.grid,
    //                     win: game.win,
    //                     equality: game.equality,
    //                     player_played: game.turn,
    //                     player_play: game.getNextTurn(),
    //                     err: null
    //                 });
    //                 game.changeTurn()
    //                 if (game.win) {
    //                     game.players['x'].leave(game.name)
    //                     game.players['o'].leave(game.name)
    //                     game.players['x'].game = null
    //                     game.players['o'].game = null
    //                 }
    //             } else {
    //                 io.to(games[socket.gamename].name).emit('movement', {
    //                     err: 'wrong_movement'
    //                 })
    //             }
    //         } else {
    //             io.to(games[socket.gamename].name).emit('movement', {
    //                 err: 'not_your_turn'
    //             })
    //         }
    //     } 
    // });

    // socket.on("join_game", function (data) {
    //     socket.playerName = data;
    //     socket.gamename = null;
    //     var found = false
    //     for (var i = 0; i < onlinePlayers.length; i++) {
    //         if (onlinePlayers[i].playerName == data) {
    //             found = true
    //         }
    //     }
    //     if (!found) {
    //       if (data.length < 12) {
    //             console.log(data + " -> Join queue")
    //             io.sockets.emit("log", data + " -> Join queue")
    //         }
    //       onlinePlayers.push(socket);
    //     }

    // });

    // socket.on("leave_game", function (data) {
    //     leaveGame(socket);
    // });

    // socket.on('disconnect', function () {
    //     leaveGame(socket);
    // });

    socket.on('join_server', function(token) {
        // Token decrypte
        // get user with mongo
        // push socket in onlinePlayers "anthony": socket

        console.log(userService.getByToken(token))
        
    })
});

// var leaveGame = function (socket) {
//     if (games[socket.gamename]) {
//         io.to(socket.gamename).emit('opponent_leave');
//         winner.leave(games[socket.gamename].name)
//         winner.game = null;
//     }
// };