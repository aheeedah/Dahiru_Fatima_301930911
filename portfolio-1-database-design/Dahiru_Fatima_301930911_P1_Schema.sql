-- University Student Result Portal: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."student" (
  "student_key" bigint NOT NULL,
  "active" boolean NOT NULL,
  "created_date" date NOT NULL,
  CONSTRAINT "pk_student" PRIMARY KEY ("student_key")
);
CREATE TABLE portfolio."course" (
  "course_key" bigint NOT NULL,
  "course_code" text NOT NULL,
  "title" text NOT NULL,
  "credits" bigint NOT NULL,
  CONSTRAINT "pk_course" PRIMARY KEY ("course_key"),
  CONSTRAINT "uq_course_0" UNIQUE ("course_code")
);
CREATE TABLE portfolio."term" (
  "term_key" bigint NOT NULL,
  "term_label" text NOT NULL,
  "start_date" date NOT NULL,
  "end_date" date NOT NULL,
  CONSTRAINT "pk_term" PRIMARY KEY ("term_key"),
  CONSTRAINT "uq_term_0" UNIQUE ("term_label")
);
CREATE TABLE portfolio."assessment" (
  "assessment_key" bigint NOT NULL,
  "course_key" bigint NOT NULL,
  "term_key" bigint NOT NULL,
  "title" text NOT NULL,
  "max_score" numeric(18,2) NOT NULL,
  "due_date" date NOT NULL,
  CONSTRAINT "pk_assessment" PRIMARY KEY ("assessment_key"),
  CONSTRAINT "uq_assessment_0" UNIQUE ("course_key", "term_key", "title")
);
CREATE TABLE portfolio."result" (
  "result_key" bigint NOT NULL,
  "student_key" bigint NOT NULL,
  "assessment_key" bigint NOT NULL,
  "score" numeric(18,2) NOT NULL,
  "released_at" timestamptz,
  CONSTRAINT "pk_result" PRIMARY KEY ("result_key"),
  CONSTRAINT "uq_result_0" UNIQUE ("student_key", "assessment_key")
);
ALTER TABLE portfolio."assessment" ADD CONSTRAINT "fk_assessment_0" FOREIGN KEY ("course_key") REFERENCES portfolio."course" ("course_key");
ALTER TABLE portfolio."assessment" ADD CONSTRAINT "fk_assessment_1" FOREIGN KEY ("term_key") REFERENCES portfolio."term" ("term_key");
ALTER TABLE portfolio."result" ADD CONSTRAINT "fk_result_0" FOREIGN KEY ("student_key") REFERENCES portfolio."student" ("student_key");
ALTER TABLE portfolio."result" ADD CONSTRAINT "fk_result_1" FOREIGN KEY ("assessment_key") REFERENCES portfolio."assessment" ("assessment_key");
ALTER TABLE portfolio."term" ADD CONSTRAINT "term_dates_ordered" CHECK ("end_date" > "start_date");
ALTER TABLE portfolio."assessment" ADD CONSTRAINT "assessment_max_score_positive" CHECK ("max_score" > 0);
ALTER TABLE portfolio."result" ADD CONSTRAINT "result_score_nonnegative" CHECK ("score" >= 0);
COMMIT;
