db.createCollection("employees", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "employees",
      "required": ["name", "surname", "nif", "phone_number", "type"],
      "properties": {
        "name": {
          "bsonType": "string"
        },
        "surname": {
          "bsonType": "string"
        },
        "nif": {
          "bsonType": "string"
        },
        "phone_number": {
          "bsonType": "string"
        },
        "type": {
          "enum": 
        }
      }  
    } 
  }
});
