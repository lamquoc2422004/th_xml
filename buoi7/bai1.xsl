<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>Kết quả truy vấn sinh viên</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        h2 { color: darkblue; border-bottom: 2px solid #ccc; }
        table { border-collapse: collapse; width: 70%; margin-bottom: 25px; }
        th, td { border: 1px solid #999; padding: 6px 10px; text-align: left; }
        th { background-color: #eee; }
    </style>
</head>
<body>

<h1>Kết quả truy vấn dữ liệu sinh viên</h1>

<!-- 1 Liệt kê thông tin của tất cả sinh viên gồm mã và họ tên -->
<h2>1. Danh sách tất cả sinh viên (Mã, Họ tên)</h2>
<table>
<tr><th>Mã SV</th><th>Họ tên</th></tr>
<xsl:for-each select="school/student">
<tr>
    <td><xsl:value-of select="id"/></td>
    <td><xsl:value-of select="name"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 2️ Liệt kê danh sách sinh viên gồm mã, tên, điểm. Sắp xếp danh sách theo điểm từ cao đến thấp -->
<h2>2. Danh sách sinh viên (Mã, Tên, Điểm) – sắp xếp giảm dần</h2>
<table>
<tr><th>Mã SV</th><th>Họ tên</th><th>Điểm</th></tr>
<xsl:for-each select="school/student">
    <xsl:sort select="grade" data-type="number" order="descending"/>
<tr>
    <td><xsl:value-of select="id"/></td>
    <td><xsl:value-of select="name"/></td>
    <td><xsl:value-of select="grade"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 3️ Hiển thị danh sách sinh viên sinh tháng gần nhau, danh sách gồm: Số thứ tự, Họ tên, ngày sinh.
 -->
<h2>3. Danh sách sinh viên sinh theo ngày gần nhau</h2>
<table>
<tr><th>STT</th><th>Họ tên</th><th>Ngày sinh</th></tr>
<xsl:for-each select="school/student">
    <xsl:sort select="date"/>
<tr>
    <td><xsl:value-of select="position()"/></td>
    <td><xsl:value-of select="name"/></td>
    <td><xsl:value-of select="date"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 4️ Hiển thị danh sách các khóa học có sinh viên học. Sắp xếp theo khóa học -->
<h2>4. Danh sách các khóa học có sinh viên học </h2>
<xsl:for-each select="school/course">
    <h3><xsl:value-of select="name"/></h3>
    <table>
        <tr><th>Mã SV</th><th>Họ tên</th></tr>
        <xsl:for-each select="/school/enrollment[courseRef=current()/id]">
            <xsl:variable name="sid" select="studentRef"/>
            <tr>
                <td><xsl:value-of select="$sid"/></td>
                <td><xsl:value-of select="/school/student[id=$sid]/name"/></td>
            </tr>
        </xsl:for-each>
    </table>
</xsl:for-each>

<!-- 5️ Lấy danh sách sinh viên đăng ký khóa học "Hóa học 201"-->
<h2>5. Danh sách sinh viên đăng ký khóa "Hóa học 201"</h2>
<table>
<tr><th>Mã SV</th><th>Họ tên</th></tr>
<xsl:for-each select="school/enrollment[courseRef='c3']">
    <xsl:variable name="sid" select="studentRef"/>
    <tr>
        <td><xsl:value-of select="$sid"/></td>
        <td><xsl:value-of select="/school/student[id=$sid]/name"/></td>
    </tr>
</xsl:for-each>
</table>

<!-- 6️ Sinh viên sinh năm 1997 -->
<h2>6. Danh sách sinh viên sinh năm 1997</h2>
<table>
<tr><th>Mã SV</th><th>Họ tên</th><th>Năm sinh</th></tr>
<xsl:for-each select="school/student[substring(date,1,4)='1997']">
<tr>
    <td><xsl:value-of select="id"/></td>
    <td><xsl:value-of select="name"/></td>
    <td><xsl:value-of select="substring(date,1,4)"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 7 Thống kê sinh viên họ "Trần" -->
<h2>7. Danh sách sinh viên họ “Trần”</h2>
<table>
<tr><th>Mã SV</th><th>Họ tên</th></tr>
<xsl:for-each select="school/student[starts-with(name,'Trần')]">
<tr>
    <td><xsl:value-of select="id"/></td>
    <td><xsl:value-of select="name"/></td>
</tr>
</xsl:for-each>
</table>

</body>
</html>
</xsl:template>

</xsl:stylesheet>
