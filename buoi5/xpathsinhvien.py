from lxml import etree

# Đọc file XML (SV.xml phải nằm cùng thư mục với file này)
tree = etree.parse("sinhvien.xml")

# Lấy tất cả sinh viên
students = tree.xpath("//student")
print("Tổng số sinh viên:", len(students))

# Liệt kê tên tất cả sinh viên
names = tree.xpath("//student/name/text()")
print("Tên các sinh viên:", names)

# Lấy tất cả id
ids = tree.xpath("//student/id/text()")
print("ID các sinh viên:", ids)

# Ngày sinh SV01
sv01_date = tree.xpath("//student[id='SV01']/date/text()")
print("Ngày sinh SV01:", sv01_date)

# Các khóa học
Khoahoc = tree.xpath("//enrollment/course/text()")
print("Các khoá học:", set(Khoahoc))

# Thông tin SV đầu tiên
ttsv = tree.xpath("//student[position()=1]")
print("\nThông tin sinh viên đầu tiên:\n",
      etree.tostring(ttsv[0], pretty_print=True, encoding='unicode'))

# Mã SV đăng ký Vatly203
svdk = tree.xpath("//student[id=//enrollment[course='Vatly203']/studentRef]/id/text()")
print("Mã SV đăng ký Vatly203:", svdk)

# Tên SV học Toan101
toan01 = tree.xpath("//student[id=//enrollment[course='Toan101']/studentRef]/name/text()")
print("Sinh viên học Toan101:", toan01)

# Tên SV học Vatly203
vatly203 = tree.xpath("//student[id=//enrollment[course='Vatly203']/studentRef]/name/text()")
print("Sinh viên học Vatly203:", vatly203)

# Tên + ngày sinh năm 1997
names_97 = tree.xpath("//student[starts-with(date,'1997')]/name/text()")
dates_97 = tree.xpath("//student[starts-with(date,'1997')]/date/text()")
print("\nSinh viên sinh năm 1997:")
for i in range(len(names_97)):
    print(f"{names_97[i]} ({dates_97[i]})")

# Sinh viên sinh trước 1998
truoc_1998 = tree.xpath("//student[number(substring(date,1,4)) < 1998]/name/text()")
print("\nSinh viên sinh trước 1998:", truoc_1998)

# Đếm tổng số SV (XPath)
tong_sv_xpath = int(tree.xpath("count(//student)"))
print("Tổng số SV (XPath):", tong_sv_xpath)

# SV chưa đăng ký môn
sv_chua_dk = tree.xpath("//student[not(id=//enrollment/studentRef)]/name/text()")
print("SV chưa đăng ký môn:", sv_chua_dk)

# <date> ngay sau <name> của SV01
date_sau_name = tree.xpath("//student[id='SV01']/name/following-sibling::date[1]/text()")
print("Date ngay sau <name> của SV01:", date_sau_name)

# <id> ngay trước <name> của SV02
id_truoc_name = tree.xpath("//student[id='SV02']/name/preceding-sibling::id[1]/text()")
print("ID ngay trước <name> của SV02:", id_truoc_name)

# Course của SV03
course_sv03 = tree.xpath("//enrollment[studentRef='SV03']/course/text()")
print("Course của SV03:", course_sv03)

# Sinh viên có họ “Trần”
sv_tran = tree.xpath("//student[starts-with(normalize-space(name),'Trần ')]/name/text()")
print("Sinh viên họ Trần:", sv_tran)

# Năm sinh của SV01
nam_sinh_sv01 = tree.xpath("substring(//student[id='SV01']/date,1,4)")
print("Năm sinh SV01:", nam_sinh_sv01)