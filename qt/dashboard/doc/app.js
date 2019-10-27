var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/mydb";

MongoClient.connect(url, { useNewUrlParser: true },function(err, db) {
  if (err) throw err;
  //console.log("Database created!");
/*
    var table = 'aa';
    var collection = db.collection(table);
    var data = {
      'id':1,
      'name':'leo yeh'
    };*/
  var dbo = db.db("racev");
/*
  dbo.createCollection("footprints", function(err, res) {
    if (err) throw err;
    //console.log("Collection created!");
    //db.close();
  });
*/
  var myobj = { name: "Company Inc", address: "Highway 37" };
  dbo.collection("footprints").insertOne(myobj, function(err, res) {
    if (err) throw err;
    console.log("1 document inserted");
    db.close();
  });
});


