db.createCollection("customers", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "customers",
      "required": ["name", "surname", "address", "phone_number"],
      "properties": {
        "name": {
          "bsonType": "string"
        },
        "surname": {
          "bsonType": "string"
        },
        "address": {
          "bsonType": "object",
          "title": "object",
          "required": ["street", "number", "city", "postal_code"],
          "properties": {
            "street": {
              "bsonType": "string"
            },
            "number": {
              "bsonType": "int"
            },
            "floor": {
              "bsonType": "string"
            },
            "door": {
              "bsonType": "string"
            },
            "city": {
              "bsonType": "string"
            },
            "postal_code": {
              "bsonType": "string"
            }
          }  
        },
        "phone_number": {
          "bsonType": "string"
        }
      }  
    } 
  }
});
