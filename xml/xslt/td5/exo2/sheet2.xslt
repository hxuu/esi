<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.1">

    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Pays avec plusieurs langues</title>
            </head>
            <body>
                <table border="1">
                    <xsl:for-each select="mondial/country[count(language) &gt; 1]">
                        <xsl:sort select="count(language)" order="descending" data-type="number"/>
                        <tr>
                            <td><strong><xsl:value-of select="name"/></strong></td>
                            <td><xsl:value-of select="population[last()]"/></td>
                            <td><xsl:value-of select="@area"/></td>
                            <td><xsl:value-of select="count(language)"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>

