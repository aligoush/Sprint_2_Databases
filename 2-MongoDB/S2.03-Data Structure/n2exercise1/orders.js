db.createCollection("orders", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "orders",
      "required": ["customer", "products", "total_price", "order_date", "type", "store"],
      "properties": {
        "customer": {
          "bsonType": "objectId"
        },
        "products": {
          "bsonType": "array",
          "items": {
            "title": "object",
            "required": ["id", "name", "quantity"],
            "properties": {
              "id": {
                "bsonType": "objectId"
              },
              "name": {
                "bsonType": "string"
              },
              "quantity": {
                "bsonType": "int"
              }
            }
          }  
        },
        "total_price": {
          "bsonType": "double"
        },
        "order_date": {
          "bsonType": "date"
        },
        "type": {
          "enum": 
        },
        "store": {
          "bsonType": "objectId"
        },
        "delivery": {
          "bsonType": "object",
          "title": "object",
          "required": ["customer", "employee", "delivery_datetime"],
          "properties": {
            "customer": {
              "bsonType": "objectId"
            },
            "employee": {
              "bsonType": "objectId"
            },
            "delivery_datetime": {
              "bsonType": "date"
            }
          }  
        },
        "note": {
          "bsonType": "string"
        }
      }  
    } 
  }
});
