Create database QuanLyKyTucXa
go

Use QuanLyKyTucXa
go

--Tạo bảng Bộ phận
Create Table BoPhan
(
	MaBoPhan nvarchar(10) not null,
	TenBoPhan nvarchar(50) not null,
	Primary Key Clustered ([MaBoPhan] ASC),
);
go

--Tạo bảng Chức vụ
Create Table ChucVu
(
	MaChucVu nvarchar(10) not null,
	TenChucVu nvarchar(50) not null,
	MaBoPhan nvarchar(10) not null,
	Primary Key Clustered ([MaChucVu] ASC),
	Foreign Key(MaBoPhan) References BoPhan(MaBoPhan)
);
go

--Tạo bảng Nhân viên
Create Table NhanVien
(
	MaNhanVien nvarchar(10) not null,
	TenNhanVien nvarchar(50) not null,
	DienThoai nvarchar(15) not null,
	NgaySinh datetime not null,
	Email nvarchar(50) not null,
	GioiTinh bit not null,
	MaChucVu nvarchar(10) not null,
	Primary Key Clustered ([MaNhanVien] ASC),
	Foreign Key(MaChucVu) References ChucVu(MaChucVu)
);
go

--Tạo bảng Loại phòng
Create Table Khu
(
	MaKhu nvarchar(10) not null,
	TenKhu nvarchar(50) not null,
	SLTang int not null,
	SLPhong int not null,
	Primary Key Clustered ([MaKhu] ASC),
);
go

--Tạo bảng Loại phòng
Create Table LoaiPhong
(
	MaLoaiPhong nvarchar(10) not null,
	GiaLoaiPhong float(53) not null,
	SoLuongSV int not null,
	TinhTrang bit default 0,
	Primary Key Clustered ([MaLoaiPhong] ASC),
);
go


--Tạo bảng Phòng
Create Table Phong
(
	SoPhong nvarchar(10) not null,
	SoLuongTB int not null,
	SoLuongSV int not null,
	GiaPhong float(53) not null,
	TinhTrang bit default 0,
	MaLoaiPhong nvarchar(10) not null,
	MaKhu nvarchar(10) not null,
	Primary Key Clustered ([SoPhong] ASC),
	Foreign Key(MaLoaiPhong) References LoaiPhong(MaLoaiPhong),
	Foreign Key(MaKhu) References Khu(MaKhu)
);
go

--Tạo bảng Sinh viên
Create Table SinhVien
(
	MaSinhVien nvarchar(10) not null,
	TenSinhVien nvarchar(50) not null,
	DienThoai nvarchar(15) not null,
	NgaySinh datetime not null,
	Email nvarchar(50) not null,
	CanCuoc nvarchar(20) not null,
	GioiTinh bit not null, -- 1:nam , 0:nữ
	SoPhong nvarchar(10) not null,
	Primary Key Clustered ([MaSinhVien] ASC),
	Foreign Key(SoPhong) References Phong(SoPhong)
);
go


--Tạo bảng Dịch vụ
Create Table DichVu
(
	MaDichVu nvarchar(10) not null,
	TenDichVu nvarchar(50) not null,
	TongTien float(53) not null,
	SoPhong nvarchar(10) not null,
	Primary Key Clustered ([MaDichVu] ASC),
	Foreign Key(SoPhong) References Phong(SoPhong)
);
go

--Tạo bảng Chi tiết dịch vụ
Create Table CTDichVu
(
	MaDichVu nvarchar(10) not null,
	MaHoaDon nvarchar(10) not null,
	DonGiaDien float(53) not null,
	DonGiaNuoc float(53) not null,
	ChiSoCuDien float(53) not null,
	ChiSoMoiDien float(53) not null,
	ChiSoCuNuoc float(53) not null,
	ChiSoMoiNuoc float(53) not null,
	ThueNuoc float(53) not null,
	ThueDien float(53) not null,
	Primary Key Clustered ([MaDichVu] ASC, [MaHoaDon] ASC),
);
go


--Tạo bảng Hợp đồng sinh viên
Create Table HopDong
(
	MaHopDong nvarchar(10) not null,
	MaNhanVien nvarchar(10) not null,
	MaSinhVien nvarchar(10) not null,
	TenHopDong nvarchar(50) not null,
	NgayLap datetime not null,
	NgayHetHan datetime not null,
	LePhi float(53) not null,
	TinhTrang bit default 0,
	DieuKhoanHD text not null,
	Primary Key Clustered ([MaHopDong] ASC),
	Foreign Key(MaNhanVien) References NhanVien(MaNhanVien),
	Foreign Key(MaSinhVien) References SinhVien(MaSinhVien)
);
go

--Tạo bảng Hợp đơn
Create Table HoaDon
(
	MaHoaDon nvarchar(10) not null,
	MaNhanVien nvarchar(10) not null,
	NgayLap datetime not null,
	ThanhTien float(53) not null,
	Primary Key Clustered ([MaHoaDon] ASC),
	Foreign Key(MaNhanVien) References NhanVien(MaNhanVien)
);
go


--Tạo bảng Thiết bị
Create Table ThietBi
(
	MaThietBi nvarchar(10) not null,
	TenThietBi nvarchar(50) not null,
	SL int not null,
	TinhTrang bit default 0,
	SoPhong nvarchar(10) not null,
	Primary Key Clustered ([MaThietBi] ASC),
	Foreign Key(SoPhong) References Phong(SoPhong)
);
go

--Tạo bảng Phiếu thiệt hại
Create Table PhieuThietHai
(
	MaPhieu nvarchar(10) not null,
	NgayLap datetime not null,
	TinhTrang bit default 0,
	MaThietBi nvarchar(10) not null,
	Primary Key Clustered ([MaPhieu] ASC),
	Foreign Key(MaThietBi) References ThietBi(MaThietBi)
);
go

--Tạo bảng Phiếu thiệt hại
Create Table CTPhieuThietHai
(
	MaPhieu nvarchar(10) not null,
	SoPhong nvarchar(10) not null,
	MoTa text not null,
	Primary Key Clustered ([MaPhieu] ASC, SoPhong ASC),
);
go

--Định dạng thời gian: date/month/year
set dateformat dmy

--Nhập liệu

--Bảng Bộ Phận
insert into BoPhan values(N'TN', N'Thu Ngân')
insert into BoPhan values(N'TC', N'Tài Chính')
insert into BoPhan values(N'AN', N'An Ninh')
insert into BoPhan values(N'NS', N'Nhân Sự')
select *from BoPhan

--Bảng Chức Vụ
insert into ChucVu values(N'TB', N'Trưởng Ban',N'NS')
insert into ChucVu values(N'KT', N'Kế Toán',N'TC')
insert into ChucVu values(N'BV', N'Bảo Vệ',N'AN')
insert into ChucVu values(N'TN', N'Thu Ngân',N'TC')
select *from ChucVu

--Bảng Nhân Viên
insert into NhanVien values('NV01',N'Nguyễn Thị Như','0123456789','10-10-1999','nhu@gmail.com',0,'KT')
insert into NhanVien values('NV02',N'Nguyễn Thị Linh','012345566','15-10-1998','linh@gmail.com',0,'KT')
insert into NhanVien values('NV03',N'Nguyễn Văn Nam','0123456789','21-04-2000','nam@gmail.com',1,'BV')
insert into NhanVien values('NV04',N'Nguyễn Văn Tùng','0123456789','10-06-1997','tung@gmail.com',1,'BV')
insert into NhanVien values('NV05',N'Nguyễn Minh Thư','0123456789','10-10-2001','thu@gmail.com',0,'TN')
insert into NhanVien values('NV06',N'Nguyễn Minh Anh','0123456789','10-10-2001','anh@gmail.com',0,'TN')
select *from NhanVien

--Bảng Khu
insert into Khu values(N'KhuA', N'Khu A01', 5,50)
insert into Khu values(N'KhuB', N'Khu B02', 6,60)
insert into Khu values(N'KhuC', N'Khu C01', 2,20)
insert into Khu values(N'KhuD', N'Khu D03', 4,30)
insert into Khu values(N'KhuE', N'Khu E01', 5,20)
select *from Khu

--Bảng Loại Phòng
insert into  LoaiPhong values('Vip01',1500000,6,0)
insert into  LoaiPhong values('Thuong01',1000000,4,0)
insert into  LoaiPhong values('Thuong02',1000000,4,0)
insert into  LoaiPhong values('Thuong03',1000000,4,0)
insert into  LoaiPhong values('Vip02',1500000,6,0)
select *from LoaiPhong

--Bảng Phòng
insert into Phong Values('A101',5,6,1500000,0,'Vip01','KhuA')
insert into Phong Values('A102',5,6,1500000,0,'Vip02','KhuA')
insert into Phong Values('B101',3,4,300000,0,'Thuong01','KhuB')
insert into Phong Values('B102',2,6,300000,0,'Vip01','KhuB')
insert into Phong Values('E101',5,6,500000,0,'Vip01','KhuE')
insert into Phong Values('D101',5,6,800000,0,'Thuong02','KhuD')
insert into Phong Values('C101',5,6,100000,0,'Thuong03','KhuC')
select *from Phong

--Bảng Dịch Vụ
insert into DichVu values('DV01',N'Tiền điện',50000,'A101')
insert into DichVu values('DV02',N'Tiền Nước',150000,'A101')

--Bảng Hóa đơn
insert into HoaDon values('HD01','NV05','10-12-2021',1500000)
insert into HoaDon values('HD02','NV05','10-12-2021',1200000)
insert into HoaDon values('HD03','NV05','10-12-2021',1300000)
insert into HoaDon values('HD04','NV06','12-12-2021',1800000)
insert into HoaDon values('HD05','NV06','12-12-2021',1500000)
insert into HoaDon values('HD06','NV06','12-12-2021',1000000)
select *from HoaDon

--Bảng chi tiết Dịch vụ
insert into CTDichVu values('DV01','HD01',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV02','HD01',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV01','HD02',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV02','HD02',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV01','HD03',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV01','HD04',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV02','HD05',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV01','HD06',3500,10000,100,150,100,130,500,1000)
insert into CTDichVu values('DV02','HD06',3500,10000,100,150,100,130,500,1000)
select *from CTDichVu

--Bảng thiết bị
insert into ThietBi values ('TB01',N'Quạt',3,0,'A101')
insert into ThietBi values ('TB02',N'Đèn',4,0,'A101')
insert into ThietBi values ('TB03',N'Quạt',3,0,'A102')
insert into ThietBi values ('TB04',N'Quạt',3,0,'A102')
insert into ThietBi values ('TB05',N'Tủ Lạnh',3,0,'B101')
select *from ThietBi

--Bảng Phiếu thiệt hại
insert into PhieuThietHai values ('PTH01','12-10-2022',0,'TB01')
insert into PhieuThietHai values ('PTH02','12-11-2022',0,'TB02')
insert into PhieuThietHai values ('PTH03','12-20-2022',0,'TB03')
select *from PhieuThietHai

--Bảng chi tiết phiếu thiệt hại
insert into CTPhieuThietHai values ('PTH03','B101',N'Hư bảng mạch điện')
insert into CTPhieuThietHai values ('PTH01','A101',N'Hư bảng mạch điện')
insert into CTPhieuThietHai values ('PTH02','C101',N'Hư bảng mạch điện')
insert into CTPhieuThietHai values ('PTH01','B102',N'Hư bảng mạch điện')
select *from CTPhieuThietHai

--Bảng sinh viên

insert into SinhVien values ('SV01',N'Nguyễn Văn Mạnh','0011223344','03-03-2001','manh@gmail.com','098761325',1,'A101')
insert into SinhVien values ('SV02',N'Nguyễn Văn Hoàng','0011223344','03-04-2000','hoang@gmail.com','098761325',1,'A101')
insert into SinhVien values ('SV03',N'Nguyễn Thị Lan','0011223344','03-03-1999','lan@gmail.com','098761325',0,'A102')
insert into SinhVien values ('SV04',N'Nguyễn Thị Dịu','0011223344','03-03-2004','diu@gmail.com','098761325',0,'B101')
insert into SinhVien values ('SV05',N'Nguyễn Đinh Nam','0011223344','03-03-2001','nam@gmail.com','098761325',1,'C101')
insert into SinhVien values ('SV06',N'Nguyễn Văn Lực','0011223344','03-03-2000','luc@gmail.com','098761325',1,'D101')
select *from SinhVien

--Bảng Hợp đồng
insert into HopDong values ('HD01',N'NV05','SV01',N'Hợp đồng ở KTX','03-03-2019','03-03-2020',50000,0,'chu co')
insert into HopDong values ('HD02',N'NV05','SV02',N'Hợp đồng ở KTX','10-03-2018','10-03-2019',50000,0,'chu co')
insert into HopDong values ('HD03',N'NV05','SV03',N'Hợp đồng ở KTX','03-03-2019','03-03-2020',50000,0,'chu co')
insert into HopDong values ('HD04',N'NV06','SV04',N'Hợp đồng ở KTX','03-03-2019','03-03-2020',50000,0,'chu co')
insert into HopDong values ('HD05',N'NV06','SV05',N'Hợp đồng ở KTX','03-03-2019','03-03-2020',50000,0,'chu co')
insert into HopDong values ('HD06',N'NV06','SV06',N'Hợp đồng ở KTX','03-03-2020','03-03-2021',50000,0,'chu co')
select *from HopDong


--Các câu truy vấn


select *from HopDong
select *from sinhvien


--Câu 1: Đếm số lượng hợp đồng được tạo mới trong tháng 03-2019
select count(NgayLap) as N'Số Lượng Hợp Đồng' from HopDong where NgayLap between '2019/03/01' AND '2019/03/31';


--Câu 2: Tính tổng số tiền dịch mà phòng phải trả:(SoPhong,TongTienDien,TongTienNuoc,TongTienDichVu) 
-- Tiền Điện = (ChiSoMoi-ChiSoCu)*DonGiaDien -ThueDien
-- Thuế Điện = Đơn Giá * 10%
-- Tiền Nước = (ChiSoMoi-ChiSoCu)*DonGiaDien -ThueNuoc
-- Thuế Nước = Đơn Giá * 10%
-- Tổng tiền dịch vụ = Tiền điện + Tiền nước
select dv.SoPhong,
N'Tiền Nước' = (ctdv.ChiSoMoiNuoc - ctdv.ChiSoCuNuoc)*ctdv.DonGiaNuoc - ctdv.DonGiaNuoc * 0.1,
N'Tiền Điện' =(ctdv.ChiSoMoiDien - ctdv.ChiSoCuDien)*ctdv.DonGiaDien - ctdv.DonGiaDien * 0.1,
N'Tổng tiền dịch vụ' = ((ctdv.ChiSoMoiNuoc - ctdv.ChiSoCuNuoc)*ctdv.DonGiaNuoc - ctdv.DonGiaNuoc * 0.1 ) + ((ctdv.ChiSoMoiDien - ctdv.ChiSoCuDien)*ctdv.DonGiaDien - ctdv.DonGiaDien * 0.1)
from CTDichVu as ctdv,  DichVu as dv,hoadon hd
where dv.MaDichVu = ctdv.MaDichVu and hd.MaHoaDon = ctdv.MaHoaDon

--Câu 3: Thống kế ra danh sách các sinh viên đăng ký vào ở KTX trong tháng 03-2019
select sv.MaSinhVien N'Mã sinh viên', sv.TenSinhVien N'Tên Sinh Viên', sv.DienThoai N'Điện Thoại', sv.CanCuoc N'Căn Cước',
sv.Email, sv.GioiTinh N'Giới Tính', sv.NgaySinh 'Ngày Sinh', sv.SoPhong 'Số Phòng'
from HopDong as hd, SinhVien as sv 
where NgayLap between '2019/03/01' AND '2019/03/31' and sv.MaSinhVien = hd.MaSinhVien;



--Câu 4 Thống kê danh sách các thiết bị, bị hư hỏng ở các phòng
select tp.TenThietBi N'Tên thiết bị', pth.TinhTrang 'Tình Trạng', pth.NgayLap N'Ngày lập phiếu', tp.SoPhong N'Số phòng'
from PhieuThietHai as pth, ThietBi tp
where pth.MaThietBi = tp.MaThietBi and tp.TinhTrang = 1