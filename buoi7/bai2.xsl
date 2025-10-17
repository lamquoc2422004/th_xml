<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="text" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">
{
  "sinhvien": [
    <xsl:for-each select="school/student">
      {
        "ma": "<xsl:value-of select='@id'/>",
        "hoten": "<xsl:value-of select='name'/>",
        "ngaysinh": "<xsl:value-of select='birthday'/>"
      }<xsl:if test="position() != last()">,</xsl:if>
    </xsl:for-each>
  ]
}
    </xsl:template>
</xsl:stylesheet>
