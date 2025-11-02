(: 17. Supprimer tous les albums de la série "Tintin" qui ont été publiés avant 1950. :)
copy $doc := doc("../attachments/albums.xml")
modify (
  for $a in $doc//album[@serie = "Tintin"]
  where xs:integer($a/date/annee) < 1950
  return delete node $a
)
return $doc

