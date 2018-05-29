
CREATE TABLE quanly
(
    account NVARCHAR2(50) PRIMARY KEY,
    firstname NVARCHAR2(50),
    lastname NVARCHAR2(50),
    email NVARCHAR2(50),
    editdate NVARCHAR2(50)
)

INSERT INTO quanly VALUES ('a','','','','');
SELECT * FROM hocvien;


CREATE TABLE hocvien
(
    account NVARCHAR2(50),
    id int PRIMARY KEY,
    hoten NVARCHAR2(50),
    email NVARCHAR2(50),
    sdt int,
    lop NVARCHAR2(50),
    ghichu NVARCHAR2(50)
)

select * from quanly where account = 'a';