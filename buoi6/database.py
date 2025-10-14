import mysql.connector
from lxml import etree

# 1. Parse file XML và XSD 
xml_file = "catalog.xml"
xsd_file = "catalog.xsd"

print("Đang đọc file XML và XSD...")
xml_doc = etree.parse(xml_file)
xsd_doc = etree.parse(xsd_file)

xmlschema = etree.XMLSchema(xsd_doc)
print("Đã đọc thành công!")

# 2. Validate XML với XSD 
print(" Kiểm tra tính hợp lệ của XML...")
if not xmlschema.validate(xml_doc):
    print("XML không hợp lệ:")
    for error in xmlschema.error_log:
        print(f"- {error.message} (Dòng {error.line})")
    exit()
else:
    print("XML hợp lệ, bắt đầu xử lý dữ liệu...\n")

# 3. Kết nối MySQL 
print("Kết nối MySQL...")
conn = mysql.connector.connect(
    host="localhost",
    user="root",         
    password="",          
    database="baitap06_db"   
)
cursor = conn.cursor()
print("Kết nối thành công!\n")

# 4. Tạo bảng nếu chưa có 
cursor.execute("""
CREATE TABLE IF NOT EXISTS Categories (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL
)
""")

cursor.execute("""
CREATE TABLE IF NOT EXISTS Products (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(12,2) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    stock INT NOT NULL,
    category_id VARCHAR(50),
    FOREIGN KEY (category_id) REFERENCES Categories(id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
)
""")
conn.commit()
print("Đã kiểm tra và tạo bảng nếu chưa có.\n")

# 5. Dùng XPath để lấy dữ liệu 
root = xml_doc.getroot()

# --- Categories ---
categories = root.xpath("//category")
print("Danh mục sản phẩm trong XML:")
for cat in categories:
    cat_id = cat.get("id")
    cat_name = cat.text
    print(f" - {cat_id}: {cat_name}")
    cursor.execute("""
        INSERT INTO Categories (id, name)
        VALUES (%s, %s)
        ON DUPLICATE KEY UPDATE name = VALUES(name)
    """, (cat_id, cat_name))
conn.commit()
print(f"Đã đồng bộ {len(categories)} danh mục.\n")

# --- Products ---
products = root.xpath("//product")
print("Sản phẩm trong XML:")
for p in products:
    p_id = p.get("id")
    cat_ref = p.get("categoryRef")
    name = p.findtext("name")
    price = float(p.findtext("price"))
    currency = p.find("price").get("currency")
    stock = int(p.findtext("stock"))

    print(f" - {p_id}: {name} | {price} {currency} | SL: {stock} | Danh mục: {cat_ref}")

    cursor.execute("""
        INSERT INTO Products (id, name, price, currency, stock, category_id)
        VALUES (%s, %s, %s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            name = VALUES(name),
            price = VALUES(price),
            currency = VALUES(currency),
            stock = VALUES(stock),
            category_id = VALUES(category_id)
    """, (p_id, name, price, currency, stock, cat_ref))
conn.commit()
print(f"Đã đồng bộ {len(products)} sản phẩm.\n")

# 6. Hiển thị dữ liệu trong MySQL 
print(" Dữ liệu hiện có trong bảng Categories:")
cursor.execute("SELECT * FROM Categories")
for row in cursor.fetchall():
    print(" -", row)

print("\nDữ liệu hiện có trong bảng Products:")
cursor.execute("SELECT * FROM Products")
for row in cursor.fetchall():
    print(" -", row)

# 7. Đóng kết nối 
conn.commit()
cursor.close()
conn.close()
print("\n Hoàn tất! Dữ liệu đã được lưu hoặc cập nhật thành công.")
