-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. test pk student. Expected: pk_student, SQLSTATE 23505.
INSERT INTO portfolio."student" ("student_key", "active", "created_date")
VALUES (1001, FALSE, '2026-02-01');

-- 2. test not null student active. Expected: active, SQLSTATE 23502.
INSERT INTO portfolio."student" ("student_key", "active", "created_date")
VALUES (1003, NULL, '2026-02-02');

-- 3. test pk course. Expected: pk_course, SQLSTATE 23505.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (2001, 'MIT-8199', 'Distinct Course', 3);

-- 4. test unique course code. Expected: uq_course_0, SQLSTATE 23505.
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits")
VALUES (2003, 'MIT-8103', 'Another Course', 3);

-- 5. test pk term. Expected: pk_term, SQLSTATE 23505.
INSERT INTO portfolio."term" ("term_key", "term_label", "start_date", "end_date")
VALUES (3001, 'Special Term', '2026-06-01', '2026-06-30');

-- 6. test unique term label. Expected: uq_term_0, SQLSTATE 23505.
INSERT INTO portfolio."term" ("term_key", "term_label", "start_date", "end_date")
VALUES (3003, 'Fall 2026', '2026-08-01', '2026-08-31');

-- 7. test pk assessment. Expected: pk_assessment, SQLSTATE 23505.
INSERT INTO portfolio."assessment" ("assessment_key", "course_key", "term_key", "title", "max_score", "due_date")
VALUES (4001, 2002, 3002, 'Different Assessment', 50, '2027-03-01');

-- 8. test unique assessment. Expected: uq_assessment_0, SQLSTATE 23505.
INSERT INTO portfolio."assessment" ("assessment_key", "course_key", "term_key", "title", "max_score", "due_date")
VALUES (4003, 2001, 3001, 'Midterm', 100, '2026-10-16');

-- 9. test fk assessment course. Expected: fk_assessment_0, SQLSTATE 23503.
INSERT INTO portfolio."assessment" ("assessment_key", "course_key", "term_key", "title", "max_score", "due_date")
VALUES (4004, 9991, 3002, 'Unique Assessment A', 25, '2027-03-02');

-- 10. test fk assessment term. Expected: fk_assessment_1, SQLSTATE 23503.
INSERT INTO portfolio."assessment" ("assessment_key", "course_key", "term_key", "title", "max_score", "due_date")
VALUES (4005, 2001, 9992, 'Unique Assessment B', 25, '2026-10-17');

-- 11. test check term dates. Expected: term_dates_ordered, SQLSTATE 23514.
INSERT INTO portfolio."term" ("term_key", "term_label", "start_date", "end_date")
VALUES (3004, 'Reversed Dates Term', '2026-09-01', '2026-08-31');

-- 12. test check assessment max score. Expected: assessment_max_score_positive, SQLSTATE 23514.
INSERT INTO portfolio."assessment" ("assessment_key", "course_key", "term_key", "title", "max_score", "due_date")
VALUES (4006, 2002, 3002, 'Zero Maximum Assessment', 0, '2027-03-03');

-- 13. test pk result. Expected: pk_result, SQLSTATE 23505.
INSERT INTO portfolio."result" ("result_key", "student_key", "assessment_key", "score", "released_at")
VALUES (5001, 1002, 4002, 70, NULL);

-- 14. test unique result. Expected: uq_result_0, SQLSTATE 23505.
INSERT INTO portfolio."result" ("result_key", "student_key", "assessment_key", "score", "released_at")
VALUES (5002, 1001, 4001, 87, NULL);

-- 15. test fk result student. Expected: fk_result_0, SQLSTATE 23503.
INSERT INTO portfolio."result" ("result_key", "student_key", "assessment_key", "score", "released_at")
VALUES (5003, 9993, 4002, 70, NULL);

-- 16. test fk result assessment. Expected: fk_result_1, SQLSTATE 23503.
INSERT INTO portfolio."result" ("result_key", "student_key", "assessment_key", "score", "released_at")
VALUES (5004, 1002, 9994, 70, NULL);

-- 17. test check result score. Expected: result_score_nonnegative, SQLSTATE 23514.
INSERT INTO portfolio."result" ("result_key", "student_key", "assessment_key", "score", "released_at")
VALUES (5005, 1002, 4002, -1, NULL);
