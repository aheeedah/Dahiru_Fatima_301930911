# University Student Result Portal — SQL queries

## 1. Show related result, student, assessment, course, term records (up to 20).

```sql
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
```

| result_result_key | result_score | student_student_key | student_active | assessment_assessment_key | assessment_title | course_course_key | course_course_code | term_term_key | term_term_label |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 5001 | 88 | 1001 | true | 4001 | Midterm | 2001 | MIT-8103 | 3001 | Fall 2026 |

## 2. Find result records where released_at matches "2026-10-20T14:30:00Z" (up to 20).

```sql
SELECT * FROM portfolio."result"
WHERE "released_at" IS NOT DISTINCT FROM '2026-10-20T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;
```

| result_key | student_key | assessment_key | score | released_at |
| --- | --- | --- | --- | --- |
| 5001 | 1001 | 4001 | 88 | 2026-10-20T14:30:00+00:00 |

## 3. Count result records for each student_key (up to 20 groups).

```sql
SELECT "student_key", count(*) AS record_count
FROM portfolio."result"
GROUP BY "student_key"
ORDER BY record_count DESC, "student_key" NULLS LAST
LIMIT 20;
```

| student_key | record_count |
| --- | --- |
| 1001 | 1 |

## 4. Find result records where released_at matches "2026-10-20T14:30:00Z" (up to 20).

```sql
SELECT * FROM portfolio."result"
WHERE "released_at" IS NOT DISTINCT FROM '2026-10-20T14:30:00Z'
ORDER BY "result_key"
LIMIT 20;
```

| result_key | student_key | assessment_key | score | released_at |
| --- | --- | --- | --- | --- |
| 5001 | 1001 | 4001 | 88 | 2026-10-20T14:30:00+00:00 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 2.603 | 2.539, 2.603, 5.204 | Sort → Seq Scan | 274 |
| After index | 0.31 | 0.314, 0.308, 0.31 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 2.603 ms to 0.31 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=2.504..2.507 rows=50 loops=1)
  Seq Scan on result (actual time=0.015..2.462 rows=50 loops=1)
Planning Time: 0.362 ms
Execution Time: 2.539 ms
```

### Before index, run 2

```text
Sort (actual time=2.559..2.562 rows=50 loops=1)
  Seq Scan on result (actual time=0.017..2.516 rows=50 loops=1)
Planning Time: 0.405 ms
Execution Time: 2.603 ms
```

### Before index, run 3

```text
Sort (actual time=5.155..5.159 rows=50 loops=1)
  Seq Scan on result (actual time=0.024..5.087 rows=50 loops=1)
Planning Time: 0.584 ms
Execution Time: 5.204 ms
```

### After index, run 1

```text
Sort (actual time=0.249..0.251 rows=50 loops=1)
  Bitmap Heap Scan on result (actual time=0.033..0.209 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.015 rows=50 loops=1)
Planning Time: 0.611 ms
Execution Time: 0.314 ms
```

### After index, run 2

```text
Sort (actual time=0.247..0.25 rows=50 loops=1)
  Bitmap Heap Scan on result (actual time=0.032..0.208 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=50 loops=1)
Planning Time: 0.611 ms
Execution Time: 0.308 ms
```

### After index, run 3

```text
Sort (actual time=0.252..0.254 rows=50 loops=1)
  Bitmap Heap Scan on result (actual time=0.032..0.21 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.014..0.014 rows=50 loops=1)
Planning Time: 0.584 ms
Execution Time: 0.31 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Dahiru_Fatima_301930911_P2_Queries.sql, then Dahiru_Fatima_301930911_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Dahiru_Fatima_301930911_P2_QueryResults.png) · [Index comparison](screenshots/Dahiru_Fatima_301930911_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

