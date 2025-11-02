for $a in doc("../attachments/albums.xml")//album
where xs:integer($a/date/annee) > 1970
return $a/titre

