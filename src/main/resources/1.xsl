<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
        version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:ead="urn:isbn:1-931666-22-9"
        xmlns:xlink="http://www.w3.org/1999/xlink"
        exclude-result-prefixes="ead xlink">

    <xsl:output method="text" indent="no"/>
    <xsl:variable name="k">,</xsl:variable>

    <xsl:template match="/">
        <!--        https://confluence.socialhistoryservices.org/display/IISG/EAD+import-->

        <!--        Zoek binnen c0x (c01 t/m c012) meer dan een unittitle-->
        <xsl:variable name="cxx_unittitle" select="count(//ead:c01[count(ead:did/ead:unittitle) > 1]|//ead:c01[count(ead:did/ead:unittitle) > 1]|//ead:c02[count(ead:did/ead:unittitle) > 1]|//ead:c03[count(ead:did/ead:unittitle) > 1]|//ead:c04[count(ead:did/ead:unittitle) > 1]|//ead:c05[count(ead:did/ead:unittitle) > 1]|//ead:c06[count(ead:did/ead:unittitle) > 1]|//ead:c07[count(ead:did/ead:unittitle) > 1]|//ead:c08[count(ead:did/ead:unittitle) > 1]|//ead:c09[count(ead:did/ead:unittitle) > 1]|//ead:c10[count(ead:did/ead:unittitle) > 1]|//ead:c11[count(ead:did/ead:unittitle) > 1]|//ead:c12[count(ead:did/ead:unittitle) > 1])"/>

        <!--        - Zoek binnen unittitle element <lb/>-->
        <xsl:variable name="lb_in_unittitle" select="count(//ead:unittitle/ead:lb)"/>

        <!--        - Zoek in archdesc:did:physdesc met <extent unit="item" label="Extent" encodinganalog="300$a">-->
        <xsl:variable name="physdesc_extent_item_encodinganalog_300a"
                      select="count(//ead:archdesc/ead:did/ead:physdesc/ead:extent[@unit='item' and @encodinganalog='300$a'])"/>

        <!--        - Zoek in archdesc:did:physdesc met <extent unit="bytes" label="Extent" encodinganalog="300$a">-->
        <xsl:variable name="physdesc_extent_bytes_encodinganalog_300a"
                      select="count(//ead:archdesc/ead:did/ead:physdesc/ead:extent[@unit='bytes' and @encodinganalog='300$a'])"/>

        <!--        Zoek elementen <c0x> (c01 t/m c012) not containing attribute level-->
        <xsl:variable name="cxx_geen_atribuut_level" select="count(//ead:c01[not(@level)]| //ead:c02[not(@level)]| //ead:c03[not(@level)]| //ead:c04[not(@level)]| //ead:c05[not(@level)]| //ead:c06[not(@level)]| //ead:c07[not(@level)]| //ead:c08[not(@level)]| //ead:c09[not(@level)]| //ead:c10[not(@level)]| //ead:c11[not(@level)]| //ead:c12[not(@level)])"/>

<!--        - Zoek in archdesc:did:physdesc:extent(1) getal containing , (kommagetal)-->
        <xsl:variable name="physdesc_extent_kommagetal"
                      select="count(//ead:archdesc/ead:did/ead:physdesc/ead:extent[contains(text(), ',')])"/>

        <!--        - Zoek <odd> binnen <odd>-->
        <xsl:variable name="odd_in_odd" select="count(//ead:archdesc/ead:descgrp/ead:odd//ead:odd)"/>

<!--        - Zoek binnen langusage meer dan een language-->
        <xsl:variable name="langusage_language" select="count(//ead:langusage//ead:language)"/>


        <xsl:value-of
                select="concat($cxx_unittitle, $k, $lb_in_unittitle, $k, $physdesc_extent_item_encodinganalog_300a,$k, $physdesc_extent_bytes_encodinganalog_300a, $k, $cxx_geen_atribuut_level, $k, $physdesc_extent_kommagetal, $k, $odd_in_odd, $k, $langusage_language)"/>
    </xsl:template>

</xsl:stylesheet>