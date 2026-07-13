/*
# Trigger PostgREST schema cache reload for contatos

PostgREST may have a stale schema cache that doesn't reflect the latest RLS policies.
This migration makes a trivial comment change to force PostgREST to reload.
*/

COMMENT ON TABLE contatos IS 'Contact form submissions from the clinic website';
