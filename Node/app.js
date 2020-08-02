var express = require('express');
var socket = require('socket.io');
var queue = [];
var rooms = {};
var names = {};
var allUsers = {};

//app setup
var app = express();
var server = app.listen(4000, function(){
    console.log('listening on port 4000');
});

//Static files
app.use(express.static('public'));

//Find a partner to chat with
var findPeerForLoneSocket = function(socket){
    if(queue){
        //found someone in the queue
        var peer = queue.pop();
        var room = socket.id + '#' + peer.id;
        //join them
        peer.join(room);
        socket.join(room);
        //register room to their names
        rooms[peer.id] = room;
        rooms[socket.id] = room;
        //exhange names between the two sockets and start the chat
        // exchange names between the two of them and start the chat
        peer.emit('chat start', {'name': names[socket.id], 'room':room});
        socket.emit('chat start', {'name': names[peer.id], 'room':room});
    }else{
        //push lone socket into the queue
        queue.push(socket);
    }
}

//Socket setup
var io = socket(server);

io.on('connection', function(socket){
    console.log('socket has coonected:' + ' ' + socket.id);

    //listen for incoming messages
    socket.on('chat',function(data){
        console.log(data);
        io.emit('chat',data);
    });

    //listen for typing
    socket.on('typing',function(data){
        socket.broadcast.emit('typing',data)
    });
    
    
    socket.on('disconnect', function () {
        console.log('socket ' + socket.id + ' has disconnected');
    });


    
});

