db.createCollection("videos", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "videos",
      "required": ["title", "description", "size", "file_name", "duration", "thumbnail", "views", "likes_number", "dislikes_number", "status", "user", "upload_date"],
      "properties": {
        "title": {
          "bsonType": "string"
        },
        "description": {
          "bsonType": "string"
        },
        "size": {
          "bsonType": "int"
        },
        "file_name": {
          "bsonType": "double"
        },
        "duration": {
          "bsonType": "int"
        },
        "thumbnail": {
          "bsonType": "string"
        },
        "views": {
          "bsonType": "int"
        },
        "likes_number": {
          "bsonType": "int"
        },
        "dislikes_number": {
          "bsonType": "int"
        },
        "status": {
          "enum": 
        },
        "user": {
          "bsonType": "objectId"
        },
        "upload_date": {
          "bsonType": "date"
        },
        "comments": {
          "bsonType": "array",
          "items": {
            "title": "object",
            "required": ["comment_id", "text", "datetime"],
            "properties": {
              "comment_id": {
                "bsonType": "objectId"
              },
              "text": {
                "bsonType": "string"
              },
              "datetime": {
                "bsonType": "timestamp"
              }
            }
          }  
        },
        "tags": {
          "bsonType": "array",
          "items": {
            "bsonType": "string"
          }
        }
      }  
    } 
  }
});
