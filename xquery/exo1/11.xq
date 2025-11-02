(: 11. Afficher les albums qui ont exactement le même titre qu’un autre mais dans une série différente :)
for $a in doc("../attachments/albums.xml")//album
where some $b in doc("../attachments/albums.xml")//album
  satisfies ($a/titre = $b/titre and $a/@serie != $b/@serie)
return $a

