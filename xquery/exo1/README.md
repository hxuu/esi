# Exercise 01 (XQuery)

## References

- [XQuery Tutorial](https://www.w3schools.com/xml/xquery_functions.asp)

## Solution to questions

I'll be using `basex` which is an XQuery processor. To run basex on the command line, use:

```bash
basex -i input.xml query.xq
```

Where:
- input.xml: The input xml file on which the processing will take place.
- query.xq : The XQuery to be ran.

> The xml file used is `albums.xml` found in the `attachments` directory.

---

1. Lister tous les albums en ordre alphabétique ascendant
→ Trie les titres d’albums par ordre alphabétique croissant.

2. Les albums publiés après 1970
→ Filtre les albums dont l’année > 1970.

3. Les auteurs ayant participé à plus d’un album
→ Compte les auteurs avec plus d’un album.

4. Trouver l’album le plus récent de chaque série
→ Trie par série et année décroissante, prend le premier.

5. Regrouper les albums par série et compter le nombre d'albums par série
→ Compte le nombre d’albums pour chaque série.

6. Trouver la série ayant le plus d’albums
→ Trie les séries par nombre d’albums décroissant, garde la première.

7. Trouver les années où le plus d’albums ont été publiés
→ Compte et trie les années selon le nombre d’albums.

8. Lister les albums qui ont été publiés avec plus de 10 ans d’écart du précédent album de la même série
→ Compare les années consécutives dans chaque série.

9. Trouver les auteurs ayant participé à plusieurs séries différentes
→ Recherche les auteurs associés à plusieurs séries distinctes.

10. Identifier l’auteur ayant écrit le plus d’albums
→ Agrège les auteurs et garde celui avec le plus d’albums.

11. Afficher les albums qui ont exactement le même titre qu’un autre mais dans une série différente
→ Compare les titres avec séries différentes, affiche doublons.

12. Déclarer puis invoquer une fonction qui permet d'obtenir les albums les plus anciens d'un auteur (exemple : l’auteur "Hergé").
→ Fonction retourne albums triés par année pour un auteur donné.

13. Ajouter l’auteur "Uderzo" à l’album numéro 1 de la série "Tintin".
→ Insère un auteur à un album spécifique.

14. Ajouter un attribut editeur "La plume" à l’album numéro 3 de la serie "Astérix"
→ Ajoute un attribut XML à un album donné.

15. Ajouter l'auteur "Hergé" à tous les albums de la série "Tintin" qui n'ont pas un.
→ Vérifie absence d’auteur puis insère "Hergé".

16. Modifier l’attribut serie de tous les albums d’Asterix par "Astérix et Obélix"
→ Change la valeur de l’attribut `serie` si "Astérix".

17. Supprimer tous les albums de la série "Tintin" qui ont été publiés avant 1950.
→ Supprime les albums Tintin avec annee < 1950.

18. Augmenter de l'année de publication de tous les albums de la série "Astérix" après 1980.
→ Incrémente l’année si elle est > 1980.

19. Modifier la balise album de l'album numéro 1 de chaque série par "Premier_album".
→ Renomme `<album>` en `<Premier_album>` si numéro=1.

20. Ajouter un nouvel album à la fin de la série "Tintin".
→ Insère un nouvel élément `<album>` à la série Tintin.
