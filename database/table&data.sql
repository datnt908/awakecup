-- use awakecup database
USE `awakecup`;

--
-- Create tables
-- 

-- administrative_division table
DROP TABLE IF EXISTS `administrative_division`;
CREATE TABLE `administrative_division` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `FatherID` INT,
    `Name` VARCHAR(32) NOT NULL,
    `Type` VARCHAR(32) NOT NULL,
    `Level` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`ID`)
);

-- category table
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `CategoryTitle` VARCHAR(32) NOT NULL UNIQUE,
    PRIMARY KEY (`ID`)
);

-- order_status table
DROP TABLE IF EXISTS `order_status`;
CREATE TABLE `order_status` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Status` VARCHAR(32) NOT NULL UNIQUE,
    PRIMARY KEY (`ID`)
);

-- account table
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Username` VARCHAR(32) NOT NULL UNIQUE,
    `Password` BINARY(20) NOT NULL,
    PRIMARY KEY (`ID`)
);

-- product table
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Code` VARCHAR(8) NOT NULL,
    `ProductTitle` VARCHAR(32) NOT NULL,
    `Description` VARCHAR(1024) NOT NULL DEFAULT 'No Description',
    `CategoryID` INT NOT NULL,
    `Price` INT NOT NULL,
    `ImageURL` VARCHAR(256) NOT NULL DEFAULT 'default.png',
    `RecordStatus` TINYINT NOT NULL DEFAULT 1,
    PRIMARY KEY (`ID`)
);

-- order table
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
    `ID` INT NOT NULL AUTO_INCREMENT,
    `Firstname` VARCHAR(32) NOT NULL,
    `Lastname` VARCHAR(32) NOT NULL,
    `StatusID` INT NOT NULL,
    `Phone` VARCHAR(16) NOT NULL,
    `ProvinceID` INT NOT NULL,
    `DistrictID` INT NOT NULL,
    `CommuneID` INT NOT NULL,
    `Address` VARCHAR(256) NOT NULL,
    `Note` VARCHAR(256),
    PRIMARY KEY (`ID`)
);

-- cart table
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
    `OrderID` INT NOT NULL,
    `Subtotal` INT NOT NULL,
    `Delivery` INT NOT NULL,
    `Discount` INT NOT NULL,
    `Total` INT NOT NULL,
    PRIMARY KEY (`OrderID`)
);

-- cart_detail table
DROP TABLE IF EXISTS `cart_detail`;
CREATE TABLE `cart_detail` (
    `OrderID` INT NOT NULL,
    `ProductID` INT NOT NULL,
    `Price` INT NOT NULL,
    `Quantity` INT NOT NULL,
    `Total` INT NOT NULL,
    PRIMARY KEY (`OrderID`, `ProductID`)
);

--
-- Insert Data
--
INSERT INTO `account` (`Username`, `Password`) VALUES ('admin', UNHEX(SHA1('admin')));

INSERT INTO `category` (`CategoryTitle`) VALUES ('Cà phê');
INSERT INTO `category` (`CategoryTitle`) VALUES ('Trà trái cây');
INSERT INTO `category` (`CategoryTitle`) VALUES ('Trà sữa');
INSERT INTO `category` (`CategoryTitle`) VALUES ('Thức uống đá xay');
INSERT INTO `category` (`CategoryTitle`) VALUES ('Bánh và Snack');

INSERT INTO `order_status` (`Status`) VALUES ('Đang xử lý');
INSERT INTO `order_status` (`Status`) VALUES ('Đang chuẩn bị');
INSERT INTO `order_status` (`Status`) VALUES ('Đang giao hàng');
INSERT INTO `order_status` (`Status`) VALUES ('Đã giao hàng');

INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00001', 'AMERICANO', 'Americano được pha chế bằng cách thêm nước vào một hoặc hai shot Espresso để pha loãng độ đặc của cà phê, từ đó mang lại hương vị nhẹ nhàng, không gắt mạnh và vẫn thơm nồng nàn.', 1, 39000, 'appdata/products/PRO00001_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00002', 'BẠC SỈU', 'Theo chân những người gốc Hoa đến định cư tại Sài Gòn, Bạc sỉu là cách gọi tắt của "Bạc tẩy sỉu phé" trong tiếng Quảng Đông, chính là: Ly sữa trắng kèm một chút cà phê.',1,29000, 'appdata/products/PRO00002_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00003', 'CAPPUCINNO', 'Cappuccino được gọi vui là thức uống "một-phần-ba" - 1/3 Espresso, 1/3 Sữa nóng, 1/3 Foam.',1,45000, 'appdata/products/PRO00003_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00004', 'LATTE', 'Khi chuẩn bị Latte, cà phê Espresso và sữa nóng được trộn lẫn vào nhau, bên trên vẫn là lớp foam nhưng mỏng và nhẹ hơn Cappucinno.',1,45000, 'appdata/products/PRO00004_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00005', 'MOCHA', 'Cà phê Mocha được ví von đơn giản là Sốt Sô cô la được pha cùng một tách Espresso.',1,49000, 'appdata/products/PRO00005_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00006', 'TRÀ OOLONG VẢI NHƯ Ý', 'Là thức uống "bắt vị" được lấy cảm hứng từ trái Vải - thức quả tròn đầy, quen thuộc trong cuộc sống người Việt - kết hợp cùng Trà Oolong làm từ những lá trà tươi hảo hạng.',2,45000, 'appdata/products/PRO00006_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00007', 'TRÀ ĐÀO CAM SẢ', 'Vị thanh ngọt của đào Hy Lạp, vị chua dịu của Cam Vàng nguyên vỏ, vị chát của trà đen tươi được ủ mới mỗi 4 tiếng, cùng hương thơm nồng đặc trưng của sả chính là điểm sáng làm nên sức hấp dẫn của thức uống này. Sản phẩm hiện có 2 phiên bản Nóng và Lạnh phù hợp cho mọi thời gian trong năm.',2,45000, 'appdata/products/PRO00007_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00008', 'TRÀ PHÚC BỒN TỬ', 'Một sự kết hợp đầy hoàn hảo giữa thanh mát và bổ dưỡng.Lần đầu tiên Trà Oolong và trái "Phúc Bồn Tử" hoàn toàn tự nhiên, được các barista của chúng tôi kết hợp một cách tinh tế để tạo ra một dư vị hoàn toàn tươi mới.Nhấp ngay một ngụm là thấy mát lạnh ngay tức khắc, đọng lại mãi nơi cuốn họng là hương vị trà thơm lừng và vị ngọt thanh, chua dịu khó quên của trái phúc bồn tử.',2,49000, 'appdata/products/PRO00008_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00009', 'TRÀ THƠM 1 CÁI', 'Sự kết hợp sáng tạo của trà thơm (dứa) ngọt dịu, với topping đào dầm vừa quen vừa lạ - cho hương vị giải nhiệt và cực kì vui miệng, giúp cuộc hẹn hò của bạn thêm mát, thêm rôm rả hơn.',2,49000, 'appdata/products/PRO00009_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00010', 'TRÀ MATCHA MACCHIATO', 'Bột trà xanh Matcha thơm lừng hảo hạng cùng lớp Macchiato béo ngậy là một sự kết hợp tuyệt vời. Nếu bạn yêu thích Matcha Latte, không lý nào lại không thử Matcha Macchiato của chúng tôi.',3,45000, 'appdata/products/PRO00010_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00011', 'TRÀ CHERRY MACCHIATO', 'Khoác lên mình một ngoại hình tràn đầy năng lượng với sắc đỏ rực rỡ của Cherry chín mọng, kết hợp với nền trà oolong hảo hạng và lớp foam sánh mịn, để mang đến cho bạn một thức uống khoan khoái và dậy lên từng phong vị chua, béo, ngọt đầy ấn tượng.',3,55000, 'appdata/products/PRO00011_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00012', 'TRÀ SỮA MẮC CA TRÂN CHÂU TRẮNG', 'Mỗi ngày với Nhà sẽ là điều tươi mới hơn với sữa hạt mắc ca thơm ngon, bổ dưỡng quyện cùng nền trà Oolong cho vị cân bằng, ngọt dịu. Trân châu trắng giòn dai được thêm sẵn, mang lại cho bạn cảm giác "đã" trong từng ngụm, thoả cơn thèm trà sữa ngay.',3,45000, 'appdata/products/PRO00012_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00013', 'CHOCOLATE ĐÁ XAY', 'Vị đắng của cà phê kết hợp cùng vị cacao ngọt ngàocủa sô-cô-la, vị sữa tươi ngọt béo, đem đến trải nghiệm vị giác cực kỳ thú vị.',4,59000, 'appdata/products/PRO00013_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00014', 'COOKIES ĐÁ XAY', 'Những mẩu bánh cookies giòn rụm kết hợp ăn ý với sữa tươi và kem tươi béo ngọt, đem đến cảm giác lạ miệng gây thích thú. Một món uống phá cách dễ thương.',4,59000, 'appdata/products/PRO00014_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00015', 'PHÚC BỒN TỬ CAM ĐÁ XAY', 'Tê tái ngay đầu lưỡi bởi sự mát lạnh của đá xay. Hòa quyện thêm hương vị chua chua, ngọt ngọt từ trái cam tươi và trái phúc bồn tử 100% tự nhiên, để cho ra một hương vị thanh mát, kích thích vị giác đầy thú vị ngay từ lần đầu thưởng thức.',4,59000, 'appdata/products/PRO00015_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00016', 'MATCHA ĐÁ XAY', 'Matcha thanh, nhẫn, và đắng nhẹ được nhân đôi sảng khoái khi uống lạnh. Nhấn nhá thêm những nét bùi béo của kem và sữa. Gây thương nhớ vô cùng!',4,59000, 'appdata/products/PRO00016_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00017', 'BÁNH BÔNG LAN TRỨNG MUỐI', 'Chắc chắn bạn sẽ không thể cưỡng lại chiếc bánh bông lan tơi xốp, mềm mịn, vị ngọt dịu kết hợp với trứng muối và chà bông đậm đà, cân bằng vị giác.',5,29000, 'appdata/products/PRO00017_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00018', 'BÁNH CHOCOLATE', 'Từng lớp bánh mịn ngọt ngào đậm vị chiều lòng người yêu thích hương vị sô cô la. Sẽ ngon hơn nếu bạn kết hợp cùng món trà trái cây thanh mát.',5,29000, 'appdata/products/PRO00018_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00019', 'BÁNH CROISSANT BƠ TỎI', 'Thưởng thức ngay chiếc bánh Croissant bơ tỏi thơm lừng, bên ngoài vỏ bánh giòn hấp dẫn bên trong mềm dai vị ngon khó cưỡng.',5,29000, 'appdata/products/PRO00019_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00020', 'BÁNH MÌ CHÀ BÔNG PHÔ MAI', 'Bạn không thể bỏ lỡ chiếc bánh với lớp phô mai vàng sánh mịn bên trong, được bọc ngoài lớp vỏ xốp mềm thơm lừng. Thêm lớp chà bông mằn mặn hấp dẫn bên trên.',5,32000, 'appdata/products/PRO00020_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00021', 'BÁNH MATCHA', 'Khám phá từng tầng vị trà xanh thơm lừng xen kẽ lớp kéo béo dịu với đậu đỏ.',5,29000, 'appdata/products/PRO00021_1.png');
INSERT INTO `product` (`Code`, `ProductTitle`, `Description`, `CategoryID`, `Price`, `ImageURL`) VALUES ('PRO00022', 'BÁNH GẤU CHOCOLATE', 'Với vẻ ngoài đáng yêu và hương vị ngọt ngào, thơm béo nhất định bạn phải thử ít nhất 1 lần.',5,39000, 'appdata/products/PRO00022_1.png');

INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (1, NULL, 'Thành phố Hồ Chí Minh', 'Thành phố Trung ương', 'Tỉnh/Thành');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (2, 1, 'Quận Thủ Đức', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (3, 1, 'Quận Tân Phú', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (4, 1, 'Quận Tân Bình', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (5, 1, 'Quận Phú Nhuận', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (6, 1, 'Quận Gò Vấp', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (7, 1, 'Quận Bình Thạnh', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (8, 1, 'Quận Bình Tân', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (9, 1, 'Quận 9', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (10, 1, 'Quận 8', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (11, 1, 'Quận 7', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (12, 1, 'Quận 6', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (13, 1, 'Quận 5', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (14, 1, 'Quận 4', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (15, 1, 'Quận 3', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (16, 1, 'Quận 2', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (17, 1, 'Quận 12', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (18, 1, 'Quận 11', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (19, 1, 'Quận 10', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (20, 1, 'Quận 1', 'Quận', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (21, 1, 'Huyện Nhà Bè', 'Huyện', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (22, 1, 'Huyện Hóc Môn', 'Huyện', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (23, 1, 'Huyện Củ Chi', 'Huyện', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (24, 1, 'Huyện Cần Giờ', 'Huyện', 'Quận/Huyện');
INSERT INTO `administrative_division` (`ID`, `FatherID`, `Name`, `Type`, `Level`) VALUES (25, 1, 'Huyện Bình Chánh', 'Huyện', 'Quận/Huyện');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Tân Định', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Đa Kao', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Bến Nghé', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Bến Thành', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Nguyễn Thái Bình', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Phạm Ngũ Lão', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Cầu Ông Lãnh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Cô Giang', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Nguyễn Cư Trinh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (20, 'Phường Cầu Kho', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Thạnh Xuân', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Thạnh Lộc', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Hiệp Thành', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Thới An', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Tân Chánh Hiệp', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường An Phú Đông', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Tân Thới Hiệp', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Trung Mỹ Tây', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Tân Hưng Thuận', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Đông Hưng Thuận', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (17, 'Phường Tân Thới Nhất', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Linh Xuân', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Bình Chiểu', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Linh Trung', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Tam Bình', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Tam Phú', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Hiệp Bình Phước', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Hiệp Bình Chánh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Linh Chiểu', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Linh Tây', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Linh Đông', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Bình Thọ', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (2, 'Phường Trường Thọ', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Long Bình', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Long Thạnh Mỹ', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Tân Phú', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Hiệp Phú', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Tăng Nhơn Phú A', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Tăng Nhơn Phú B', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Phước Long B', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Phước Long A', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Trường Thạnh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Long Phước', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Long Trường', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Phước Bình', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (9, 'Phường Phú Hữu', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 17', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 6', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 16', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 9', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 8', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (6, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 27', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 26', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 25', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 24', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 17', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 21', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 22', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 19', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (7, 'Phường 28', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (4, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Tân Sơn Nhì', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Tây Thạnh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Sơn Kỳ', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Tân Quý', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Tân Thành', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Phú Thọ Hòa', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Phú Thạnh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Phú Trung', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Hòa Thạnh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Hiệp Tân', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (3, 'Phường Tân Thới Hòa', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 17', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (5, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Thảo Điền', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường An Phú', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Bình An', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Bình Trưng Đông', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Bình Trưng Tây', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Bình Khánh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường An Khánh', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Cát Lái', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Thạnh Mỹ Lợi', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường An Lợi Đông', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (16, 'Phường Thủ Thiêm', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (15, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (19, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (18, 'Phường 16', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 18', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 16', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (14, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (13, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (12, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 08', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 02', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 01', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 03', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 11', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 09', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 10', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 04', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 13', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 12', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 05', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 14', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 06', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 15', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 16', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (10, 'Phường 07', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Bình Hưng Hòa', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Bình Hưng Hoà A', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Bình Hưng Hoà B', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Bình Trị Đông', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Bình Trị Đông A', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Bình Trị Đông B', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Tân Tạo', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường Tân Tạo A', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường  An Lạc', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (8, 'Phường An Lạc A', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Tân Thuận Đông', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Tân Thuận Tây', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Tân Kiểng', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Tân Hưng', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Bình Thuận', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Tân Quy', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Phú Thuận', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Tân Phú', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Tân Phong', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (11, 'Phường Phú Mỹ', 'Phường', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Thị trấn Củ Chi', 'Thị trấn', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Phú Mỹ Hưng', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã An Phú', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Trung Lập Thượng', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã An Nhơn Tây', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Nhuận Đức', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Phạm Văn Cội', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Phú Hòa Đông', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Trung Lập Hạ', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Trung An', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Phước Thạnh', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Phước Hiệp', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Tân An Hội', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Phước Vĩnh An', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Thái Mỹ', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Tân Thạnh Tây', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Hòa Phú', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Tân Thạnh Đông', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Bình Mỹ', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Tân Phú Trung', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (23, 'Xã Tân Thông Hội', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Thị trấn Hóc Môn', 'Thị trấn', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Tân Hiệp', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Nhị Bình', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Đông Thạnh', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Tân Thới Nhì', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Thới Tam Thôn', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Xuân Thới Sơn', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Tân Xuân', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Xuân Thới Đông', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Trung Chánh', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Xuân Thới Thượng', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (22, 'Xã Bà Điểm', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Thị trấn Tân Túc', 'Thị trấn', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Phạm Văn Hai', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Vĩnh Lộc A', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Vĩnh Lộc B', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Bình Lợi', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Lê Minh Xuân', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Tân Nhựt', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Tân Kiên', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Bình Hưng', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Phong Phú', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã An Phú Tây', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Hưng Long', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Đa Phước', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Tân Quý Tây', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Bình Chánh', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (25, 'Xã Quy Đức', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (21, 'Thị trấn Nhà Bè', 'Thị trấn', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (21, 'Xã Phước Kiển', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (21, 'Xã Phước Lộc', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (21, 'Xã Nhơn Đức', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (21, 'Xã Phú Xuân', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (21, 'Xã Long Thới', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (21, 'Xã Hiệp Phước', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (24, 'Thị trấn Cần Thạnh', 'Thị trấn', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (24, 'Xã Bình Khánh', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (24, 'Xã Tam Thôn Hiệp', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (24, 'Xã An Thới Đông', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (24, 'Xã Thạnh An', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (24, 'Xã Long Hòa', 'Xã', 'Phường/Xã');
INSERT INTO `administrative_division` (`FatherID`, `Name`, `Type`, `Level`) VALUES (24, 'Xã Lý Nhơn', 'Xã', 'Phường/Xã');

