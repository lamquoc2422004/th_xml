from lxml import etree

# Đọc file XML và XSLT
xml = etree.parse("quanlybanan.xml")
xslt = etree.parse("bai3.xsl")

# Tạo transformer
transform = etree.XSLT(xslt)

# Biến đổi XML -> HTML
result = transform(xml)

# Lưu ra file HTML
with open("KQbai3.html", "wb") as f:
    f.write(etree.tostring(result, pretty_print=True, method="html", encoding="UTF-8"))

print(" Đã tạo file KQbai3.html")
