# University Student Result Portal — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| student_key | result records (list) |
| --- | --- |
| 1001 | [5001] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| result.result_key | result.student_key | result.assessment_key | student.student_key | assessment.assessment_key | assessment.course_key | assessment.term_key | assessment.title |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 5001 | 1001 | 4001 | 1001 | 4001 | 2001 | 3001 | Midterm |

Key: result_key.

## 2NF: depend on the whole key

result: student_key is a proper part of candidate key (student_key, assessment_key), and determines student details. result: assessment_key is a proper part of candidate key (student_key, assessment_key), and determines assessment details. assessment: course_key is a proper part of candidate key (course_key, term_key, title), and determines course details. assessment: term_key is a proper part of candidate key (course_key, term_key, title), and determines term details.

## student_example

| student.student_key |
| --- |
| 1001 |

## assessment_example

| assessment.assessment_key | assessment.course_key | assessment.term_key | assessment.title |
| --- | --- | --- | --- |
| 4001 | 2001 | 3001 | Midterm |

## result_example

| result.result_key | result.student_key | result.assessment_key |
| --- | --- | --- |
| 5001 | 1001 | 4001 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## student

| student_key | active | created_date |
| --- | --- | --- |
| 1001 | true | 2026-01-10 |
| 1002 | true | 2026-01-11 |

## course

| course_key | course_code | title | credits |
| --- | --- | --- | --- |
| 2001 | MIT-8103 | Database Systems | 12 |
| 2002 | MIT-8104 | Data Modelling | 6 |

## term

| term_key | term_label | start_date | end_date |
| --- | --- | --- | --- |
| 3001 | Fall 2026 | 2026-09-01 | 2026-12-15 |
| 3002 | Spring 2027 | 2027-01-15 | 2027-05-10 |

## assessment

| assessment_key | course_key | term_key | title | max_score | due_date |
| --- | --- | --- | --- | --- | --- |
| 4001 | 2001 | 3001 | Midterm | 100 | 2026-10-15 |
| 4002 | 2002 | 3002 | Final Project | 80 | 2027-04-20 |

## result

| result_key | student_key | assessment_key | score | released_at |
| --- | --- | --- | --- | --- |
| 5001 | 1001 | 4001 | 88 | 2026-10-20T14:30:00+00:00 |

## Dependencies

- student: (student_key) → active, created_date
- course: (course_key) → course_code, title, credits
- term: (term_key) → term_label, start_date, end_date
- assessment: (assessment_key) → course_key, term_key, title, max_score, due_date
- result: (result_key) → student_key, assessment_key, score, released_at

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
