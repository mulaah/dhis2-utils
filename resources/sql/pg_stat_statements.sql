--
-- Queries for the pg_stat_statements PostgreSQL extension
--

-- Enable 'pg_stat_statements' extension in 'postgresql.conf'

# Enable library
shared_preload_libraries = 'pg_stat_statements'

# Increase the max size of the query strings Postgres records
track_activity_query_size = 8192

# Track statements generated by stored procedures as well
pg_stat_statements.track = all

-- Restart PostgreSQL and create extension for the specific database to monitor

create extension pg_stat_statements;

-- Get queries ordered by mean time desc (times are in ms)

select mean_exec_time, (total_exec_time/calls) as avg_time, max_exec_time, min_exec_time, total_exec_time, calls, rows, query 
from pg_stat_statements 
where query !~* '(copy|create index|create table|alter table).*'
order by mean_exec_time desc;
