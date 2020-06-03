# Web Store backend with ASP.<i></i>Net Core 3.1

## Installation

### Prerequisited

* **ASP.<i></i>NET CORE 3.1**: Đây là ASP.<i></i>NET platform version dùng trong môi trường phát triển và môi trường triển khai
    * Kiểm tra bằng command `dotnet --info` trong console
    * Cài đặt ASP.<i></i>NET CORE 3.1 tại https://dotnet.microsoft.com/download nếu chưa cài
* **Visual Studio Code** và **Visual Studio 2019** IDE dùng để phát triển
* **MySQL** và **MariaDb**: là DBMS dùng trong dev và deploy. Cả 2 DB đều có độ tương thích cao cho nên có thể dùng thay thế nhau được

***!!!NOTE:***
* Nên cài đặt Visual Studio 2019: chọn workload *ASP.<i></i>NET and web development* như vậy chúng ta vừa sử dụng được VS và cả VSCode. Trong khi nếu cài riêng ASP.<i></i>NET CORE 3.1 ta không thể dùng trong VS.
* Nên sử dụng MySql trên máy dev vì MySql Workbench nhiều hơn và cũng có thể kết nối với remote db server. Chỉ có điều không thể backup và restore từ Workbench, vì DB trên server là MariaDB.

### Clone git and first run

1. Sau khi cài đặt môi trường phát triển. Clone source từ git với
```
git clone https://github.com/datnt908/awake-cup.git
```

3.  Để chạy được aspnetcore
```
dotnet run
```

# Web Store frontend with ReactJS


## Installation

### Prerequisited

* **NodeJs 12.16.3**: Đây là NodeJs platform version dùng trong môi trường phát triển và môi trường triển khai
    * Kiểm tra bằng command `node --version` trong console
    * Cài đặt NodeJs 12.16.3 tại https://nodejs.org/en/ nếu chưa cài
* **Visual Studio Code** IDE dùng để phát triển
* **yarn**: chúng tôi sử dụng yarn để cài đặt package
    * Cài đặt yarn thông qua npm `npm install -g yarn`

***!!!TRICK:*** *Nên cài đặt Node Version Management để có thể dễ dàng cài đặt NodeJS với phiên bản thích hợp và có thể chuyển đổi nhanh phiên bản*

### Clone git and first run

1. Sau khi cài đặt môi trường phát triển. Clone source từ git với
```
git clone https://github.com/datnt908/awake-cup.git
```

2. Sau khi clone thì cài đặt các package bằng yarn hoặc npm
```
cd web-store-reactjs
yarn install
```

3.  Run reactjs app với lệnh
```
yarn start
```

# Quy trình làm việc với source code

1. Sau khi nhận được requirement đã đặc tả, tiến hành thiết kế nhằm giải quyết requirement được giao.
2. Sau khi hoàn chỉnh và chốt bản thiết kế: Developer thực hiện develop theo công việc được phân công trên branch `dev`;
3. Các Developer phải tạo 1 nhánh mới ở local từ nhành `dev`, và thực hiện code trên đó. Sau khi hoàn thành thì tiến hành merge vào nhánh `dev` chính
5. Một requirement hoàn chỉnh sẽ được mang sang branch `master` để public trên server.

***Một số lưu ý:***
* Mỗi một commit phải là commit có khả năng build và run được (không được phép commit lỗi khiến cho cả project không thể build/run)
* Nội dung commit phải nêu lên được công việc thực hiện trong commit đó
* Mỗi buổi phải commit lên công việc của mỗi người trong buổi đó