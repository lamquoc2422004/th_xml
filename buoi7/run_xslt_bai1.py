from lxml import etree

xml = etree.parse("sinhvien.xml")
xsl = etree.parse("bai1.xsl")
transform = etree.XSLT(xsl)
result = transform(xml)

result.write("KQbai1.html", pretty_print=True, encoding="utf-8")
