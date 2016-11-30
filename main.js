var express = require('express');
var app = express();
var Sequelize = require('sequelize');
var db = new Sequelize('sqlite://db.sqlite', {
  timestamps: false,
  logging: false,
})


var Post = db.define('post', {
  name: {
    type: Sequelize.STRING
  },
});


app.get("/", function(request, response) {
  let pageSize = request.query.page_size || 100;
  Post.findAll({attributes: ['id','name'], limit: pageSize}).then(function(posts) {
    response.send(posts);
  })
})

app.listen(5001, function(){
  console.log("Express.js server started");
})
