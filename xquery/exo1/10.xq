let $auteurs := distinct-values(doc("../attachments/albums.xml")//auteur)
let $result :=
  for $auteur in $auteurs
  let $count := count(doc("../attachments/albums.xml")//album[auteur = $auteur])
  return <auteur nom="{$auteur}" albums="{$count}"/>
let $max := max($result/@albums/xs:integer(.))
return $result[@albums = $max]

