(: 12. Déclarer puis invoquer une fonction qui permet d'obtenir les albums les plus anciens d'un auteur :)
declare function local:plus-ancien-albums($auteur as xs:string) {
  let $albums := doc("../attachments/albums.xml")//album[auteur = $auteur]
  let $min := min($albums/date/annee/xs:integer(.))
  return $albums[date/annee = $min]
};

local:plus-ancien-albums("Hergé")

