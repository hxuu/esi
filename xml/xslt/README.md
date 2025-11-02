# XSLT

## What is XSLT?

It's a declarative programming language that allows the user to transform incoming XML
documents into other formats.

### example: from XML to XML

#### `input.xml`
```html
<?xml version="1.0" ?>
<persons>
  <person username="JS1">
    <name>John</name>
    <family-name>Smith</family-name>
  </person>
  <person username="MI1">
    <name>Morka</name>
    <family-name>Ismincius</family-name>
  </person>
</persons>
```

#### `input.xslt`
```html
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/> <!-- the resulting document is in XML -->

    <xsl:template match="/persons"> <!-- define a template: a rule like a regex (uses xpath instead) -->
        <!-- replace the persons node in root with <root> -->
        <root>
            <!-- the processor here is inside the persons node  -->
            <xsl:apply-templates select="person"/> <!-- apply another template -->
        </root>
    </xsl:template>

    <xsl:template match="person">
        <name username="{@username}">
            <xsl:value-of select="name" />
        </name>
    </xsl:template>

</xsl:stylesheet>
```

#### `output.xml`
```html
<?xml version="1.0" encoding="UTF-8"?>
<root>
  <name username="JS1">John</name>
  <name username="MI1">Morka</name>
</root>
```
---

Refereneces:
- [wikipedia](https://en.wikipedia.org/wiki/XSLT)
