# University Student Result Portal — ER diagram

```mermaid
erDiagram
    direction LR
    student {
        bigint student_key PK
        boolean active
        date created_date
    }
    course {
        bigint course_key PK
        text course_code UK
        text title
        integer credits
    }
    term {
        bigint term_key PK
        text term_label UK
        date start_date
        date end_date
    }
    assessment {
        bigint assessment_key PK
        bigint course_key FK
        bigint term_key FK
        text title
        numeric max_score
        date due_date
    }
    result {
        bigint result_key PK
        bigint student_key FK
        bigint assessment_key FK
        numeric score
        timestamptz released_at "Optional"
    }
    course ||--o{ assessment : "course_key"
    term ||--o{ assessment : "term_key"
    student ||--o{ result : "student_key"
    assessment ||--o{ result : "assessment_key"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Dahiru_Fatima_301930911_ERDiagram.png)
