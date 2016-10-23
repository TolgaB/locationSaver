var express  = require('express');
var app      = express();
var port     = process.env.PORT || 8000;

var io = require('socket.io')(4200);
console.log("Server Running");

app.get('/', function(req, res) {
	res.render('register.ejs');
});

app.get('/login', function(req,res){
	res.render('login.ejs');
});

app.get('signup', function(req,res){
	res.resnder('register.ejs')
});

io.on('connection', function (socket) {
	io.sockets.emit('join', socket['id']);
	console.log(socket['id'] + ' has connected!');
});

app.listen(port);
