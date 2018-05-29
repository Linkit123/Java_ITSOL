---------------------------------- CREATE ----------------------------
CREATE TABLE NHACUNGCAP(
        MACONGTY      NUMBER(15) PRIMARY KEY,
        TENCONGTY      VARCHAR2(15) NOT NULL,
        TENGIAODICH    VARCHAR2(10),
        DIACHI        VARCHAR2(10),
        EMAIL        VARCHAR2(10),
        DIENTHOAI   VARCHAR2(10),
        FAX      VARCHAR2(10)
);
---------------------
CREATE TABLE MATHANG(
        MAHANG      NUMBER(15) PRIMARY KEY,
        TENHANG      VARCHAR2(15) ,
        MACONGTY    NUMBER(10),
        MALOAIHANG        NUMBER(10),
        SOLUONG        NUMBER(10),
        DONVITINH   VARCHAR2(10),
        GIAHANG      NUMBER(10)
);
---------------------
CREATE TABLE DONDATHANG(
        SOHOADON      NUMBER(15) PRIMARY KEY,
        MAKHACHHANG      VARCHAR2(15) ,
        MANHANVIEN    NUMBER(10),
        NGAYDATHANG        DATE,
        NGAYGIAOHANG        DATE,
        NGAYCHUYENHANG   DATE,
        NOIGIAOHANG      VARCHAR2(10)
);
----------------------
CREATE TABLE CHITIETDATHANG(
        SOHOADON      NUMBER(15) PRIMARY KEY,
        MAHANG      VARCHAR2(15),
        GIABAN    NUMBER(10) ,
        SOLUONG        NUMBER(10),
        MUCGIAMGIA    NUMBER(10)
);
--------------------------
CREATE TABLE LOAIHANG(
        MALOAIHANG      NUMBER(15) PRIMARY KEY,
        TENLOAIHANG      VARCHAR2(15)
);
--------------------------
CREATE TABLE CHITIETDATHANG(
        MALOAIHANG      NUMBER(15) PRIMARY KEY,
        TENLOAIHANG      VARCHAR2(15)
);
--------------------------
CREATE TABLE NHANVIEN(
        MANHANVIEN      NUMBER(15) PRIMARY KEY,
        HO      VARCHAR2(15) NOT NULL,
        TEN    VARCHAR2(10),
        NGAYSINH        DATE,
        NGAYLAMVIEC        DATE,
        DIACHI   VARCHAR2(10),
        DIENTHOAI      NUMBER(10),
        LUONGCOBAN NUMBER(10),
        PHUCAP NUMBER(10)
);
------------------------------------------ ALTER -----------------------------------
ALTER TABLE DONDATHANG
  MODIFY MAKHACHHANG NUMBER(15);
--------------------------
ALTER TABLE KHACHHANG
  MODIFY DIENTHOAI NUMBER(15);
  --------------------------
ALTER TABLE NHACUNGCAP
  MODIFY DIENTHOAI NUMBER(15);
--------------------------
ALTER TABLE CHITIETDATHANG
  MODIFY MAHANG NUMBER(15);
--------------------------
ALTER TABLE CHITIETDATHANG
  DROP PRIMARY KEY;
----------------------------
ALTER TABLE CHITIETDATHANG
  ADD CONSTRAINT PK_CTDH PRIMARY KEY (MAHANG,SOHOADON);
----------------------------
ALTER TABLE DONDATHANG
ADD CONSTRAINT FK_DDH_KH
FOREIGN KEY (MAKHACHHANG) REFERENCES KHACHHANG(MAKHACHHANG);
----------------------------
ALTER TABLE CHITIETDATHANG
ADD CONSTRAINT FK_CTDH_DDH
FOREIGN KEY (SOHOADON) REFERENCES DONDATHANG(SOHOADON);
----------------------------
ALTER TABLE CHITIETDATHANG
ADD CONSTRAINT FK_CTMH_MH
FOREIGN KEY (MAHANG) REFERENCES MATHANG(MAHANG);
----------------------------
ALTER TABLE MATHANG
ADD CONSTRAINT FK_MH_NCC
FOREIGN KEY (MACONGTY) REFERENCES NHACUNGCAP(MACONGTY);
----------------------------
ALTER TABLE MATHANG
ADD CONSTRAINT FK_MH_LH
FOREIGN KEY (MALOAIHANG) REFERENCES LOAIHANG(MALOAIHANG);
----------------------------
ALTER TABLE DONDATHANG
ADD CONSTRAINT FK_DDH_NV
FOREIGN KEY (MANHANVIEN) REFERENCES NHANVIEN(MANHANVIEN);