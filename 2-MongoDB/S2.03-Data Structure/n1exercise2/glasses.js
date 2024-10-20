db.createCollection("glasses", {
  validator: {
    $jsonSchema: {
      "bsonType": "object",
      "title": "glasses",
      "required": ["brand", "frame_type", "price", "supplier_id"],
      "properties": {
        "brand": {
          "bsonType": "string"
        },
        "frame_type": {
          "enum": 
        },
        "price": {
          "bsonType": "double"
        },
        "supplier_id": {
          "bsonType": "objectId"
        }
      }  
    } 
  }
});
