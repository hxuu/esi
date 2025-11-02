for $serie in distinct-values(doc("../attachments/albums.xml")//album/@serie)
let $albums :=
  for $a in doc("../attachments/albums.xml")//album[@serie = $serie]
  order by xs:integer($a/date/annee)
  return $a
for $i in 2 to count($albums)
let $current := $albums[$i]
let $previous := $albums[$i - 1]
let $diff := xs:integer($current/date/annee) - xs:integer($previous/date/annee)
where $diff > 10
return <album serie="{$serie}" titre="{$current/titre}" ecart="{$diff}"/>

