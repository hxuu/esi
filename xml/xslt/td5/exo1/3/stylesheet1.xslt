<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/dblpperson">
        <inproceedings>
            <!-- Collect all years -->
            <xsl:for-each select="//inproceedings[year &gt;= 2008 and year &lt;= 2018 and count(author) &gt; 3]">
                <title><xsl:value-of select="title"/></title>
                </xsl:for-each>
            </inproceedings>
        </xsl:template>

    </xsl:stylesheet>

