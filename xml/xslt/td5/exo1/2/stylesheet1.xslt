<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/dblpperson">
        <list>
            <!-- Collect all years -->
            <xsl:for-each select="//inproceedings">
                <xsl:sort select="year" data-type="number" order="descending" />
                <xsl:if test="not(preceding::year = year)">
                    <year value="{year}">
                        <xsl:for-each select="//inproceedings[year = year]">
                            <inproceedings mdate="{@mdate}">
                                <title><xsl:value-of select="title"/></title>
                                <number-of-authors><xsl:value-of select="count(author)"/></number-of-authors>
                                <booktitle><xsl:value-of select="booktitle"/></booktitle>
                            </inproceedings>
                            </xsl:for-each>
                    </year>
                    </xsl:if>
                </xsl:for-each>
            </list>
        </xsl:template>

    </xsl:stylesheet>

