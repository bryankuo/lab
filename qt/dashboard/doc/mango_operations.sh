#!/bin/bash
# Query
db.getCollection('car_001').find({})
db.car_001.find({},{_id:0, info:1})
db.car_001.find({},{_id:0, "info.speed":1})
db.car_001.find({},{_id:0, "info.ts":1, "info.speed":1})

var myCursor = db.car_001.find({},{_id:0, "info.ts":1, "info.speed":1})
while (myCursor.hasNext()) {
   print(tojson(myCursor.next()));
}

#
db.getCollection('car_001').find({},{info:1})
db.getCollection('car_001').find({},{info:{$slice:[0,1]})
db.getCollection('car_001').find({},{info:{$slice:[0,1]}})

#
db.getCollection('car_001').count({},{x:203})

# node.js

