db.createCollection("store", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "store",
      "required": ["name", "address"],
      "properties": {
        "name": {
          "bsonType": "string"
        },
        "address": {
          "bsonType": "object",
          "title": "object",
          "required": ["street", "number", "city", "postal_code", "province"],
          "properties": {
            "street": {
              "bsonType": "string"
            },
            "number": {
              "bsonType": "int"
            },
            "city": {
              "bsonType": "string"
            },
            "postal_code": {
              "bsonType": "string"
            },
            "province": {
              "bsonType": "string"
            }
          }  
        }
      }  
    } 
  }
});
