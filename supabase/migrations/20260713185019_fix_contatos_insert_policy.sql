/*
# Fix contatos INSERT policy

The existing anon_insert_contatos policy was created but inserts via the REST API
still fail with RLS violation. This migration drops and recreates the INSERT policy
to ensure it is correctly applied.
*/

DROP POLICY IF EXISTS "anon_insert_contatos" ON contatos;

CREATE POLICY "anon_insert_contatos" ON contatos FOR INSERT
  TO anon, authenticated WITH CHECK (true);
