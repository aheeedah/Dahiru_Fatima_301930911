-- Use two psql terminals connected to the same exercise database.
-- Follow the numbered order across Session A and Session B.

-- 1. Session A: read 1.
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT "result_key", "p3_processed_count" FROM portfolio."result" WHERE "result_key" IS NOT DISTINCT FROM 5001;

-- 3. Session A: write the value calculated from its earlier read.
UPDATE portfolio."result" SET "p3_processed_count" = 2 WHERE "result_key" IS NOT DISTINCT FROM 5001 RETURNING json_build_object('processed_count',"p3_processed_count");
COMMIT;

-- 5. Reset for an equal starting point. Run outside both transactions.
UPDATE portfolio."result" SET "p3_processed_count" = 1 WHERE "result_key" IS NOT DISTINCT FROM 5001 RETURNING json_build_object('processed_count',"p3_processed_count");

-- 6. Session A: lock the row before reading.
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT "result_key", "p3_processed_count" FROM portfolio."result" WHERE "result_key" IS NOT DISTINCT FROM 5001 FOR UPDATE;

-- 8. Session A: update and release the lock by committing.
UPDATE portfolio."result" SET "p3_processed_count" = 2 WHERE "result_key" IS NOT DISTINCT FROM 5001 RETURNING json_build_object('processed_count',"p3_processed_count");
COMMIT;
