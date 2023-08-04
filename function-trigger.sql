#cau 1
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `TongDoanhThuNam2020`() RETURNS int(11)
BEGIN
	DECLARE TDT2020 INT;
    SELECT SUM(ChiTietDDH.SoLuong * MatHang.DonGia) INTO TDT2020
    FROM DonDatHang
    JOIN ChiTietDDH ON DonDatHang.MaDDH = ChiTietDDH.MaDDH
    JOIN MatHang ON ChiTietDDH.MaMH = MatHang.MaMH
    WHERE YEAR(DonDatHang.NgayDH) = 2020;
    RETURN TDT2020;
END$$
DELIMITER ;
#cau 2
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `TongDoanhThuNam`(`Nam` INT) RETURNS int(11)
BEGIN
    DECLARE TongDoanhThu INT;
    SELECT SUM(ChiTietDDH.SoLuong * MatHang.DonGia) into TongDoanhThu
    FROM DonDatHang
    JOIN ChiTietDDH ON DonDatHang.MaDDH = ChiTietDDH.MaDDH
    JOIN MatHang ON ChiTietDDH.MaMH = MatHang.MaMH
    WHERE YEAR(DonDatHang.NgayDH) = Nam;
    RETURN TongDoanhThu;
END$$
DELIMITER ;
#cau 3
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `TongThanhTienTheoMaDDH`(`MaDDH` CHAR(5)) RETURNS int(11)
BEGIN
    DECLARE `TongThanhTien` INT;

    SELECT SUM(SoLuong * DonGia * (1 - GiamGia)) into `TongThanhTien`
    FROM ChiTietDDH CT
    JOIN MatHang MH ON CT.MaMH = MH.MaMH
    WHERE CT.MaDDH = `MaDDH`;

    RETURN `TongThanhTien`;
END$$
DELIMITER ;
#cau 4
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `TongDoanhThuTheoMaNV`(`MaNV` INT) RETURNS int(11)
BEGIN
    DECLARE `TongDoanhThu` INT;

    SELECT  SUM(CT.SoLuong * MH.DonGia * (1 - CT.GiamGia)) into `TongDoanhThu`
    FROM DonDatHang DDH
    JOIN ChiTietDDH CT ON DDH.MaDDH = CT.MaDDH
    JOIN MatHang MH ON CT.MaMH = MH.MaMH
    WHERE DDH.MaNV = `MaNV`;

    RETURN `TongDoanhThu`;
END$$
DELIMITER ;
#câu 5

#cau 5.1
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `TongDoanhThuNam1997`()
BEGIN
    SELECT SUM(CT.SoLuong * MH.DonGia * (1 - CT.GiamGia)) AS TongDoanhThu
    FROM DonDatHang DDH
    JOIN ChiTietDDH CT ON DDH.MaDDH = CT.MaDDH
    JOIN MatHang MH ON CT.MaMH = MH.MaMH
    WHERE YEAR(DDH.NgayDH) = 1997;
END$$
DELIMITER ;


#câu 5.2
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `TongDoanhThuTheoNam`(IN p_Nam INT)
BEGIN
    SELECT SUM(CT.SoLuong * MH.DonGia * (1 - CT.GiamGia)) AS TongDoanhThu
    FROM DonDatHang DDH
    JOIN ChiTietDDH CT ON DDH.MaDDH = CT.MaDDH
    JOIN MatHang MH ON CT.MaMH = MH.MaMH
    WHERE YEAR(DDH.NgayDH) = p_Nam;
END$$
DELIMITER ;


#câu 5.3
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `TongThanhTienTheoMaDDH`(IN p_MaDDH CHAR(5))
BEGIN
    SELECT SUM(CT.SoLuong * MH.DonGia * (1 - CT.GiamGia)) AS TongThanhTien
    FROM ChiTietDDH CT
    JOIN MatHang MH ON CT.MaMH = MH.MaMH
    WHERE CT.MaDDH = p_MaDDH;
END$$
DELIMITER ;


#câu 5.4
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `TongDoanhThuTheoMaNV`(IN p_MaNV INT)
BEGIN
    SELECT SUM(CT.SoLuong * MH.DonGia * (1 - CT.GiamGia)) AS TongDoanhThu
    FROM DonDatHang DDH
    JOIN ChiTietDDH CT ON DDH.MaDDH = CT.MaDDH
    JOIN MatHang MH ON CT.MaMH = MH.MaMH
    WHERE DDH.MaNV = p_MaNV;
END$$
DELIMITER ;

#câu 6
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `LietKeNhanVienTheoPhai`(IN p_Phai CHAR(1))
    DETERMINISTIC
BEGIN
    SELECT MaNV, HoLot, TenNV, DiaChiNV, NgayNViec, Phai
    FROM NhanVien
    WHERE Phai = p_Phai;
END$$
DELIMITER ;
#câu 7
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `LietKeMatHangTheoMaDDH`(IN p_MaDDH CHAR(5))
BEGIN
    SELECT MH.MaMH, MH.TenMH, CT.SoLuong
    FROM MatHang MH
    JOIN ChiTietDDH CT ON MH.MaMH = CT.MaMH
    WHERE CT.MaDDH = p_MaDDH;
END$$
DELIMITER ;
#câu 9
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `LietKeMatHangTheoNhaCungCap`(IN p_MaNCC INT)
BEGIN
    SELECT MH.MaMH, MH.TenMH, MH.DonViTinh, MH.DonGia
    FROM MatHang MH
    WHERE MH.MaNCC = p_MaNCC;
END$$
DELIMITER ;
#câu 10
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `LietKeDonDatHangTheoKhoangThoiGian`(IN p_NgayBatDau DATE, IN p_NgayKetThuc DATE)
BEGIN
    SELECT DDH.MaDDH, DDH.NgayDH, DDH.NgayGiao, DDH.MaKH, KH.TenKH, MH.MaMH, MH.TenMH, CT.SoLuong
    FROM DonDatHang DDH
    JOIN ChiTietDDH CT ON DDH.MaDDH = CT.MaDDH
    JOIN MatHang MH ON CT.MaMH = MH.MaMH
    JOIN KhachHang KH ON DDH.MaKH = KH.MaKH
    WHERE DDH.NgayDH >= p_NgayBatDau AND DDH.NgayDH <= p_NgayKetThuc;
END$$
DELIMITER ;