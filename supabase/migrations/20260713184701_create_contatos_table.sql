/*
# Create contatos table for contact form submissions

1. New Tables
- `contatos`
  - `id` (uuid, primary key, auto-generated)
  - `nome` (text, not null) — contact's full name
  - `email` (text, not null) — contact's email address
  - `whatsapp` (text, not null) — contact's WhatsApp phone number in format (xx) xxxxx-xxxx
  - `created_at` (timestamptz, defaults to now()) — when the submission was received

2. Security
- Enable RLS on `contatos`.
- This is a public contact form on a clinic website with no sign-in screen, so the
  anon-key frontend must be able to INSERT new submissions. Reads/updates/deletes are
  not needed from the frontend, so only an INSERT policy is created for anon+authenticated.

3. Important Notes
- The app has no authentication flow; the frontend uses the anon key exclusively.
- Only INSERT is allowed from the client to minimize the attack surface. Clinic staff
  can view submissions through the Supabase dashboard (service role bypasses RLS).
- The table is idempotent: safe to re-run this migration.
*/

CREATE TABLE IF NOT EXISTS contatos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  nome text NOT NULL,
  email text NOT NULL,
  whatsapp text NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE contatos ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "anon_insert_contatos" ON contatos;
CREATE POLICY "anon_insert_contatos" ON contatos FOR INSERT
  TO anon, authenticated WITH CHECK (true);
