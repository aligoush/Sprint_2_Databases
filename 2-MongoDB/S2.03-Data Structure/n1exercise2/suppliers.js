db.createCollection("suppliers", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "suppliers",
      "required": ["name", "address", "telephone", "fax", "nif"],
      "properties": {
        "name": {
          "bsonType": "string"
        },
        "address": {
          "bsonType": "object",
          "title": "object",
          "required": ["street", "number", "city", "postal_code", "country"],
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
            },
            "country": {
              "bsonType": "string"
            }
          }  
        },
        "telephone": {
          "bsonType": "string"
        },
        "fax": {
          "bsonType": "string"
        },
        "nif": {
          "bsonType": "string"
        }
      }  
    } 
  }
});
