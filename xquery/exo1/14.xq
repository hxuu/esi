(: 14. Ajouter un attribut editeur "La plume" à l’album numéro 3 de la serie "Astérix" :)
copy $doc := doc("../attachments/albums.xml")
modify (
  for $a in $doc//album[@serie = "Astérix" and @numero = "3"]
  return insert node attribute editeur {"La plume"} into $a
)
return $doc

