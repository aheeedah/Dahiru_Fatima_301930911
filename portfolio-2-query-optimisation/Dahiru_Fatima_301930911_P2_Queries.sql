-- Show related result, student, assessment, course, term records (up to 20).
SELECT t0."result_key" AS "result_result_key",
       t0."score" AS "result_score",
       t1."student_key" AS "student_student_key",
       t1."active" AS "student_active",
       t2."assessment_key" AS "assessment_assessment_key",
       t2."title" AS "assessment_title",
       t3."course_key" AS "course_course_key",
       t3."course_code" AS "course_course_code",
       t4."term_key" AS "term_term_key",
       t4."term_label" AS "term_term_label"
FROM portfolio."result" t0
JOIN portfolio."student" t1 ON t0."student_key" = t1."student_key"
JOIN portfolio."assessment" t2 ON t0."assessment_key" = t2."assessment_key"
JOIN portfolio."course" t3 ON t2."course_key" = t3."course_key"
JOIN portfolio."term" t4 ON t2."term_key" = t4."term_key"
ORDER BY t0."result_key", t1."student_key", t2."assessment_key", t3."course_key", t4."term_key"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."result_key" AS "result_result_key",
       t0."score" AS "result_score",
       t1."student_key" AS "student_student_key",
       t1."active" AS "student_active",
       t2."assessment_key" AS "assessment_assessment_key",
       t2."title" AS "assessment_title",
       t3."course_key" AS "course_course_key",
       t3."course_code" AS "course_course_code",
       t4."term_key" AS "term_term_key",
       t4."term_label" AS "term_term_label"
FROM portfolio."result" t0
JOIN portfolio."student" t1 ON t0."student_key" = t1."student_key"
JOIN portfolio."assessment" t2 ON t0."assessment_key" = t2."assessment_key"
JOIN portfolio."course" t3 ON t2."course_key" = t3."course_key"
JOIN portfolio."term" t4 ON t2."term_key" = t4."term_key"
ORDER BY t0."result_key", t1."student_key", t2."assessment_key", t3."course_key", t4."term_key"
LIMIT 20;

-- Find result records where released_at matches "2026-10-20T14:30:00Z" (up to 20).
SELECT * FROM portfolio."result"
WHERE "released_at" IS NOT DISTINCT FROM '2026-10-20T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."result"
WHERE "released_at" IS NOT DISTINCT FROM '2026-10-20T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;

-- Count result records for each student_key (up to 20 groups).
SELECT "student_key", count(*) AS record_count
FROM portfolio."result"
GROUP BY "student_key"
ORDER BY record_count DESC, "student_key" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "student_key", count(*) AS record_count
FROM portfolio."result"
GROUP BY "student_key"
ORDER BY record_count DESC, "student_key" NULLS LAST
LIMIT 20;

-- Find result records where released_at matches "2026-10-20T14:30:00Z" (up to 20).
SELECT * FROM portfolio."result"
WHERE "released_at" IS NOT DISTINCT FROM '2026-10-20T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."result"
WHERE "released_at" IS NOT DISTINCT FROM '2026-10-20T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;
