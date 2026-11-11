// Run once in mongosh against a fresh exercise database.
// These records are fictional events for the case study.
(async function () {
  db = db.getSiblingDB('portfolio_nosql');
  if ((await db.getCollectionNames()).includes("result_events")) {
    throw new Error('The exercise collection already exists. Use a fresh database.');
  }

  // The validator checks the stable event fields while details can vary.
  await db.createCollection("result_events", {
    validator: {
    "$jsonSchema": {
        "bsonType": "object",
        "required": [
            "_id",
            "schemaVersion",
            "simulation",
            "eventType",
            "occurredAt",
            "source",
            "embedded",
            "references",
            "details"
        ],
        "properties": {
            "_id": {
                "bsonType": "string",
                "minLength": 1
            },
            "schemaVersion": {
                "enum": [
                    1
                ]
            },
            "simulation": {
                "enum": [
                    true
                ]
            },
            "eventType": {
                "bsonType": "string",
                "enum": [
                    "result_recorded",
                    "result_corrected"
                ]
            },
            "occurredAt": {
                "bsonType": "date"
            },
            "source": {
                "bsonType": "object",
                "required": [
                    "entity",
                    "key",
                    "snapshot"
                ],
                "properties": {
                    "entity": {
                        "enum": [
                            "result"
                        ]
                    },
                    "key": {
                        "bsonType": "object",
                        "required": [
                            "result_key"
                        ]
                    },
                    "snapshot": {
                        "bsonType": "object"
                    }
                }
            },
            "embedded": {
                "bsonType": "object"
            },
            "references": {
                "bsonType": "object"
            },
            "details": {
                "bsonType": "object"
            }
        }
    }
},
    validationLevel: 'strict', validationAction: 'error'
  });

  // Insert the four example events and show their IDs.
  printjson(await db.getCollection("result_events").insertMany([
    {
        "_id": "event_000001",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "result_recorded",
        "occurredAt": ISODate("2030-01-01T10:00:00Z"),
        "source": {
            "entity": "result",
            "key": {
                "result_key": 5001
            },
            "snapshot": {
                "result_key": 5001,
                "student_key": 1001,
                "assessment_key": 4001,
                "score": 88,
                "released_at": "2026-10-20T14:30:00Z"
            }
        },
        "embedded": {
            "assessment": [
                {
                    "key": {
                        "assessment_key": 4001
                    },
                    "snapshot": {
                        "assessment_key": 4001,
                        "course_key": 2001,
                        "term_key": 3001,
                        "title": "Midterm",
                        "max_score": 100,
                        "due_date": "2026-10-15"
                    },
                    "via": [
                        "result.assessment_key → assessment"
                    ]
                }
            ],
            "course": [
                {
                    "key": {
                        "course_key": 2001
                    },
                    "snapshot": {
                        "course_key": 2001,
                        "course_code": "MIT-8103",
                        "title": "Database Systems",
                        "credits": 12
                    },
                    "via": [
                        "result.assessment_key → assessment.course_key → course"
                    ]
                }
            ],
            "term": [
                {
                    "key": {
                        "term_key": 3001
                    },
                    "snapshot": {
                        "term_key": 3001,
                        "term_label": "Fall 2026",
                        "start_date": "2026-09-01",
                        "end_date": "2026-12-15"
                    },
                    "via": [
                        "result.assessment_key → assessment.term_key → term"
                    ]
                }
            ]
        },
        "references": {
            "student": [
                {
                    "key": {
                        "student_key": 1001
                    },
                    "via": [
                        "result.student_key → student"
                    ]
                }
            ]
        },
        "details": {
            "channel": "web"
        }
    },
    {
        "_id": "event_000002",
        "schemaVersion": 1,
        "simulation": true,
        "eventType": "result_corrected",
        "occurredAt": ISODate("2030-01-01T10:01:00Z"),
        "source": {
            "entity": "result",
            "key": {
                "result_key": 5001
            },
            "snapshot": {
                "result_key": 5001,
                "student_key": 1001,
                "assessment_key": 4001,
                "score": 88,
                "released_at": "2026-10-20T14:30:00Z"
            }
        },
        "embedded": {
            "assessment": [
                {
                    "key": {
                        "assessment_key": 4001
                    },
                    "snapshot": {
                        "assessment_key": 4001,
                        "course_key": 2001,
                        "term_key": 3001,
                        "title": "Midterm",
                        "max_score": 100,
                        "due_date": "2026-10-15"
                    },
                    "via": [
                        "result.assessment_key → assessment"
                    ]
                }
            ],
            "course": [
                {
                    "key": {
                        "course_key": 2001
                    },
                    "snapshot": {
                        "course_key": 2001,
                        "course_code": "MIT-8103",
                        "title": "Database Systems",
                        "credits": 12
                    },
                    "via": [
                        "result.assessment_key → assessment.course_key → course"
                    ]
                }
            ],
            "term": [
                {
                    "key": {
                        "term_key": 3001
                    },
                    "snapshot": {
                        "term_key": 3001,
                        "term_label": "Fall 2026",
                        "start_date": "2026-09-01",
                        "end_date": "2026-12-15"
                    },
                    "via": [
                        "result.assessment_key → assessment.term_key → term"
                    ]
                }
            ]
        },
        "references": {
            "student": [
                {
                    "key": {
                        "student_key": 1001
                    },
                    "via": [
                        "result.student_key → student"
                    ]
                }
            ]
        },
        "details": {
            "channel": "mobile",
            "note": "Illustrative event-specific metadata",
            "examples": {
                "correction_reason": "illustrative correction_reason",
                "actor_role": "illustrative actor_role",
                "previous_score": "illustrative previous_score"
            }
        }
    }
]));
  await db.getCollection("result_events").createIndex({eventType: 1, occurredAt: -1}, {name: 'event_type_time'});

  // 1. Find the first sample event type (up to five documents).
  printjson(await db.getCollection("result_events").find({"eventType":"result_recorded"}).sort({_id:1}).limit(5).toArray());

  // 2. Find events for the first source record using nested key fields (up to five).
  printjson(await db.getCollection("result_events").find({"source.key.result_key":5001}).sort({_id:1}).limit(5).toArray());

  // 3. Find events in the sample time range using a MongoDB Date filter (up to five).
  printjson(await db.getCollection("result_events").find({"occurredAt":{"$gte":ISODate("2030-01-01T10:00:00Z"), "$lt":ISODate("2030-01-01T11:00:00Z")}}).sort({_id:1}).limit(5).toArray());

  // 4. Count documents for each event type.
  printjson(await db.getCollection("result_events").aggregate([{"$group":{"_id":"$eventType", "documentCount":{"$sum":1}}}, {"$sort":{"_id":1}}]).toArray());

  // A date stored as text should be rejected by the validator.
  try {
    await db.getCollection("result_events").insertOne({...{
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "result_recorded",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "result",
        "key": {
            "result_key": 5001
        },
        "snapshot": {
            "result_key": 5001,
            "student_key": 1001,
            "assessment_key": 4001,
            "score": 88,
            "released_at": "2026-10-20T14:30:00Z"
        }
    },
    "embedded": {
        "assessment": [
            {
                "key": {
                    "assessment_key": 4001
                },
                "snapshot": {
                    "assessment_key": 4001,
                    "course_key": 2001,
                    "term_key": 3001,
                    "title": "Midterm",
                    "max_score": 100,
                    "due_date": "2026-10-15"
                },
                "via": [
                    "result.assessment_key → assessment"
                ]
            }
        ],
        "course": [
            {
                "key": {
                    "course_key": 2001
                },
                "snapshot": {
                    "course_key": 2001,
                    "course_code": "MIT-8103",
                    "title": "Database Systems",
                    "credits": 12
                },
                "via": [
                    "result.assessment_key → assessment.course_key → course"
                ]
            }
        ],
        "term": [
            {
                "key": {
                    "term_key": 3001
                },
                "snapshot": {
                    "term_key": 3001,
                    "term_label": "Fall 2026",
                    "start_date": "2026-09-01",
                    "end_date": "2026-12-15"
                },
                "via": [
                    "result.assessment_key → assessment.term_key → term"
                ]
            }
        ]
    },
    "references": {
        "student": [
            {
                "key": {
                    "student_key": 1001
                },
                "via": [
                    "result.student_key → student"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}, _id: 'invalid_date_example', occurredAt: 'not-a-date'});
  } catch (error) { print('Invalid date error: ' + error.code); }

  // Reusing an event ID should be rejected by the unique _id index.
  try { await db.getCollection("result_events").insertOne({
    "_id": "event_000001",
    "schemaVersion": 1,
    "simulation": true,
    "eventType": "result_recorded",
    "occurredAt": ISODate("2030-01-01T10:00:00Z"),
    "source": {
        "entity": "result",
        "key": {
            "result_key": 5001
        },
        "snapshot": {
            "result_key": 5001,
            "student_key": 1001,
            "assessment_key": 4001,
            "score": 88,
            "released_at": "2026-10-20T14:30:00Z"
        }
    },
    "embedded": {
        "assessment": [
            {
                "key": {
                    "assessment_key": 4001
                },
                "snapshot": {
                    "assessment_key": 4001,
                    "course_key": 2001,
                    "term_key": 3001,
                    "title": "Midterm",
                    "max_score": 100,
                    "due_date": "2026-10-15"
                },
                "via": [
                    "result.assessment_key → assessment"
                ]
            }
        ],
        "course": [
            {
                "key": {
                    "course_key": 2001
                },
                "snapshot": {
                    "course_key": 2001,
                    "course_code": "MIT-8103",
                    "title": "Database Systems",
                    "credits": 12
                },
                "via": [
                    "result.assessment_key → assessment.course_key → course"
                ]
            }
        ],
        "term": [
            {
                "key": {
                    "term_key": 3001
                },
                "snapshot": {
                    "term_key": 3001,
                    "term_label": "Fall 2026",
                    "start_date": "2026-09-01",
                    "end_date": "2026-12-15"
                },
                "via": [
                    "result.assessment_key → assessment.term_key → term"
                ]
            }
        ]
    },
    "references": {
        "student": [
            {
                "key": {
                    "student_key": 1001
                },
                "via": [
                    "result.student_key → student"
                ]
            }
        ]
    },
    "details": {
        "channel": "web"
    }
}); }
  catch (error) { print('Duplicate ID error: ' + error.code); }

  print('Document count: ' + await db.getCollection("result_events").countDocuments());
})().catch(error => { print(error.stack || String(error)); quit(1); });
