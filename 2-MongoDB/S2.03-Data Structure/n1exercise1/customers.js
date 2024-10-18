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
        "email": {
          "bsonType": "string"
        },
        "registration_date": {
          "bsonType": "date"
        },
        "reffered_by": {
          "bsonType": "objectId"
        },
        "last_shoppings": {
          "bsonType": "array",
          "items": {
            "title": "object",
            "required": ["order_id", "order_date", "total_price", "employee"],
            "properties": {
              "order_id": {
                "bsonType": "string"
              },
              "order_date": {
                "bsonType": "date"
              },
              "glasses": {
                "bsonType": "array",
                "items": {
                  "title": "object",
                  "required": ["brand", "frame_type", "graduation", "lens_color", "price"],
                  "properties": {
                    "brand": {
                      "bsonType": "string"
                    },
                    "frame_type": {
                      "enum": 
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
                    },
                    "price": {
                      "bsonType": "string"
                    }
                  }
                }  
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
      }  
    } 
  }
});
