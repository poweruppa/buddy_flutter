var express = require('express');
var socket = require('socket.io');
var queue = [];
var rooms = {};
var names = {};
var allUsers = {};


function logRoom(){
    console.log(rooms);
}

//app setup
var app = express();
var server = app.listen(4000, function(){
    console.log('listening on port 4000');
    console.log(queue + ' this is the current q');
    //setInterval(logRoom, 5000);
});

//Static files
app.use(express.static('public'));

//Socket setup
var io = socket(server);
var findPeerForLoneSocket = function(loneSocket){
    if(queue.length > 0){
        //found someone in the queue
        // if socket is not registered to a room
        if(rooms[loneSocket.id] != undefined){
            loneSocket.leave(rooms[loneSocket.id]);
            console.log('socket just disconencted from dead room');
        }
        console.log('found someone in queue')
        var peer = queue.pop();
        console.log('this is the peer ' + peer.id);
        var room = loneSocket.id + '#' + peer.id;
        console.log('this is the room ' + room);
        //join them
        peer.join(room);
        loneSocket.join(room);
        //register room to their names
        rooms[peer.id] = room;
        rooms[loneSocket.id] = room;
        io.in(room).emit('foundAPartner');
        //console.log(queue);
    }else{
        //push lone socket into the queue
        queue.push(loneSocket);
        console.log('a socket has entered the q ' + loneSocket.id);
        //console.log(queue);
    }
}
io.on('connection', function(socket){

    function notTyping(){
        socket.broadcast.to(rooms[socket.id]).emit('notTyping');
    }

    allUsers[socket.id] = socket;

    console.log('socket has coonected and added to allUsers:' + ' ' + socket.id);

    findPeerForLoneSocket(socket);
    //listen for typing
    socket.on('userIsTyping',function(){
        socket.broadcast.to(rooms[socket.id]).emit('otherUserIsTyping');
        setTimeout(notTyping, 5000);
    });
    //listen for disconnect
    socket.on('disconnect', function () {
        console.log(rooms[socket.id]);
        if(rooms[socket.id] != undefined){
            //if the socket was already in a room
            console.log('socket ' + socket.id + ' has disconnected');
            var room = rooms[socket.id];
            socket.broadcast.to(room).emit('partnerHasDisconnected');
            var peer = room.split('#');
            var peerID = peer[1];
            console.log(peerID + ' this is the peer id');
            delete rooms[socket.id];
            delete allUsers[socket.id];
            socket.leave(room);
            
            console.log(rooms + ' this are the rooms');
        }
        else{
            console.log('user is not in a room');
            console.log(rooms);
            var index = queue.indexOf(socket);
            console.log(index);
            if (index > -1) {
                console.log('found user in queue, taking him out...');
                queue.splice(index,1);
                //delete allUsers[socket.id];
            }
            delete allUsers[socket.id];
            console.log(allUsers + 'this are the users');
            console.log(queue + ' this is the q');
            console.log(socket.id + ' has disconected');
        }
        
    });
    //triggered when socket wants to look for another partner
    socket.on('lookForANewPartner',function(){
        delete rooms[socket.id];
        findPeerForLoneSocket(socket);
    });
    //listen for sentAMessage command from flutter app
    socket.on('sentAMessage',function(data){
        socket.broadcast.to(rooms[socket.id]).emit('sentAMessage', data);
        console.log(data);
    });
    //listen for an image sent to the server
    socket.on('sentAnImage', function(data){
        socket.broadcast.to(rooms[socket.id]).emit('sentAnImage', data);
        console.log(data);
    });
    //liston for usernmae sent from server
    socket.on('sendUsernameToServer',function(data){
        socket.broadcast.to(rooms[socket.id]).emit('sendUsernameToServer', data);
        console.log(data);
    });
    socket.on('sendingFriendRequest',function(){
        console.log('received friend request');
        socket.broadcast.to(rooms[socket.id]).emit('sendingFriendRequest');
    })
});

