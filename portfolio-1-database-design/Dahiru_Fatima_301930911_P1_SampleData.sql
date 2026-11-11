-- Fictional sample records for University Student Result Portal.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."student" ("student_key", "active", "created_date") VALUES (1001, TRUE, '2026-01-10');
INSERT INTO portfolio."student" ("student_key", "active", "created_date") VALUES (1002, TRUE, '2026-01-11');
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits") VALUES (2001, 'MIT-8103', 'Database Systems', 12);
INSERT INTO portfolio."course" ("course_key", "course_code", "title", "credits") VALUES (2002, 'MIT-8104', 'Data Modelling', 6);
INSERT INTO portfolio."term" ("term_key", "term_label", "start_date", "end_date") VALUES (3001, 'Fall 2026', '2026-09-01', '2026-12-15');
INSERT INTO portfolio."term" ("term_key", "term_label", "start_date", "end_date") VALUES (3002, 'Spring 2027', '2027-01-15', '2027-05-10');
INSERT INTO portfolio."assessment" ("assessment_key", "course_key", "term_key", "title", "max_score", "due_date") VALUES (4001, 2001, 3001, 'Midterm', 100, '2026-10-15');
INSERT INTO portfolio."assessment" ("assessment_key", "course_key", "term_key", "title", "max_score", "due_date") VALUES (4002, 2002, 3002, 'Final Project', 80, '2027-04-20');
INSERT INTO portfolio."result" ("result_key", "student_key", "assessment_key", "score", "released_at") VALUES (5001, 1001, 4001, 88, '2026-10-20T14:30:00Z');
COMMIT;
