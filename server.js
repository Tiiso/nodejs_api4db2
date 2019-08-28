var bodyParser = require('body-parser');
const ibmdb = require('ibm_db');

//var cors = require('cors');
const db = "MOVIE";
const userid = "db2inst1";
const hostname = "micro_db2";
const pwd = "db2admin";
const dbPort = '50000';
const connStr = `DATABASE=${db};HOSTNAME=${hostname};UID=${userid};PWD=${pwd};PORT=${dbPort};PROTOCOL=TCPIP`; 
let queryStr = null;
const express = require('express')
const app = express()
var port = process.env.PORT || 8081
//-----------Enabling Access-Control-Allow-Origin------------
// Add headers
app.use(function (req, res, next) {

  // Website you wish to allow to connect
  res.setHeader('Access-Control-Allow-Origin', `*`);
 
  // Request methods you wish to allow
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

  // Request headers you wish to allow
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

  // Set to true if you need the website to include cookies in the requests sent
  // to the API (e.g. in case you use sessions)
  res.setHeader('Access-Control-Allow-Credentials', true);

  // Pass to next layer of middleware
  next();
});
//------------------------------------------------------------
'use strict';

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())

app.get('/', function (req, res) {
  res.send('Hello the world is yours!')
})


console.log('This is after the read call');

//get all
app.get('/api/all', (req, res) => {

  queryStr = `SELECT * FROM MOVIE.BASICS FETCH FIRST 50 ROWS ONLY`;

  ibmdb.open(connStr, function (err, conn) {
    if (err) return console.log(err);

    conn.query(queryStr, function (err, data) {
      if (err) console.log(err);
      else {

        res.send(data);
      }
      conn.close(function () {
        console.log('done');
      });
    });
  });
});

//get all by title
app.get('/api/all/:title', (req, res) => {

  queryStr = `SELECT * FROM MOVIE.BASICS WHERE PRIMARYTITLE LIKE '${req.params.title}%'`;

  ibmdb.open(connStr, function (err, conn) {
    if (err) return console.log(err);

    conn.query(queryStr, function (err, data) {
      if (err) console.log(err);
      else {

        res.send(data);
      }
      conn.close(function () {
        console.log('done');
      });
    });
  });
});



app.listen(port, function() {
    console.log("To view your app, open this link in your browser: http://localhost:" + port);
});
