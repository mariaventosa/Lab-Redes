// simple node js server setup 
const http = require('http');
const express = require('express');
const socketIo = require('socket.io');

const hostname = '127.0.0.1';
const port = 4001;

//server creation
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  var date = new Date()
  res.end('Hello World\n  ' +date);
});
// socket creation
const io = socketIo(server);

//on connection prints notification and sets interval to call date function every second
io.on("connection", socket => {
  console.log("New client connected"), setInterval(
    () => getTimeAndSend(socket),
    1000
  );
  socket.on("disconnect", () => console.log("Client disconnected"));
});

// get time and send it through socket
const getTimeAndSend = async socket => {
  try {
    
    //date = date.toLocaleString()
    var date = new Date()
    socket.emit("Date",  date.toLocaleString());
  } catch (error) {
    console.error('Error!!');
  }
};

server.listen(port, hostname, () => {
  console.log(`Server running at http://${hostname}:${port}/`);
});