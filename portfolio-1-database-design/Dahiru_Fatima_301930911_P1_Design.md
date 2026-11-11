# University Student Result Portal — database design

My case study records student, course, term, assessment, result.

## Users

- Students viewing released results
- Instructors reviewing course assessment results
- Registrar staff maintaining course and term records

## Main operations

- Maintain courses, terms, and assessments
- Record one result per student and assessment
- Release results and report scores by course and term

## Entities

| Entity | Information stored |
| --- | --- |
| student | Store a synthetic student reference and minimal portal status without names or institutional identifiers. |
| course | Store course details used to group assessments and report results. |
| term | Represent an academic term and its calendar boundaries. |
| assessment | Define an assessment for a course in a particular term. |
| result | Store a student's score for an assessment and, optionally, when it was released. |

## student

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| student_key | BIGINT | PK | Yes |
| active | BOOLEAN |  | Yes |
| created_date | DATE |  | Yes |


## course

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| course_key | BIGINT | PK | Yes |
| course_code | TEXT | Unique | Yes |
| title | TEXT |  | Yes |
| credits | INTEGER |  | Yes |
- Unique key: (course_code).

## term

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| term_key | BIGINT | PK | Yes |
| term_label | TEXT | Unique | Yes |
| start_date | DATE |  | Yes |
| end_date | DATE |  | Yes |
- Unique key: (term_label).

## assessment

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| assessment_key | BIGINT | PK | Yes |
| course_key | BIGINT | FK | Yes |
| term_key | BIGINT | FK | Yes |
| title | TEXT |  | Yes |
| max_score | NUMERIC(18,2) |  | Yes |
| due_date | DATE |  | Yes |
- course_key → course.course_key
- term_key → term.term_key
- Unique key: (course_key, term_key, title).

## result

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| result_key | BIGINT | PK | Yes |
| student_key | BIGINT | FK | Yes |
| assessment_key | BIGINT | FK | Yes |
| score | NUMERIC(18,2) |  | Yes |
| released_at | TIMESTAMPTZ |  | No |
- student_key → student.student_key
- assessment_key → assessment.assessment_key
- Unique key: (student_key, assessment_key).

## Relationships and business rules

- Every student record must have its synthetic surrogate key.
- Each course code identifies at most one course.
- Each term label identifies at most one term.
- A term end date must be on or after its start date.
- Every assessment must reference an existing course through course_key.
- Every assessment must reference an existing term through term_key.
- An assessment's maximum score must be greater than zero.
- Every result must reference an existing synthetic student through student_key.
- Every result must reference an existing assessment through assessment_key.
- A recorded result score must be zero or greater.
- A student can have at most one result for a given assessment.

## Assumptions

- The supplied scenario ends with “Porta”; interpret this as the truncated word “Portal,” not as a different case.
- Student names and institutional student IDs are omitted. student_key is only a synthetic database surrogate, not a real student identifier.
- Surrogate primary-key values are generated synthetically and are globally unique across all entities.
- Scores are numeric, but grading scales and score-to-grade conversion are unspecified.
- A result is released when released_at is populated.
- Each assessment belongs to one course and one term; each result refers to one student and one assessment.
- Normalisation example: start with a result relation containing result_key, student_key, assessment_key, score, released_at, assessment_title, course_code, course_title, and term_label. Use result as the root with foreign keys to student and assessment; assessment references course and term. Decompose so each fact is stored with its owning entity, without repeating ancestor roles in the example.

