import lxml.etree as ET

# Nạp file XML và XSLT
xml_file = "sinhvien.xml"
xsl_file = "bai2.xsl"
output_file = "KQbai2.json"

# Đọc dữ liệu
xml = ET.parse(xml_file)
xsl = ET.parse(xsl_file)
transform = ET.XSLT(xsl)

# Thực hiện chuyển đổi
result = transform(xml)

# Ghi kết quả ra file JSON
with open(output_file, "w", encoding="utf-8") as f:
    f.write(str(result))

print("Đã tạo file KQbai2.json thành công!")
