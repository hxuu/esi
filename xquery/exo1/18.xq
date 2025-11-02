(: 18. Augmenter de l'année de publication de tous les albums de la série "Astérix" après 1980. :)
copy $doc := doc("../attachments/albums.xml")
modify (
  for $a in $doc//album[@serie = "Astérix"]
  where xs:integer($a/date/annee) > 1980
  return replace value of node $a/date/annee with xs:integer($a/date/annee) + 1
)
return $doc

