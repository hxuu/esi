(: 13. Ajouter l’auteur "Uderzo" à l’album numéro 1 de la série "Tintin" :)
copy $doc := doc("../attachments/albums.xml")
modify (
  insert node <auteur>Uderzo</auteur> into $doc//album[@serie = "Tintin" and @numero = "1"]
)
return $doc

