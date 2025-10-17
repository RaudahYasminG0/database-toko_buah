create database toko_buah;
use toko_buah;

create table produk(
idProduk int not null primary key,
namaProduk varchar (40) not null,
kuantitas_stok int not null,
harga_unit int not null
);

create table shipper(
idShipper smallint(6) not null primary key,
namaShipper varchar(30) not null
);

create table pelanggan(
idPelanggan int not null primary key,
nama_depan varchar (50) not null,
nama_belakang varchar(60) not null,
no_telp varchar(13) not null,
alamat text not null,
kota varchar (30) not null,
poin int not null
);

create table status_pesanan(
idPesanan_status smallint(4) not null primary key,
status varchar (20) not null
);

create table pesanan(
idPesanan int not null primary key,
idPelanggan int not null,
tgl_pesan date not null,
status smallint(4) not null,
catatan text default null,
tgl_shipped date default null,
idShipper smallint(6) not null,
constraint fk_pelanggan foreign key (idPelanggan) references pelanggan (idPelanggan),
constraint fk_status foreign key (status) references status_pesanan (idPesanan_status),
constraint fk_shipper foreign key (idShipper) references shipper (idShipper)
);

create table item_pesanan(
idPesanan int not null,
idProduk int not null,
kuantitas int not null,
harga_unit int not null,
primary key (idPesanan, idProduk),
constraint fk_pesanan foreign key (idPesanan) references pesanan (idPesanan),
constraint fk_produk foreign key (idProduk) references produk (idProduk)
);

-- Mengubah tipe data untuk idShipper dan idProduk (karena terjalin dengan foreign key maka drop foreign key dulu)
alter table pesanan drop foreign key fk_shipper;
alter table item_pesanan drop foreign key fk_produk;

alter table produk modify idProduk varchar(5);
alter table shipper modify idShipper varchar(5);
alter table pesanan modify idShipper varchar(5);
alter table item_pesanan modify idProduk varchar(5);

alter table pesanan add constraint fk_shipper foreign key (idShipper) references shipper (idShipper);
alter table item_pesanan add constraint fk_produk foreign key (idProduk) references produk (idProduk);

-- Menambahkan kolom satuan setelah kolom kuantitas_stok
alter table produk add satuan varchar (20) after kuantitas_stok;

-- Mengubah tipe data
alter table pelanggan modify poin int not null default 0;

insert into produk values
("AH001", "Apel Hijau", 30 ,"kg",42500),
("JM002","Jeruk Mandarin",25,"kg",33700),
("JP003","Jeruk Peras",40,"kg",14500),
("SM004","Semangka Merah",24,"buah (4 kg)",39500),
("SK005","Semangka Kuning", 20, "buah (4 kg)",37800),
("N006","Nanas", 21, "buah", 10000),
("M007","Melon", 27, "buah (2,5 kg)", 28500),
("AH008","Anggur Hijau",18, "pak (550 gr)", 28700),
("AM009","Anggur Merah", 18, "pak (550 gr)",28000),
("JB010","Jambu Biji", 27, "kg", 13300),
("A011","Alpukat", 30, "kg",39000),
("AF012","Apel Fuji",20,"kg",54600),
("L013","Lemon",17,"kg",31500),
("MA014","Mangga Arumanis", 32, "kg", 27800),
("MM015","Mangga Manalagi", 42, "kg", 19500);

insert into shipper values
("JE-01","JNE"),
("JT-02","J&T"),
("AJ-03","Anteraja"),
("W-04","Wahana Prestasi Logistik"),
("SC-05","SiCepat");

insert into pelanggan values
(10001, "Erna", "Wati","08900325800","Jalan Diponegoro", "Surabaya", 3400),
(10002,"Hari", "Pranowo", "087653492974","Jalan Cerme", "Gresik",0),
(10003,"Ceilin","Hartono", "08130918491", "Jalan Prambon", "Gresik",200),
(10004,"Muhammad","Alwi","08349289489","Jalan Wonocolo","Surabaya",50),
(10005,"Arni","Wicaksono","0848913724009","Jalan Made","Surabaya",4),
(10006,"Riska","Aprilia","086919353092","Jalan Driyorejo","Gresik",5000),
(10007,"Mina","Widianti","085872947912","Jalan Wadung Asri","Sidoarjo",745),
(10008,"Mikael","Tanjung","085867930291","Jalan Lidah Wetan","Surabaya",1270),
(10009,"Windah","Basudara","08111937293","Jalan Bunderan","Sidoarjo",1083),
(10010,"Halim","Kusuma Wijianto", "089878418942","Jalan Wadung Asri","Sidoarjo",0),
(10011,"Wira","Perdana Halim","08978931132","Jalan Wahidin","Gresik",3021);

insert into status_pesanan values
(1, "Diproses"),
(2,"Dikirim"),
(3,"Diterima");

insert into pesanan values
(20001,10001,"2025-10-10",1,null,'2025-10-10',"JE-01"),
(20002,10002,"2025-10-09",2,null,'2025-10-11',"SC-05"),
(20003,10003,"2025-10-11",1,null,null,"AJ-03"),
(20004,10004,"2025-10-12",3,"Semangka dan melon dipacking jadi satu","2025-10-12","W-04"),
(20005,10005,"2025-10-13",1,null,null,"JT-02"),
(20006,10006,"2025-10-15",2,null,"2025-10-16","SC-05"),
(20007,10007,"2025-10-14",1,null,"2025-10-17","SC-05"),
(20008,10008,"2025-10-09",2,"Paket titipkan sebelah rumah","2025-10-10","AJ-03"),
(20009,10009,"2025-10-08",3,null,"2025-10-08","JE-01"),
(20010,10010,"2025-10-09",1,null,"2025-10-09","JT-02"),
(20011,10011,"2025-10-15",2,null,"2025-10-16","W-04");

insert into item_pesanan values
(20001,"AH001",5,42500),
(20002,"AM009",6,28000),
(20003,"AF012",4,54600),
(20004,"N006",7,10000),
(20005,"MM015",9,19500),
(20006,"MA014",3,27800),
(20007,"AM009",9,28000),
(20008,"AM009",5,28000),
(20009,"JB010",2,13300),
(20010,"A011",3,39000),
(20011,"L013",5,31500);

-- Menambahkan data pelanggan, pesanan, dan item_pesanan
insert into pelanggan values
(10012,"Helena","Wirawan","08652719203","Jalan Pucang Anom","Surabaya",0),
(10013,"Alex","Thamrin Salam","0892939181327","Jalan Buduran","Sidoarjo",883),
(10014,"Asyifa","Ramlan Hamdani","0866913913975","Jalan Boboh","Gresik",678);

insert into pesanan values
(20012,10003,"2025-10-12",1,null,null,"W-04"),
(20013,10012,"2025-10-15",1,null,null,"JE-01"),
(20014,10013,"2025-10-15",2,null,"2025-10-16","AJ-03"),
(20015,10014,"2025-10-14",3,null,"2025-10-16","SC-05");

insert into item_pesanan values
(20012,"A011",5,39000),
(20013,"L013",2,31500),
(20014,"AH008",4,28700),
(20015,"JM002",7,33700);

-- Mengubah input kuantitas pada idproduk JB010
update item_pesanan set kuantitas=5 where idProduk="JB010";

-- Menampilkan nama pelanggan yang memesan barang yang sama
select pelanggan.nama_depan, pelanggan.nama_belakang, produk.idProduk, produk.namaProduk from pesanan
join pelanggan on pelanggan.idPelanggan=pesanan.idPelanggan
join item_pesanan on item_pesanan.idPesanan=pesanan.idPesanan
join produk on produk.idProduk=item_pesanan.idProduk
where produk.idProduk in 
(select item_pesanan.idProduk from item_pesanan group by item_pesanan.idProduk having count(item_pesanan.idProduk) > 1);

-- Menambahkan kolom total harga pada item_pesanan di mana total harga adalah kuantitas dikali harga per unit
alter table item_pesanan add total_harga int not null default 0;

update item_pesanan set total_harga=kuantitas * harga_unit;

-- Menampilkan semua nama produk dengan jumlahan barang yang terjual dan jumlahan total penjualan tiap produk
select produk.namaProduk, sum(item_pesanan.kuantitas) as `banyak barang terjual`, sum(item_pesanan.total_harga) as `total penjualan (rp)`
from produk left join item_pesanan on produk.idProduk=item_pesanan.idProduk group by produk.idProduk;

-- Menampilkan nama produk dengan jumlahan barang yang terjual dan jumlahan total penjualan tiap produk yang terjual
select produk.namaProduk, sum(item_pesanan.kuantitas) as `banyak barang terjual`, sum(item_pesanan.total_harga) as `total penjualan (rp)`
from item_pesanan join produk on produk.idProduk=item_pesanan.idProduk group by item_pesanan.idProduk;  -- join ini defaultnya inner join
-- from item_pesanan inner join produk on produk.idProduk=item_pesanan.idProduk group by produk.idProduk;
-- from produk inner join item_pesanan on produk.idProduk=item_pesanan.idProduk group by item_pesanan.idProduk;  -- inner untuk menampilkan baris yang memiliki nilai yang cocok di kedua tabel
-- from item_pesanan left join produk on produk.idProduk=item_pesanan.idProduk group by produk.idProduk;  -- query ini dapat menghasilkan output yang benar namun kurang tepat krn penggunaan left untuk menampilkan semua baris baik yang ada pasangan maupun tidak 

-- Menampilkan produk yang belum terjual (tidak ada di item_pesanan)
select produk.namaProduk, sum(item_pesanan.kuantitas) as `banyak barang terjual`, sum(item_pesanan.total_harga) as `total penjualan (rp)`
from produk left join item_pesanan on produk.idProduk=item_pesanan.idProduk
where item_pesanan.idProduk is null group by produk.idProduk;

-- Menampilkan urutan paling banyak digunakan tiap jasa shipper
select shipper.namaShipper, count(pesanan.idShipper) as `jumlah pengguna` from pesanan 
join shipper on shipper.idShipper=pesanan.idShipper
group by pesanan.idShipper order by `jumlah pengguna` desc;

-- select shipper.namaShipper, count(pesanan.idShipper) as `jumlah pengguna` from shipper -- (query ini juga bisa menampilkan urutan paling banyak digunakan tiap jasa shipper)
-- join pesanan on shipper.idShipper=pesanan.idShipper
-- group by shipper.idShipper order by `jumlah pengguna` desc;

-- Menambahkan kolom label status stok
select 
produk.idProduk,
produk.namaProduk,
produk.kuantitas_stok,
coalesce(sum(item_pesanan.kuantitas), 0) as total_dipesan, -- sum(item_pesanan.kuantitas) = produk yang belum terjual akan tertulis null
case 
	when coalesce(sum(item_pesanan.kuantitas), 0) > produk.kuantitas_stok then 'Melebihi Stok' -- sum(item_pesanan.kuantitas) = produk yang belum terjual akan tertulis null
	else 'Aman'
end as status_stok
from produk
left join item_pesanan on produk.idProduk = item_pesanan.idProduk
group by produk.idProduk, produk.namaProduk, produk.kuantitas_stok;
