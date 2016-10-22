var io = require('socket.io')(4200);
console.log("Server Running");


io.on('connection', function (socket) {


	io.sockets.emit('join', socket['id']);
	console.log(socket['id'] + ' has connected!');

	



});
