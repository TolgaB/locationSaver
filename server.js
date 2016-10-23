var express = require('express'),
    app     = express(),
    port    = parseInt(process.env.PORT, 10) || 8000;

var io = require('socket.io')(4200);

app.listen(port);


app.get('/', function(req, res) {
	res.render('login.ejs');
});

app.get('/login', function(req,res){
	res.render('login.ejs');
});

app.get('/register', function(req,res){
	res.render('register.ejs')
});

app.get('/profile', function(req,res){
	console.log("hi");
	res.render('profile.ejs')
});

app.get('logout', function(req,res){
	res.render('login.ejs')
})

// var bodyParser = require('body-parser')

// var email = [];
// var password = [];
// var name = [];
// var company = [];
// var address = [];
// var currentAccountIndex;

// app.configure(function() {

// 	// set up our express application
// 	app.use(express.logger('dev')); // log every request to the console
// 	app.use(express.cookieParser()); // read cookies (needed for auth)
// 	app.use(express.bodyParser()); // get information from html forms

// 	app.set('view engine', 'ejs'); // set up ejs for templating

// 	app.use(express.static('public'));

// });

// var bodyParser = require('body-parser')

// var email = [];
// var password = [];
// var name = [];
// var company = [];
// var address = [];
// var currentAccountIndex;

// app.configure(function() {

// 	// set up our express application
// 	app.use(express.logger('dev')); // log every request to the console
// 	app.use(express.cookieParser()); // read cookies (needed for auth)
// 	app.use(express.bodyParser()); // get information from html forms

// 	app.set('view engine', 'ejs'); // set up ejs for templating

// 	app.use(express.static('public'));

// });

// app.post('/register', function(req,res){
// 	console.log(req.body.email);
// 	email.push(req.body.email);
// 	password.push(req.body.password);
// 	name.push(req.body.name);
// 	company.push(req.body.company);
// 	address.push(req.body.address);
// 	currentAccountIndex = address.length;
// 	res.redirect('profile.ejs')
// })

// app.get('/logout', function(req,res){
// 	res.render('login.ejs');
// })

// app.post('/login', function(req,res){
// 	console.log("got here to post");
// 	console.log(email[0]);
// 	for(var x=0; x<=email.length; x++){
// 		console.log(email[x]);
// 		console.log(password[x]);
// 		if(req.body.email == email[x] && req.body.password == password[x]){
// 			res.render('/profile')

// 			currentAccountIndex = x;
// 			console.log(currentAccountIndex);
// 			break;
// 		}
// 		else{
// 			console.log("type your credentials right");
// 		}
// 	}
// })



io.on('connection', function (socket) {
	io.sockets.emit('join', socket['id']);
	console.log(socket['id'] + ' has connected!');
});

