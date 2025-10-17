<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">

<html>
<head>
    <title>Quản lý Bán Ăn - Báo cáo</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        h2 { color: #004080; border-bottom: 2px solid #004080; padding-bottom: 5px; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 30px; }
        th, td { border: 1px solid #999; padding: 8px; text-align: left; }
        th { background-color: #d9e2f3; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>

    <!-- 1. Danh sách bàn -->
    <h2>1. Danh sách tất cả các bàn</h2>
    <table>
        <tr><th>STT</th><th>Số bàn</th><th>Tên bàn</th></tr>
        <xsl:for-each select="QUANLY/BANS/BAN">
            <tr>
                <td><xsl:value-of select="position()"/></td>
                <td><xsl:value-of select="SOBAN"/></td>
                <td><xsl:value-of select="TENBAN"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 2. Danh sách nhân viên -->
    <h2>2. Danh sách nhân viên</h2>
    <table>
        <tr><th>STT</th><th>Mã NV</th><th>Tên</th><th>SDT</th><th>Địa chỉ</th><th>Giới tính</th></tr>
        <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN">
            <tr>
                <td><xsl:value-of select="position()"/></td>
                <td><xsl:value-of select="MANV"/></td>
                <td><xsl:value-of select="TENV"/></td>
                <td><xsl:value-of select="SDT"/></td>
                <td><xsl:value-of select="DIACHI"/></td>
                <td><xsl:value-of select="GIOITINH"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 3. Danh sách món ăn -->
    <h2>3. Danh sách món ăn</h2>
    <table>
        <tr><th>STT</th><th>Mã món</th><th>Tên món</th><th>Giá</th><th>Hình ảnh</th></tr>
        <xsl:for-each select="QUANLY/MONS/MON">
            <tr>
                <td><xsl:value-of select="position()"/></td>
                <td><xsl:value-of select="MAMON"/></td>
                <td><xsl:value-of select="TENMON"/></td>
                <td><xsl:value-of select="GIA"/></td>
                <td><xsl:value-of select="HINHANH"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 4. Thông tin nhân viên NV02 -->
    <h2>4. Thông tin nhân viên NV02</h2>
    <table>
        <tr><th>Mã NV</th><th>Tên</th><th>SĐT</th><th>Địa chỉ</th><th>Giới tính</th></tr>
        <xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']">
            <tr>
                <td><xsl:value-of select="MANV"/></td>
                <td><xsl:value-of select="TENV"/></td>
                <td><xsl:value-of select="SDT"/></td>
                <td><xsl:value-of select="DIACHI"/></td>
                <td><xsl:value-of select="GIOITINH"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 5. Món ăn có giá > 50000 -->
    <h2>5. Danh sách món có giá &gt; 50,000</h2>
    <table>
        <tr><th>Mã món</th><th>Tên món</th><th>Giá</th></tr>
        <xsl:for-each select="QUANLY/MONS/MON[GIA &gt; 50000]">
            <tr>
                <td><xsl:value-of select="MAMON"/></td>
                <td><xsl:value-of select="TENMON"/></td>
                <td><xsl:value-of select="GIA"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 6. Thông tin hóa đơn HD03 -->
    <h2>6. Thông tin hóa đơn HD03</h2>
    <table>
        <tr><th>Tên nhân viên</th><th>Số bàn</th><th>Ngày lập</th><th>Tổng tiền</th></tr>
        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD03']">
            <tr>
                <td>
                    <xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/>
                </td>
                <td><xsl:value-of select="SOBAN"/></td>
                <td><xsl:value-of select="NGAYLAP"/></td>
                <td><xsl:value-of select="TONGTIEN"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 7. Tên các món ăn trong hóa đơn HD02 -->
    <h2>7. Các món trong hóa đơn HD02</h2>
    <table>
        <tr><th>Mã món</th><th>Tên món</th></tr>
        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']/CTHDS/CTHD">
            <tr>
                <td><xsl:value-of select="MAMON"/></td>
                <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 8. Lấy tên nhân viên lập hóa đơn HD02 -->
    <h2>8. Nhân viên lập hóa đơn HD02</h2>
    <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']">
        <p><strong>Nhân viên:</strong> 
            <xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/>
        </p>
    </xsl:for-each>

    <!-- 9. Đếm số bàn -->
    <h2>9. Tổng số bàn</h2>
    <p><xsl:value-of select="count(QUANLY/BANS/BAN)"/></p>

    <!-- 10. Đếm số hóa đơn lập bởi NV01 -->
    <h2>10. Số hóa đơn lập bởi NV01</h2>
    <p><xsl:value-of select="count(QUANLY/HOADONS/HOADON[MANV='NV01'])"/></p>

    <!-- 11. Danh sách món bán cho bàn số 2 -->
    <h2>11. Danh sách món bán cho bàn số 2</h2>
    <table>
        <tr><th>Mã món</th><th>Tên món</th></tr>
        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN=2]/CTHDS/CTHD">
            <tr>
                <td><xsl:value-of select="MAMON"/></td>
                <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 12. Danh sách nhân viên lập hóa đơn cho bàn số 3 -->
    <h2>12. Nhân viên lập hóa đơn cho bàn số 3</h2>
    <ul>
        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN=3]">
            <li><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></li>
        </xsl:for-each>
    </ul>

    <!-- 13. Các món được gọi nhiều hơn 1 lần -->
    <h2>13. Các món được gọi nhiều hơn 1 lần trong các hóa đơn</h2>
    <table>
        <tr><th>Mã món</th><th>Tên món</th></tr>
        <xsl:for-each select="QUANLY/MONS/MON">
            <xsl:variable name="ma" select="MAMON"/>
            <xsl:if test="count(/QUANLY/HOADONS/HOADON/CTHDS/CTHD[MAMON=$ma]) &gt; 1">
                <tr>
                    <td><xsl:value-of select="$ma"/></td>
                    <td><xsl:value-of select="TENMON"/></td>
                </tr>
            </xsl:if>
        </xsl:for-each>
    </table>

    <!-- 14. Hóa đơn chi tiết HD04 -->
    <h2>14. Hóa đơn HD04 chi tiết</h2>
    <table>
        <tr><th>Mã món</th><th>Tên món</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th></tr>
        <xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD04']/CTHDS/CTHD">
            <xsl:variable name="gia" select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/GIA"/>
            <xsl:variable name="soluong" select="SOLUONG"/>
            <tr>
                <td><xsl:value-of select="MAMON"/></td>
                <td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
                <td><xsl:value-of select="$gia"/></td>
                <td><xsl:value-of select="$soluong"/></td>
                <td><xsl:value-of select="$gia * $soluong"/></td>
            </tr>
        </xsl:for-each>
    </table>

</body>
</html>

</xsl:template>
</xsl:stylesheet>
