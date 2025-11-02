(: 16. Modifier l’attribut serie de tous les albums d’Astérix par "Astérix et Obélix" :)
copy $doc := doc("../attachments/albums.xml")
modify (
  for $a in $doc//album[@serie = "Astérix"]
  return replace value of node $a/@serie with "Astérix et Obélix"
)
return $doc

