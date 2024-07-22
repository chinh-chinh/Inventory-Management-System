/* nhakho: nhà kho
	manhakho: mã nhà kho
	tennhakho: tên nhà kho
	diachi: địa chỉ
	vaitro: vai trò
	mavaitro: mã vai trò
	tenvaitro: tên vai trò
	mota: mô tả 
	nhacungcap: nhà cung cấp
	manhacungcap: mã nhà cung cấp
	tennhacungcap: tên nhà cung cấp
	sodienthoai: số điện thoại
	diachinhacungcap: địa chỉ nhà cung cấp
	sanpham: sản phẩm
	masanpham: mã sản phẩm
	tensanpham: tên sản phẩm
	donvisanpham: đơn vị sản phẩm
	trangthaisanpham: trạng thái sản phẩm
	dongia: đơn giá
	soluong: số lượng
	chitietkhac: chi tiết khác
	quanly: quản lý
	maquanly: mã quản lý
	tendaydu: tên đầy đủ
	luong: lương
	ngaysinh: ngày sinh
	nhanvien: nhân viên
	manhanvien: mã nhân viên
	khachhang: khách hàng
	makhachhang: mã khách hàng
	dathang: đặt hàng
	madathang: mã đặt hàng
	thoigiandathang: thời gian đặt hàng
	chitietdathang: chi tiết đặt hàng
	chietkhau: chiết khấu
	tongconggiatri: tổng cộng giá trị
	cungcap: cung cấp
	manhacungcap: mã nhà cung cấp
	thoigiancungcap: thời gian cung cấp		*/


CREATE TABLE nhakho (
manhakho VARCHAR(20) NOT NULL PRIMARY KEY,
tennhakho VARCHAR(20),
diachi VARCHAR(50)
);

CREATE TABLE vaitro (
mavaitro VARCHAR(20) NOT NULL PRIMARY KEY,
tenvaitro VARCHAR(50),
mota VARCHAR(50)
);

CREATE TABLE nhacungcap (
manhacungcap INT NOT NULL PRIMARY KEY,
tennhacungcap VARCHAR(50),
sodienthoai VARCHAR(12),
email VARCHAR(50),
fax VARCHAR(50),
website VARCHAR(100),
diachinhacungcap VARCHAR(50)
);

CREATE TABLE sanpham(
masanpham VARCHAR(50) NOT NULL PRIMARY KEY,
tensanpham VARCHAR(50),
mota VARCHAR(50),
donvisanpham VARCHAR(10),
dongia NUMERIC(20,2),
soluong NUMERIC(10,2),
trangthaisanpham VARCHAR(50),
chitietkhac VARCHAR(50),
manhakho VARCHAR(20)
);
CREATE INDEX sanpham_FK ON sanpham(manhakho);
ALTER TABLE sanpham ADD CONSTRAINT sanpham_FK FOREIGN KEY (manhakho) REFERENCES nhakho(manhakho);

CREATE TABLE quanly (
maquanly VARCHAR(50) NOT NULL PRIMARY KEY,
tendaydu VARCHAR(50),
sodienthoai VARCHAR(12),
email VARCHAR(50),
diachi VARCHAR(50),
luong NUMERIC(20,2),
ngaysinh DATETIME,
mavaitro VARCHAR(50)
);
CREATE INDEX quanly_FK ON quanly(mavaitro);
ALTER TABLE quanly ADD CONSTRAINT quanly_FK FOREIGN KEY (mavaitro) REFERENCES vaitro(mavaitro);

CREATE TABLE nhanvien (
manhanvien VARCHAR(50) NOT NULL PRIMARY KEY,
tendaydu VARCHAR(50),
sodienthoai VARCHAR(12),
email VARCHAR(50),
diachi VARCHAR(50),
luong NUMERIC(20,2),
ngaysinh DATETIME,
mavaitro VARCHAR(50),
maquanly VARCHAR(50)
);
CREATE INDEX nhanvien_FK1 ON nhanvien(mavaitro);
CREATE INDEX nhanvien_FK2 ON nhanvien(maquanly);
ALTER TABLE nhanvien ADD CONSTRAINT nhanvien_FK1 FOREIGN KEY (mavaitro) REFERENCES vaitro(mavaitro);
ALTER TABLE nhanvien ADD CONSTRAINT nhanvien_FK2 FOREIGN KEY (maquanly) REFERENCES quanly(maquanly);

CREATE TABLE khachhang (
makhachhang INT NOT NULL PRIMARY KEY,
tendaydu VARCHAR(50),
sodienthoai VARCHAR(12),
email VARCHAR(50),
diachi VARCHAR(50),
manhanvien VARCHAR(50) 
);
CREATE INDEX khachhang_FK ON khachhang(manhanvien);
ALTER TABLE khachhang ADD CONSTRAINT khachhang_FK FOREIGN KEY (manhanvien) REFERENCES nhanvien(manhanvien);

CREATE TABLE dathang (
madathang VARCHAR(50) NOT NULL PRIMARY KEY,
thoigiandathang DATETIME,
makhachhang INT 
);
CREATE INDEX dathang_FK ON dathang(makhachhang);
ALTER TABLE dathang ADD CONSTRAINT dathang_FK FOREIGN KEY (makhachhang) REFERENCES khachhang(makhachhang);

CREATE TABLE chitietdathang (
madathang VARCHAR(50) NOT NULL,
masanpham VARCHAR(50) NOT NULL,
dongia NUMERIC(20,2),
soluong NUMERIC(10,2),
chietkhau NUMERIC(10,5),
tongconggiatri NUMERIC(20,2),
PRIMARY KEY (madathang, masanpham)
);
CREATE INDEX chitietdathang_PK_FK1 ON chitietdathang(madathang);
CREATE INDEX chitietdathang_PK_FK2 ON chitietdathang(masanpham);
ALTER TABLE chitietdathang ADD CONSTRAINT chitietdathang_FK1 FOREIGN KEY (madathang) REFERENCES dathang(madathang);
ALTER TABLE chitietdathang ADD CONSTRAINT chitietdathang_FK2 FOREIGN KEY (masanpham) REFERENCES sanpham(masanpham);

CREATE TABLE cungcap (
manhacungcap INT NOT NULL,
masanpham VARCHAR(50),
maquanly VARCHAR(50),
thoigiancungcap DATETIME,
soluong NUMERIC(10,2),
dongia NUMERIC(20,2),
donvisanpham VARCHAR(10),
mota VARCHAR(50),
trangthaisanpham VARCHAR(50),
chitietkhac VARCHAR(50),
PRIMARY KEY (manhacungcap, masanpham, maquanly)
);
CREATE INDEX cungcap_PK_FK1 ON cungcap(manhacungcap);
CREATE INDEX cungcap_PK_FK2 ON cungcap(masanpham);
CREATE INDEX cungcap_PK_FK3 ON cungcap(maquanly);
ALTER TABLE cungcap ADD CONSTRAINT cungcap_PK_FK1 FOREIGN KEY (manhacungcap) REFERENCES nhacungcap(manhacungcap);
ALTER TABLE cungcap ADD CONSTRAINT cungcap_PK_FK2 FOREIGN KEY (masanpham) REFERENCES sanpham(masanpham);
ALTER TABLE cungcap ADD CONSTRAINT cungcap_PK_FK3 FOREIGN KEY (maquanly) REFERENCES quanly(maquanly);