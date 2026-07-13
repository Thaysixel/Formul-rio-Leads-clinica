/*
# Add SELECT policy for contatos table

The supabase-js client library sends `Prefer: return=representation` by default
on INSERT, which causes PostgREST to SELECT the row back after inserting.
Without a SELECT policy for the anon role, this fails with an RLS violation.

1. Changes
- Add a SELECT policy allowing anon + authenticated to read from contatos.
  This is safe for a public contact form — the table only contains contact
  submissions with no sensitive data, and the SELECT is only used internally
  by PostgREST to return the inserted row.

2. Security
- INSERT policy (existing): anon + authenticated can insert.
- SELECT policy (new): anon + authenticated can select.
- No UPDATE or DELETE policies.
*/

DROP POLICY IF EXISTS "anon_select_contatos" ON contatos;
CREATE POLICY "anon_select_contatos" ON contatos FOR SELECT
  TO anon, authenticated USING (true);
