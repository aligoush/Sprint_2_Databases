db.createCollection("customers", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "customers",
      "required": ["name", "address", "telephone", "email", "registration_date"],
      "properties": {
        "name": {
          "bsonType": "string"
        },
        "address": {
          "bsonType": "object",
          "title": "object"  
        },
        "telephone": {
          "bsonType": "string"
        },
        "email": {
          "bsonType": "string"
        },
        "reffered_by": {
          "bsonType": "objectId"
        },
        "registration_date": {
          "bsonType": "date"
        },
        "last_shoppings": {
          "bsonType": "array",
          "items": {
            "bsonType": "objectId"
          }
        }
      }  
    } 
  }
});
