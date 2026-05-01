-- ============================================================================
-- PRODICONSEIL — AUDIT SÉCURITÉ SUPABASE (à exécuter dans le SQL Editor)
-- ============================================================================
-- Fichier généré le 2026-05-01 dans le cadre du fix sécurité (Faille #2 RLS).
-- Copier-coller ce bloc dans le SQL Editor du dashboard Supabase et envoyer
-- le résultat à Claude pour décider des policies à appliquer.
-- ============================================================================

-- 1) Lister TOUTES les policies en place sur les 3 tables sensibles
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
FROM pg_policies
WHERE tablename IN ('products', 'proforma_requests', 'shared_carts')
ORDER BY tablename, cmd;

-- 2) Vérifier que RLS est activé sur ces tables
SELECT relname AS table_name, relrowsecurity AS rls_enabled, relforcerowsecurity AS rls_forced
FROM pg_class
WHERE relname IN ('products', 'proforma_requests', 'shared_carts');

-- 3) Lister les colonnes (utile pour comprendre les WITH CHECK à écrire)
SELECT table_name, column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name IN ('products', 'proforma_requests', 'shared_carts')
  AND table_schema = 'public'
ORDER BY table_name, ordinal_position;
