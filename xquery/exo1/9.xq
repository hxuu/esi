for $auteur in distinct-values(doc("../attachments/albums.xml")//auteur)
let $series := distinct-values(doc("../attachments/albums.xml")//album[auteur = $auteur]/@serie)
where count($series) > 1
return <auteur nom="{$auteur}" series="{string-join($series, ', ')}"/>

