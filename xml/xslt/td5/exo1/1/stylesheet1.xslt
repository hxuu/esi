<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/dblpperson">
    <publications>
      <!-- Collect all years -->
      <xsl:for-each select="//article/year | //inproceedings/year | //proceedings/year">
        <xsl:sort select="." data-type="number" order="descending"/>
        <xsl:if test="not(preceding::year = .)">
          <year value="{.}">
            <xsl:for-each select="//article[year = current()] | //inproceedings[year = current()] | //proceedings[year = current()]">
              <xsl:copy-of select="."/>
            </xsl:for-each>
          </year>
        </xsl:if>
      </xsl:for-each>
    </publications>
  </xsl:template>
</xsl:stylesheet>

