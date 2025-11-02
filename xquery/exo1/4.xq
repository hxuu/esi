for $serie in distinct-values(doc("../attachments/albums.xml")//album/@serie)
    let $albums := doc("../attachments/albums.xml")//album[@serie = $serie]
    let $max := max($albums/date/annee/xs:integer(.))
    return <serie nom="{$serie}">
      { $albums[date/annee = $max]/titre }
    </serie>

