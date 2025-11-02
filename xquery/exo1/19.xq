(: 19. Modifier la balise album de l'album numéro 1 de chaque série par "Premier_album" :)
copy $doc := doc("../attachments/albums.xml")
modify (
  for $a in $doc//album[@numero = "1"]
  return rename node $a as "Premier_album"
)
return $doc

