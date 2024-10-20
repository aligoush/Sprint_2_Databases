db.createCollection("products", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "products",
      "required": ["name", "description", "image", "price", "type"],
      "properties": {
        "name": {
          "bsonType": "string"
        },
        "description": {
          "bsonType": "string"
        },
        "image": {
          "bsonType": "string"
        },
        "price": {
          "bsonType": "string"
        },
        "type": {
          "enum": 
        }
      }  
    } 
  }
});
