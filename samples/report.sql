-- Themes installed per editor over the last 30 days
WITH recent AS (
    SELECT editor, theme_id, installed_at
    FROM installs
    WHERE installed_at >= now() - INTERVAL '30 days'
      AND uninstalled_at IS NULL
)
SELECT t.name,
       r.editor,
       COUNT(*)                         AS installs,
       ROUND(AVG(t.contrast_ratio), 1)  AS avg_contrast
FROM recent r
JOIN themes t ON t.id = r.theme_id
WHERE t.variant IN ('dark', 'light')
GROUP BY t.name, r.editor
HAVING COUNT(*) > 10
ORDER BY installs DESC
LIMIT 20;
