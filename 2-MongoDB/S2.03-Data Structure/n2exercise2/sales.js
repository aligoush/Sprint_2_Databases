db.createCollection("sales", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "sales",
      "required": ["customer_id", "glasses", "order_date", "total_price", "employee"],
      "properties": {
        "customer_id": {
          "bsonType": "objectId"
        },
        "glasses": {
          "bsonType": "array",
          "items": {
            "title": "object",
            "required": ["glasses_id"],
            "properties": {
              "glasses_id": {
                "bsonType": "objectId"
              },
              "graduation": {
                "bsonType": "object",
                "title": "object",
                "properties": {
                  "left": {
                    "bsonType": "string"
                  },
                  "right": {
                    "bsonType": "string"
                  }
                }  
              },
              "lens_color": {
                "bsonType": "object",
                "title": "object",
                "properties": {
                  "left": {
                    "bsonType": "string"
                  },
                  "right": {
                    "bsonType": "string"
                  }
                }  
              }
            }
          }  
        },
        "order_date": {
          "bsonType": "date"
        },
        "total_price": {
          "bsonType": "double"
        },
        "employee": {
          "bsonType": "objectId"
        }
      }  
    } 
  }
});
