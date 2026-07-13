/*
# Fix contatos RLS enforcement and insert policy

The contatos table had RLS enabled but relforcerowsecurity was false,
causing REST API inserts to fail with "new row violates row-level security policy".

1. Changes
- Force RLS on contatos table so policies are applied to all roles.
- Drop and recreate the INSERT policy for anon + authenticated to ensure it is active.

2. Security
- Only INSERT is allowed from the client (anon + authenticated).
- No SELECT/UPDATE/DELETE policies — clinic staff access data via Supabase dashboard.
*/

ALTER TABLE contatos FORCE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_insert_contatos" ON contatos;
CREATE POLICY "anon_insert_contatos" ON contatos FOR INSERT
  TO anon, authenticated WITH CHECK (true);
