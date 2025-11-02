let $series := (
  for $serie in distinct-values(doc("../attachments/albums.xml")//album/@serie)
  let $count := count(doc("../attachments/albums.xml")//album[@serie = $serie])
  return <serie nom="{$serie}" count="{$count}"/>
)
return $series[.//@count = max($series//@count/xs:integer(.))]

