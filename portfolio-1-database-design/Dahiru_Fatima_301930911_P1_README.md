# Portfolio 1 — Database Design and Modelling

I organised the data into student, course, term, assessment, result. The design document explains the fields, keys, relationships and business rules. The normalisation document shows the sample tables at 1NF, 2NF and 3NF.

## Database checks

| Table | Rows |
| --- | --- |
| student | 2 |
| course | 2 |
| term | 2 |
| assessment | 2 |
| result | 1 |

The 17 invalid inserts were rejected at their expected constraints, and the valid sample rows remained unchanged.

## Files

- [Design](Dahiru_Fatima_301930911_P1_Design.md)
- [ER diagram](Dahiru_Fatima_301930911_P1_ERDiagram.md)
- [Normalisation](Dahiru_Fatima_301930911_P1_Normalisation.md)
- [Schema](Dahiru_Fatima_301930911_P1_Schema.sql)
- [Sample data](Dahiru_Fatima_301930911_P1_SampleData.sql)
- [Constraint tests](Dahiru_Fatima_301930911_P1_ConstraintTests.sql)
- [Table and constraint evidence](screenshots/Dahiru_Fatima_301930911_P1_DatabaseResults.png)

## Run the SQL

Create a fresh PostgreSQL database. Run the schema first, then the sample data. Run the deliberately invalid statements in ConstraintTests.sql individually outside a transaction; each is expected to produce an error.

## References

- [PostgreSQL — constraints](https://www.postgresql.org/docs/17/ddl-constraints.html)

