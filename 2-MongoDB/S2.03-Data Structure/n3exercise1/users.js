db.createCollection("users", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "users",
      "required": ["email", "username", "password", "birthdate ", "country"],
      "properties": {
        "email": {
          "bsonType": "string"
        },
        "username": {
          "bsonType": "string"
        },
        "password": {
          "bsonType": "string"
        },
        "birthdate ": {
          "bsonType": "date"
        },
        "sex": {
          "enum": 
        },
        "country": {
          "bsonType": "string"
        },
        "postal_code": {
          "bsonType": "string"
        },
        "channel": {
          "bsonType": "object",
          "title": "object",
          "required": ["name", "creation_date"],
          "properties": {
            "name": {
              "bsonType": "string"
            },
            "description": {
              "bsonType": "string"
            },
            "creation_date": {
              "bsonType": "date"
            }
          }  
        },
        "subscriptions": {
          "bsonType": "array",
          "items": {
            "title": "object",
            "required": ["channel_id"],
            "properties": {
              "channel_id": {
                "bsonType": "objectId"
              }
            }
          }  
        },
        "playlists": {
          "bsonType": "array",
          "items": {
            "title": "object",
            "required": ["name", "creation_date", "status"],
            "properties": {
              "name": {
                "bsonType": "string"
              },
              "videos": {
                "bsonType": "object",
                "title": "object",
                "required": ["video_id"],
                "properties": {
                  "video_id": {
                    "bsonType": "objectId"
                  }
                }  
              },
              "creation_date": {
                "bsonType": "date"
              },
              "status": {
                "enum": 
              }
            }
          }  
        }
      }  
    } 
  }
});
