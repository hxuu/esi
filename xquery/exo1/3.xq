let $auteurs := doc("../attachments/albums.xml")//auteur
for $auteur in distinct-values($auteurs)
    let $count := count($auteurs[. = $auteur])
    where $count > 1
    return <auteur nom="{$auteur}" albums="{$count}"/>

