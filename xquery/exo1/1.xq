(: 1. Lister tous les albums en ordre alphabétique ascendant :)

for $album in doc("../attachments/albums.xml")/albums/album
    order by $album/titre
    return <album>{$album/titre}</album>
