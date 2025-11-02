(: 20. Ajouter un nouvel album à la fin de la série "Tintin". :)
copy $doc := doc("../attachments/albums.xml")
modify (
  insert node
    <album numero="3" serie="Tintin">
      <titre>Tintin et le Secret de l'Intelligence Artificielle</titre>
      <auteur>Hergé</auteur>
      <date>
        <mois>janvier</mois>
        <annee>2025</annee>
      </date>
    </album>
  into $doc/albums
)
return $doc

