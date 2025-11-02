## Écrire une feuille de style XSLT qui permet de :

- Q1: Restructurer le document en regroupant les articles de journaux (balise article), les articles de conférence
(balise inproceedings) et les proceedings édités (balise proceedings), triés par année de parution.

=> Group article, inproceedings, proceedings (sorted by 'annee de parution')

- Q2. Afficher les articles de conférence (balise inproceedings) sous la forme d'une liste triée par année de
publication donnant pour chaque article son titre, le nombre d’auteurs, le nom de la conférence et l’année de
publication.

=> Q2. Display the conference articles (tag `<inproceedings>`) as a list sorted by year of publication, showing for each article:
- its title
- the number of authors
- the name of the conference
- and the year of publication.

- Q3. Afficher les titres de tous les articles de conférence parus entre 2010 et 2018, co-écrits par plus de trois
auteurs.

- Q4. Afficher l'arborescence correspondant à l'article de journal intitulé « A Survey on Privacy Preserving
Dynamic Data Publishing. » avec toutes ses balises, en transformant l’élément volume en un attribut de
l’élément journal et l’attribut mdate en un élément fils de l’élément article.

- Q5. Transformer le document Benslimane-DBLP.xml en un tableau HTML à deux colonnes : citation et type de
papier. Le format de citation est le suivant: autheur1, autheur2, ..., auteurN, (year) title. URL
Le type de papier: Short paper (de 1 et à 8 pages), Long paper (plus de 8 pages), Unspecified (si la balise pages n’existe pas).


