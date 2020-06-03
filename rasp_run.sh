cd store-react/
sed -i 's/localhost/awakecup.ddns.net/g' ./src/utils/helpers.js
sed -i 's/localhost/awakecup.ddns.net/g' ./public/index.html
yarn install
yarn build
sudo rm -R /var/www/awakecup/*
sudo cp -R build/* /var/www/awakecup/
rm -R ./build

cd ../admin-react
sed -i 's/localhost/awakecup.ddns.net/g' ./src/utils/helpers.js
sed -i 's/localhost/awakecup.ddns.net/g' ./public/index.html
yarn install
yarn build
sudo mkdir /var/www/awakecup/admin
sudo cp -R build/* /var/www/awakecup/admin/
rm -R ./build

cd ../aspnetcore/
dotnet restore
dotnet publish
cd bin/Debug/netcoreapp3.1/publish
sed -i 's/localhost:5000/127.0.0.1:5050/g' appsettings.json
sed -i 's/localhost/awakecup.ddns.net/g' ./wwwroot/apiCalling.js

mv ~/.dotnet/host/awakecup/wwwroot/appdata ~/.dotnet/host/temp
rm -R ~/.dotnet/host/awakecup
mkdir ~/.dotnet/host/awakecup
cp -R * ~/.dotnet/host/awakecup/
mv ~/.dotnet/host/temp ~/.dotnet/host/awakecup/wwwroot
cp -R ~/.dotnet/host/awakecup/wwwroot/temp/* ~/.dotnet/host/awakecup/wwwroot/appdata
rm -R ~/.dotnet/host/awakecup/wwwroot/temp
rm -R ./bin ./obj
cd ~/.dotnet/host/awakecup/
./aspnetcore