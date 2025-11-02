(: 15. Ajouter l'auteur "Hergé" à tous les albums de la série "Tintin" qui n'ont pas un. :)
copy $doc := doc("../attachments/albums.xml")
modify (
  for $a in $doc//album[@serie = "Tintin"]
  where empty($a/auteur)
  return insert node <auteur>Hergé</auteur> into $a
)
return $doc

