SELECT * FROM KHACHHANG;
SELECT * FROM NHACUNGCAP;
SELECT * FROM DONDATHANG;
SELECT * FROM CHITIETDATHANG;
SELECT * FROM MATHANG;
SELECT * FROM NHANVIEN;
----1.    Hãy cho bi?t có nh?ng khách hàng nào l?i chính là ??i tác cung c?p hàng c?a công ty (t?c là có cùng tên giao d?ch).   ----
    SELECT  KHACHHANG.MAKHACHHANG 
    FROM KHACHHANG INNER JOIN NHACUNGCAP ON NHACUNGCAP.TENCONGTY = KHACHHANG.TENCONGTY 
    WHERE NHACUNGCAP.TENGIAODICH = KHACHHANG.TENGIAODICH;
    
----2.     Nh?ng ??n ??t hàng nào yêu c?u giao hàng ngay t?i cty ??t hàng và nh?ng ??n ?ó là c?a công ty nào?   ----
    SELECT SOHOADON,TENCONGTY FROM KHACHHANG 
    INNER JOIN DONDATHANG ON DONDATHANG.MAKHACHHANG = KHACHHANG.MAKHACHHANG
    WHERE KHACHHANG.DIACHI = DONDATHANG.NOIGIAOHANG;
    
----3.     Nh?ng m?t hàng nào ch?a t?ng ???c khách hàng ??t mua?    ----
    SELECT MAHANG,TENHANG FROM MATHANG 
    WHERE NOT EXISTS (SELECT MAHANG from CHITIETDATHANG where CHITIETDATHANG.MAHANG=MATHANG.MAHANG);
    
----4.     Nh?ng nhân viên nào c?a công ty ch?a t?ng l?p b?t k? m?t hoá ??n ??t hàng nào?    ----
    SELECT TEN FROM NHANVIEN
    WHERE NOT EXISTS (SELECT MANHANVIEN FROM DONDATHANG WHERE DONDATHANG.MANHANVIEN=NHANVIEN.MANHANVIEN);
    
----5.     Trong n?m 2003, nh?ng m?t hàng nào ch? ???c ??t mua ?úng m?t l?n     ----
    SELECT mathang.mahang,tenhang 
    FROM mathang INNER JOIN chitietdathang
                ON mathang.mahang=chitietdathang.mahang
                INNER JOIN dondathang
                ON chitietdathang.sohoadon=dondathang.sohoadon
    WHERE EXTRACT(YEAR FROM ngaydathang)=2003 GROUP BY mathang.mahang,tenhang HAVING COUNT(chitietdathang.mahang)=1;
    
----6.     Hãy cho bi?t m?i m?t khách hàng ?ã ph?i b? ra bao nhiêu ti?n ?? ??t mua hàng c?a công ty?
    SELECT KHACHHANG.MAKHACHHANG,TENCONGTY,TENGIAODICH,SUM(SOLUONG*GIABAN-SOLUONG*GIABAN*MUCGIAMGIA/100) AS TONGTIEN
    FROM KHACHHANG INNER JOIN DONDATHANG 
        ON DONDATHANG.MAKHACHHANG=KHACHHANG.MAKHACHHANG
        INNER JOIN CHITIETDATHANG
        ON CHITIETDATHANG.SOHOADON=DONDATHANG.SOHOADON
    GROUP BY KHACHHANG.MAKHACHHANG,TENCONGTY,TENGIAODICH;
    
----7.     M?i m?t nhân viên c?a công ty ?ã l?p bao nhiêu ??n ??t hàng (n?u nhân viên ch?a h? l?p m?t hoá ??n nào thì cho k?t qu? là 0)
    SELECT NHANVIEN.MANHANVIEN,TEN,HO,COUNT(SOHOADON)AS TONGSOHODON FROM NHANVIEN INNER JOIN DONDATHANG
        ON DONDATHANG.MANHANVIEN=NHANVIEN.MANHANVIEN
    GROUP BY NHANVIEN.MANHANVIEN,TEN,HO
    ORDER BY COUNT(SOHOADON);
    
----8.     Cho bi?t t?ng s? ti?n hàng mà c?a hàng thu ???c trong m?i tháng c?a n?m 2003 (th?i ???c gian tính theo ngày ??t hàng).
    SELECT EXTRACT( MONTH from NGAYDATHANG) AS THANG,SUM(SOLUONG*GIABAN-SOLUONG*GIABAN*MUCGIAMGIA/100) AS TONGTHUNHAP 
    FROM DONDATHANG   LEFT OUTER JOIN CHITIETDATHANG
        ON CHITIETDATHANG.SOHOADON=DONDATHANG.SOHOADON
    WHERE EXTRACT( YEAR from NGAYDATHANG)=2018
    group by EXTRACT( MONTH from NGAYDATHANG)
    ORDER BY THANG;
    
----9.     Hãy cho bi?t t?ng s? l??ng hàng c?a m?i m?t hàng mà cty ?ã có (t?ng s? l??ng hàng hi?n có và ?ã bán).
    SELECT MATHANG.MAHANG,TENHANG,MATHANG.SOLUONG + CASE
        WHEN SUM(CHITIETDATHANG.SOLUONG) IS NULL THEN 0
        ELSE SUM(CHITIETDATHANG.SOLUONG)
       END AS TONGLUONGHANG
    FROM MATHANG INNER JOIN CHITIETDATHANG
        ON MATHANG.MAHANG=CHITIETDATHANG.MAHANG 
        group by TENHANG, MATHANG.MAHANG,MATHANG.SOLUONG
        ORDER BY TONGLUONGHANG DESC ;
        
----10.  Nhân viên nào c?a cty bán ???c s? l??ng hàng nhi?u nh?t và s? l??ng hàng bán ???c c?a nhân viên này là bao nhiêu?
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

----    11. M?i m?t ??n ??t hàng ??t mua nh?ng m?t hàng nào và t?ng s? ti?n mà m?i ??n ??t hàng ph?i tr? là bao nhiêu?

----    12.  Hãy cho bi?t m?i m?t lo?i hàng bao g?m nh?ng m?t hàng nào, t?ng s? l??ng hàng c?a m?i lo?i và t?ng s? l??ng c?a t?t c? các m?t hàng hi?n có trong công ty là bao nhiêu?

----    13.  Th?ng kê xem trong n?m 2003, m?i m?t m?t hàng trong m?i tháng và trong c? n?m bán ???c v?i s? l??ng bao nhiêu.
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

----    14.  C?p nh?t l?i giá tr? NGAYCHUYENHANG c?a nh?ng b?n ghi có giá tr? NGAYCHUYENHANG ch?a xác ??nh (NULL) trong b?ng DONDATHANG b?ng v?i giá tr? c?a tr??ng NGAYDATHANG.
    UPDATE DONDATHANG
    
    SET NGAYCHUYENHANG=NGAYDATHANG
    
    WHERE NGAYCHUYENHANG IS NULL;
    
----    15.  C?p nh?t giá tr? c?a tr??ng NOIGIAOHANG trong b?ng DONDATHANG b?ng ??a ch? c?a khách hàng ??i v?i nh?ng ??n ??t hàng ch?a xác ??nh ???c n?i giao hàng (có giá tr? tr??ng NOIGIAOHANG b?ng NULL)
  ----sai 
    UPDATE DONDATHANG
    
    SET NOIGIAOHANG= ( SELECT DIACHI
    
    FROM KHACHHANG
    
    WHERE DONDATHANG.MAKHACHHANG=KHACHHANG.MAKHACHHANG)
    
          WHERE NOIGIAOHANG IS NULL;
          
--ROLLBACK;--

----    16.  C?p nh?t l?i d? li?u trong b?ng KHACHHANG sao cho n?u tên công ty và tên giao d?ch c?a khách hàng trùng v?i tên công ty và tên giao d?ch c?a m?t nhà cung c?p nào ?ó thì ??a ch?, ?i?n tho?i, fax và email ph?i gi?ng nhau.
----sai
    UPDATE KHACHHANG
    
    SET  KHACHHANG.DIACHI=(SELECT NHACUNGCAP.DIACHI FROM NHACUNGCAP),
    
          KHACHHANG.DIENTHOAI=(SELECT NHACUNGCAP.DIENTHOAI FROM NHACUNGCAP),
    
          KHACHHANG.FAX=(SELECT NHACUNGCAP.FAX FROM NHACUNGCAP),
    
          KHACHHANG.EMAIL=(SELECT NHACUNGCAP.EMAIL FROM NHACUNGCAP)
          
    WHERE KHACHHANG.TENCONGTY=NHACUNGCAP.TENCONGTY AND KHACHHANG.TENGIAODICH=NHACUNGCAP.TENGIAODICH;
    ----    17.  T?ng l??ng lên g?p r??i cho nh?ng nhân viên bán ???c s? l??ng hàng nhi?u h?n 100 trong n?m 2003
        UPDATE NHANVIEN
    
        SET LUONGCOBAN=LUONGCOBAN*1.5
        
        WHERE NHANVIEN.MANHANVIEN=
        
                (SELECT MANHANVIEN
        
                 FROM DONDATHANG INNER JOIN CHITIETDATHANG
        
               ON DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON
        
               WHERE MANHANVIEN=NHANVIEN.MANHANVIEN
        
               GROUP BY DONDATHANG.MANHANVIEN
    
           HAVING  SUM(SOLUONG)>100 AND EXTRACT (YEAR FROM DONDATHANG.NGAYGIAOHANG)=2003);
           
---- 18.  T?ng ph? c?p lên b?ng 50% l??ng cho nh?ng nhân viên bán ???c hàng nhi?u nh?t.
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
                    
----    19. Gi?m 25% l??ng c?a nh?ng nhân viên trong n?m 2003 ko l?p ???c b?t k? ??n ??t hàng nào

    UPDATE NHANVIEN
    
    SET LUONGCOBAN= LUONGCOBAN-LUONGCOBAN*0.25
    
    WHERE NOT EXISTS (SELECT MANHANVIEN FROM DONDATHANG WHERE DONDATHANG.MANHANVIEN=NHANVIEN.MANHANVIEN);

        --ROLLBACK;
----    20.  Gi? s? trong b?ng DONDATHANG có them tr??ng SOTIEN cho bi?t s? ti?n mà khách hàng ph?i tr? trong m?i d?n??t hàng. Hãy tính giá tr? cho tr??ng này.
    UPDATE DONDATHANG

    SET TONGTHUNHAP = (SELECT SUM(SOLUONG*GIABAN- SOLUONG*GIABAN*MUCGIAMGIA)

                        FROM CHITIETDATHANG WHERE DONDATHANG.SOHOADON=CHITIETDATHANG.SOHOADON);
---- 21.Xoá kh?i b?ng MATHANG nh?ng m?t hàng có s? l??ng b?ng 0 và không ???c ??t mua trong b?t k? ??n ??t hàng nào.
    DELETE FROM MATHANG
    
            WHERE NOT EXISTS (SELECT MAHANG FROM CHITIETDATHANG WHERE CHITIETDATHANG.MAHANG=MATHANG.MAHANG) AND MATHANG.SOLUONG =0;



-----------------------------------------------Yêu c?u 3 lam quen voi trigger----------------------------------------
----    1.     T?o th? t?c l?u tr? ?? thông qua th? t?c này có th? b? sung thêm m?t b?n ghi m?i cho b?ng MATHANG (th? t?c ph?i th?c hi?n ki?m tra tính h?p l? c?a d? li?u c?n b? sung: không trùng khoá chính và ??m b?o toàn v?n tham chi?u)
----    2.     T?o th? t?c l?u tr? có ch?c n?ng th?ng kê t?ng s? l??ng hàng bán ???c c?a m?t m?t hàng có mã b?t k? (mã m?t hàng c?n th?ng kê là tham s? c?a th? t?c).
--      3.     Vi?t trigger cho b?ng CHITIETDATHANG theo yêu c?u sau:

        --       Khi m?t b?n ghi m?i ???c b? sung vào b?ng này thì gi?m s? l??ng hàng hi?n có n?u s? l??ng hàng hi?n có l?n h?n ho?c b?ng s? l??ng hàng ???c bán ra. Ng??c l?i thì hu? b? thao tác b? sung.
   
        --      Khi c?p nh?t l?i s? l??ng hàng ???c bán, ki?m tra s? l??ng hàng ???c c?p nh?t l?i có phù h?p hay không (s? l??ng hàng bán ra không ???c v??t quá s? l??ng hàng hi?n có và không ???c nh? h?n 1). N?u d? li?u h?p l? thì gi?m (ho?c t?ng) s? l??ng hàng hi?n có trong công ty, ng??c l?i thì hu? b? thao tác c?p nh?t.

----    4.     Vi?t trigger cho b?ng CHITIETDATHANG ?? sao cho ch? ch?p nh?n giá hàng bán ra ph?i nh? h?n ho?c b?ng giá g?c (giá c?a m?t hàng trong b?ng MATHANG)
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