SELECT * FROM KHACHHANG;
SELECT * FROM NHACUNGCAP;
SELECT * FROM DONDATHANG;
SELECT * FROM CHITIETDATHANG;
SELECT * FROM MATHANG;
SELECT * FROM NHANVIEN;
----1.    H�y cho bi?t c� nh?ng kh�ch h�ng n�o l?i ch�nh l� ??i t�c cung c?p h�ng c?a c�ng ty (t?c l� c� c�ng t�n giao d?ch).   ----
    SELECT  KHACHHANG.MAKHACHHANG 
    FROM KHACHHANG INNER JOIN NHACUNGCAP ON NHACUNGCAP.TENCONGTY = KHACHHANG.TENCONGTY 
    WHERE NHACUNGCAP.TENGIAODICH = KHACHHANG.TENGIAODICH;
    
----2.     Nh?ng ??n ??t h�ng n�o y�u c?u giao h�ng ngay t?i cty ??t h�ng v� nh?ng ??n ?� l� c?a c�ng ty n�o?   ----
    SELECT SOHOADON,TENCONGTY FROM KHACHHANG 
    INNER JOIN DONDATHANG ON DONDATHANG.MAKHACHHANG = KHACHHANG.MAKHACHHANG
    WHERE KHACHHANG.DIACHI = DONDATHANG.NOIGIAOHANG;
    
----3.     Nh?ng m?t h�ng n�o ch?a t?ng ???c kh�ch h�ng ??t mua?    ----
    SELECT MAHANG,TENHANG FROM MATHANG 
    WHERE NOT EXISTS (SELECT MAHANG from CHITIETDATHANG where CHITIETDATHANG.MAHANG=MATHANG.MAHANG);
    
----4.     Nh?ng nh�n vi�n n�o c?a c�ng ty ch?a t?ng l?p b?t k? m?t ho� ??n ??t h�ng n�o?    ----
    SELECT TEN FROM NHANVIEN
    WHERE NOT EXISTS (SELECT MANHANVIEN FROM DONDATHANG WHERE DONDATHANG.MANHANVIEN=NHANVIEN.MANHANVIEN);
    
----5.     Trong n?m 2003, nh?ng m?t h�ng n�o ch? ???c ??t mua ?�ng m?t l?n     ----
    SELECT mathang.mahang,tenhang 
    FROM mathang INNER JOIN chitietdathang
                ON mathang.mahang=chitietdathang.mahang
                INNER JOIN dondathang
                ON chitietdathang.sohoadon=dondathang.sohoadon
    WHERE EXTRACT(YEAR FROM ngaydathang)=2003 GROUP BY mathang.mahang,tenhang HAVING COUNT(chitietdathang.mahang)=1;
    
----6.     H�y cho bi?t m?i m?t kh�ch h�ng ?� ph?i b? ra bao nhi�u ti?n ?? ??t mua h�ng c?a c�ng ty?
    SELECT KHACHHANG.MAKHACHHANG,TENCONGTY,TENGIAODICH,SUM(SOLUONG*GIABAN-SOLUONG*GIABAN*MUCGIAMGIA/100) AS TONGTIEN
    FROM KHACHHANG INNER JOIN DONDATHANG 
        ON DONDATHANG.MAKHACHHANG=KHACHHANG.MAKHACHHANG
        INNER JOIN CHITIETDATHANG
        ON CHITIETDATHANG.SOHOADON=DONDATHANG.SOHOADON
    GROUP BY KHACHHANG.MAKHACHHANG,TENCONGTY,TENGIAODICH;
    
----7.     M?i m?t nh�n vi�n c?a c�ng ty ?� l?p bao nhi�u ??n ??t h�ng (n?u nh�n vi�n ch?a h? l?p m?t ho� ??n n�o th� cho k?t qu? l� 0)
    SELECT NHANVIEN.MANHANVIEN,TEN,HO,COUNT(SOHOADON)AS TONGSOHODON FROM NHANVIEN INNER JOIN DONDATHANG
        ON DONDATHANG.MANHANVIEN=NHANVIEN.MANHANVIEN
    GROUP BY NHANVIEN.MANHANVIEN,TEN,HO
    ORDER BY COUNT(SOHOADON);
    
----8.     Cho bi?t t?ng s? ti?n h�ng m� c?a h�ng thu ???c trong m?i th�ng c?a n?m 2003 (th?i ???c gian t�nh theo ng�y ??t h�ng).
    SELECT EXTRACT( MONTH from NGAYDATHANG) AS THANG,SUM(SOLUONG*GIABAN-SOLUONG*GIABAN*MUCGIAMGIA/100) AS TONGTHUNHAP 
    FROM DONDATHANG   LEFT OUTER JOIN CHITIETDATHANG
        ON CHITIETDATHANG.SOHOADON=DONDATHANG.SOHOADON
    WHERE EXTRACT( YEAR from NGAYDATHANG)=2018
    group by EXTRACT( MONTH from NGAYDATHANG)
    ORDER BY THANG;
    
----9.     H�y cho bi?t t?ng s? l??ng h�ng c?a m?i m?t h�ng m� cty ?� c� (t?ng s? l??ng h�ng hi?n c� v� ?� b�n).
    SELECT MATHANG.MAHANG,TENHANG,MATHANG.SOLUONG + CASE
        WHEN SUM(CHITIETDATHANG.SOLUONG) IS NULL THEN 0
        ELSE SUM(CHITIETDATHANG.SOLUONG)
       END AS TONGLUONGHANG
    FROM MATHANG INNER JOIN CHITIETDATHANG
        ON MATHANG.MAHANG=CHITIETDATHANG.MAHANG 
        group by TENHANG, MATHANG.MAHANG,MATHANG.SOLUONG
        ORDER BY TONGLUONGHANG DESC ;
        
----10.  Nh�n vi�n n�o c?a cty b�n ???c s? l??ng h�ng nhi?u nh?t v� s? l??ng h�ng b�n ???c c?a nh�n vi�n n�y l� bao nhi�u?
    SELECT nhanvien.manhanvien, ho,ten,SUM(soluong)as tongsoluong

FROM (nhanvien INNER JOIN dondathang

        ON nhanvien.manhanvien=dondathang.manhanvien)

        INNER JOIN chitietdathang

        ON dondathang.sohoadon=chitietdathang.sohoadon

GROUP BY nhanvien.manhanvien,ho,ten

HAVING SUM(soluong)>=ALL

         (SELECT sum(soluong)

            FROM (nhanvien INNER JOIN dondathang

                    ON nhanvien.manhanvien=dondathang.manhanvien)

                    INNER JOIN chitietdathang ON

                    dondathang.sohoadon=chitietdathang.sohoadon

            GROUP BY nhanvien.manhanvien,ho,ten);

----    11. M?i m?t ??n ??t h�ng ??t mua nh?ng m?t h�ng n�o v� t?ng s? ti?n m� m?i ??n ??t h�ng ph?i tr? l� bao nhi�u?

----    12.  H�y cho bi?t m?i m?t lo?i h�ng bao g?m nh?ng m?t h�ng n�o, t?ng s? l??ng h�ng c?a m?i lo?i v� t?ng s? l??ng c?a t?t c? c�c m?t h�ng hi?n c� trong c�ng ty l� bao nhi�u?

----    13.  Th?ng k� xem trong n?m 2003, m?i m?t m?t h�ng trong m?i th�ng v� trong c? n?m b�n ???c v?i s? l??ng bao nhi�u.
SELECT CHITIETDATHANG.MAHANG,TENHANG,

         SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 1 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG1,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 2 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG2,

         SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 3 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG3,

         SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 4 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG4,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 5 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG5,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 6 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG6,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 7 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG7,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 8 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG8,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 9 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG9,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 10 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG10,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 11 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG11,

       SUM(CASE EXTRACT(MONTH FROM NGAYDATHANG)WHEN 12 THEN CHITIETDATHANG.SOLUONG

               ELSE 0 END) AS THANG12,

       SUM (CHITIETDATHANG.SOLUONG) AS CANAM

FROM (DONDATHANG INNER JOIN CHITIETDATHANG

        ON DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON)

        INNER JOIN MATHANG ON CHITIETDATHANG.MAHANG=MATHANG.MAHANG

WHERE EXTRACT (YEAR FROM NGAYDATHANG)=2003

GROUP BY TENHANG, CHITIETDATHANG.MAHANG;

----    14.  C?p nh?t l?i gi� tr? NGAYCHUYENHANG c?a nh?ng b?n ghi c� gi� tr? NGAYCHUYENHANG ch?a x�c ??nh (NULL) trong b?ng DONDATHANG b?ng v?i gi� tr? c?a tr??ng NGAYDATHANG.
    UPDATE DONDATHANG
    
    SET NGAYCHUYENHANG=NGAYDATHANG
    
    WHERE NGAYCHUYENHANG IS NULL;
    
----    15.  C?p nh?t gi� tr? c?a tr??ng NOIGIAOHANG trong b?ng DONDATHANG b?ng ??a ch? c?a kh�ch h�ng ??i v?i nh?ng ??n ??t h�ng ch?a x�c ??nh ???c n?i giao h�ng (c� gi� tr? tr??ng NOIGIAOHANG b?ng NULL)
  ----sai 
    UPDATE DONDATHANG
    
    SET NOIGIAOHANG= ( SELECT DIACHI
    
    FROM KHACHHANG
    
    WHERE DONDATHANG.MAKHACHHANG=KHACHHANG.MAKHACHHANG)
    
          WHERE NOIGIAOHANG IS NULL;
          
--ROLLBACK;--

----    16.  C?p nh?t l?i d? li?u trong b?ng KHACHHANG sao cho n?u t�n c�ng ty v� t�n giao d?ch c?a kh�ch h�ng tr�ng v?i t�n c�ng ty v� t�n giao d?ch c?a m?t nh� cung c?p n�o ?� th� ??a ch?, ?i?n tho?i, fax v� email ph?i gi?ng nhau.
----sai
    UPDATE KHACHHANG
    
    SET  KHACHHANG.DIACHI=(SELECT NHACUNGCAP.DIACHI FROM NHACUNGCAP),
    
          KHACHHANG.DIENTHOAI=(SELECT NHACUNGCAP.DIENTHOAI FROM NHACUNGCAP),
    
          KHACHHANG.FAX=(SELECT NHACUNGCAP.FAX FROM NHACUNGCAP),
    
          KHACHHANG.EMAIL=(SELECT NHACUNGCAP.EMAIL FROM NHACUNGCAP)
          
    WHERE KHACHHANG.TENCONGTY=NHACUNGCAP.TENCONGTY AND KHACHHANG.TENGIAODICH=NHACUNGCAP.TENGIAODICH;
    ----    17.  T?ng l??ng l�n g?p r??i cho nh?ng nh�n vi�n b�n ???c s? l??ng h�ng nhi?u h?n 100 trong n?m 2003
        UPDATE NHANVIEN
    
        SET LUONGCOBAN=LUONGCOBAN*1.5
        
        WHERE NHANVIEN.MANHANVIEN=
        
                (SELECT MANHANVIEN
        
                 FROM DONDATHANG INNER JOIN CHITIETDATHANG
        
               ON DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON
        
               WHERE MANHANVIEN=NHANVIEN.MANHANVIEN
        
               GROUP BY DONDATHANG.MANHANVIEN
    
           HAVING  SUM(SOLUONG)>100 AND EXTRACT (YEAR FROM DONDATHANG.NGAYGIAOHANG)=2003);
           
---- 18.  T?ng ph? c?p l�n b?ng 50% l??ng cho nh?ng nh�n vi�n b�n ???c h�ng nhi?u nh?t.
    UPDATE NHANVIEN

    SET PHUCAP=LUONGCOBAN/2
    
    WHERE MANHANVIEN IN
    
                      (SELECT MANHANVIEN
    
                      FROM DONDATHANG, CHITIETDATHANG
    
                      WHERE DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON
    
                      GROUP BY MANHANVIEN
    
                      HAVING SUM (SOLUONG)>= ALL
    
                                             
    
    (SELECT SUM (SOLUONG)FROM DONDATHANG,CHITIETDATHANG
    
                      WHERE DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON
    
                                              GROUP BY MANHANVIEN));
                    --ROLLBACK;
                    
----    19. Gi?m 25% l??ng c?a nh?ng nh�n vi�n trong n?m 2003 ko l?p ???c b?t k? ??n ??t h�ng n�o

    UPDATE NHANVIEN
    
    SET LUONGCOBAN= LUONGCOBAN-LUONGCOBAN*0.25
    
    WHERE NOT EXISTS (SELECT MANHANVIEN FROM DONDATHANG WHERE DONDATHANG.MANHANVIEN=NHANVIEN.MANHANVIEN);

        --ROLLBACK;
----    20.  Gi? s? trong b?ng DONDATHANG c� them tr??ng SOTIEN cho bi?t s? ti?n m� kh�ch h�ng ph?i tr? trong m?i d?n??t h�ng. H�y t�nh gi� tr? cho tr??ng n�y.
    UPDATE DONDATHANG

    SET TONGTHUNHAP = (SELECT SUM(SOLUONG*GIABAN- SOLUONG*GIABAN*MUCGIAMGIA)

                        FROM CHITIETDATHANG WHERE DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON);
---- 21.Xo� kh?i b?ng MATHANG nh?ng m?t h�ng c� s? l??ng b?ng 0 v� kh�ng ???c ??t mua trong b?t k? ??n ??t h�ng n�o.
    DELETE FROM MATHANG
    
            WHERE NOT EXISTS (SELECT MAHANG FROM CHITIETDATHANG WHERE CHITIETDATHANG.MAHANG=MATHANG.MAHANG) AND MATHANG.SOLUONG =0;



-----------------------------------------------Y�u c?u 3 lam quen voi trigger----------------------------------------
----    1.     T?o th? t?c l?u tr? ?? th�ng qua th? t?c n�y c� th? b? sung th�m m?t b?n ghi m?i cho b?ng MATHANG (th? t?c ph?i th?c hi?n ki?m tra t�nh h?p l? c?a d? li?u c?n b? sung: kh�ng tr�ng kho� ch�nh v� ??m b?o to�n v?n tham chi?u)
----    2.     T?o th? t?c l?u tr? c� ch?c n?ng th?ng k� t?ng s? l??ng h�ng b�n ???c c?a m?t m?t h�ng c� m� b?t k? (m� m?t h�ng c?n th?ng k� l� tham s? c?a th? t?c).
--      3.     Vi?t trigger cho b?ng CHITIETDATHANG theo y�u c?u sau:

        --       Khi m?t b?n ghi m?i ???c b? sung v�o b?ng n�y th� gi?m s? l??ng h�ng hi?n c� n?u s? l??ng h�ng hi?n c� l?n h?n ho?c b?ng s? l??ng h�ng ???c b�n ra. Ng??c l?i th� hu? b? thao t�c b? sung.
   
        --      Khi c?p nh?t l?i s? l??ng h�ng ???c b�n, ki?m tra s? l??ng h�ng ???c c?p nh?t l?i c� ph� h?p hay kh�ng (s? l??ng h�ng b�n ra kh�ng ???c v??t qu� s? l??ng h�ng hi?n c� v� kh�ng ???c nh? h?n 1). N?u d? li?u h?p l? th� gi?m (ho?c t?ng) s? l??ng h�ng hi?n c� trong c�ng ty, ng??c l?i th� hu? b? thao t�c c?p nh?t.

----    4.     Vi?t trigger cho b?ng CHITIETDATHANG ?? sao cho ch? ch?p nh?n gi� h�ng b�n ra ph?i nh? h?n ho?c b?ng gi� g?c (gi� c?a m?t h�ng trong b?ng MATHANG)
    CREATE TRIGGER lnik.trg_chitietdathang_giaban
    
    BEFORE 
    
     INSERT OR UPDATE
    
   ON lnik.chitietdathang
    
    AS 
    
    IF UPDATE(giaban)
    
    IF EXISTS(SELECT inserted.mahang
    
    FROM mathang INNER JOIN inserted   
    
    ON mathang.mahang=inserted.mahang
    
    WHERE mathang.giahang>inserted.giaban)
    
    ROLLBACK TRANSACTION