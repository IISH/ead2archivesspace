<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
        version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:ead="urn:isbn:1-931666-22-9"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        exclude-result-prefixes="ead xlink">

    <xsl:output method="xml" indent="no" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*|node()" mode="did">
        <xsl:choose>
            <xsl:when test="local-name() = 'unittitle'"/>
            <xsl:when test="local-name() = 'physdesc'"/>
            <xsl:when test="local-name() = 'note'"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" mode="did"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template
            match="ead:c01/ead:did|ead:c02/ead:did|ead:c03/ead:did|ead:c04/ead:did|ead:c05/ead:did|ead:c06/ead:did|ead:c07/ead:did|ead:c08/ead:did|ead:c09/ead:did|ead:c10/ead:did|ead:c11/ead:did|ead:c12/ead:did">
        <xsl:variable name="count" select="count(ead:unittitle)"/>
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="$count &lt; 2">
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="@*|node()" mode="did"/>
                    <ead:unittitle>
                        <xsl:copy-of select="ead:unittitle[1]/ead:persname|ead:unittitle[1]/ead:corpname"/>
                        -
                        <xsl:copy-of select="ead:unittitle[last()]/ead:persname|ead:unittitle[1]/ead:corpname"/>
                    </ead:unittitle>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
        <xsl:if test="$count>1">
            <ead:scopecontent>
                <ead:list>
                    <xsl:for-each select="*">
                        <xsl:choose>
                            <xsl:when test="local-name() = 'unittitle'">
                                <ead:item>
                                    <xsl:copy-of select="ead:persname|ead:corpname"/>
<!--                                    <xsl:if test="ead:unitdate">-->
<!--                                        <xsl:value-of select="ead:unitdate"/>-->
<!--                                    </xsl:if>-->
<!--                                    <xsl:value-of select="text()"/>-->
                                    <xsl:call-template name="interpret_text">
                                        <xsl:with-param name="t" select="*[not(name() = 'persname' or name() = 'corpname')]"/>
                                    </xsl:call-template>
                                </ead:item>
                            </xsl:when>
                            <xsl:when test="local-name() = 'physdesc'">
                                <ead:item>
<!--                                    <xsl:value-of select="ead:extent"/>-->
                                    <xsl:call-template name="interpret_text">
                                        <xsl:with-param name="t" select="."/>
                                    </xsl:call-template>
                                </ead:item>
                            </xsl:when>
                            <xsl:when test="local-name() = 'note'">
                                <ead:item>
                                    <xsl:call-template name="interpret_text">
                                        <xsl:with-param name="t" select="."/>
                                    </xsl:call-template>
                                </ead:item>
                            </xsl:when>
                            <xsl:otherwise/>
                        </xsl:choose>
                    </xsl:for-each>
                </ead:list>
            </ead:scopecontent>
        </xsl:if>
    </xsl:template>

    <xsl:template name="interpret_text">
        <xsl:param name="t"/>
        <xsl:for-each select="$t//text()">
            <xsl:if test="string-length(normalize-space(.))>0">
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>

