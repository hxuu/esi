## EXO2 Solution

### 1. Le titre, genre et pays pour tous les films avant 1970

```xquery
for $f in doc("Films.xml")//FILM
where xs:integer($f/@annee) lt 1970
return <film>
  <titre>{ $f/TITRE/text() }</titre>
  <genre>{ $f/GENRE/text() }</genre>
  <pays>{ $f/PAYS/text() }</pays>
</film>
```

---

### 2. Les rôles joués par Bruce Willis

```xquery
for $f in doc("Films.xml")//FILM
for $r in $f/ROLES/ROLE
where $r/PRENOM = "Bruce" and $r/NOM = "Willis"
return $r
```

---

### 3. Les rôles joués par Bruce Willis (sous forme d’élément `rôle`)

```xquery
for $f in doc("Films.xml")//FILM
for $r in $f/ROLES/ROLE
where $r/PRENOM = "Bruce" and $r/NOM = "Willis"
return <rôle>
  <titre>{ $f/TITRE/text() }</titre>
  <personnage>{ $r/INTITULE/text() }</personnage>
</rôle>
```

---

### 4. Le nom du metteur en scène du film Vertigo

```xquery
let $films := doc("Films.xml")//FILM
let $artistes := doc("Artistes.xml")//ARTISTE
for $f in $films
where $f/TITRE = "Vertigo"
let $id := $f/MES/@idref
let $m := $artistes[@id = $id]
return concat($m/PRENOM, " ", $m/NOM)
```

---

### 5. Pour chaque artiste, son nom et les titres des films qu’il a dirigés

```xquery
let $films := doc("Films.xml")//FILM
let $artistes := doc("Artistes.xml")//ARTISTE
for $a in $artistes
let $realisations := $films[MES/@idref = $a/@id]
return <artiste>
  <nom>{ concat($a/PRENOM, " ", $a/NOM) }</nom>
  {
    for $f in $realisations
    return <film>{ $f/TITRE/text() }</film>
  }
</artiste>
```

---

### 6. Pour chaque film, l’âge du metteur en scène lors de la sortie du film

```xquery
let $films := doc("Films.xml")//FILM
let $artistes := doc("Artistes.xml")//ARTISTE
for $f in $films
let $id := $f/MES/@idref
let $a := $artistes[@id = $id]
let $age := xs:integer($f/@annee) - xs:integer($a/NAISSANCE)
return <film>
  <titre>{ $f/TITRE/text() }</titre>
  <age_realisateur>{ $age }</age_realisateur>
</film>
```

---

### 7. Pour chaque genre de film, produire un élément `genre` avec le nom du genre en attribut et contenant les titres

```xquery
for $g in distinct-values(doc("Films.xml")//GENRE)
let $films := doc("Films.xml")//FILM[GENRE = $g]
return <genre nom="{ $g }">
  {
    for $f in $films
    return <titre>{ $f/TITRE/text() }</titre>
  }
</genre>
```

---

### 8. Artistes ayant joué dans un film qu’ils ont mis en scène

```xquery
let $films := doc("Films.xml")//FILM
let $artistes := doc("Artistes.xml")//ARTISTE
for $a in $artistes
let $id := $a/@id
let $films_joues_et_diriges :=
  for $f in $films
  where $f/MES/@idref = $id and
        some $r in $f/ROLES/ROLE satisfies ($r/@idref = $id)
  return $f
where exists($films_joues_et_diriges)
return <artiste nom="{ concat($a/PRENOM, ' ', $a/NOM) }">
  {
    for $f in $films_joues_et_diriges
    return <film annee="{ $f/@annee }">{ $f/TITRE/text() }</film>
  }
</artiste>
```
