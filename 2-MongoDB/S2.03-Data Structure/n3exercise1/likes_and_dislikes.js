db.createCollection("likes_and_dislikes", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "likes_and_dislikes",
      "required": ["video_id", "user_id", "datetime", "reaction"],
      "properties": {
        "video_id": {
          "bsonType": "objectId"
        },
        "user_id": {
          "bsonType": "objectId"
        },
        "datetime": {
          "bsonType": "timestamp"
        },
        "reaction": {
          "enum": 
        }
      }  
    } 
  }
});
