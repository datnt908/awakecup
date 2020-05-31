cd reactjs/
sed -i 's/localhost/awakecup.ddns.net/g' ./src/utils/apiCalling.js
yarn install
rm -R ./build
yarn build
sudo rm -R /var/www/awakecup/*
sudo cp -R build/* /var/www/awakecup/

cd ../aspnetcore/
rm -R ./bin ./obj
dotnet restore
dotnet publish
cd bin/Debug/netcoreapp3.1/publish
sed -i 's/localhost:5000/127.0.0.1:5050/g' appsettings.json

mv ~/.dotnet/host/awakecup/wwwroot/appdata ~/.dotnet/host/temp
rm -R ~/.dotnet/host/awakecup
mkdir ~/.dotnet/host/awakecup
cp -R * ~/.dotnet/host/awakecup/
mv ~/.dotnet/host/temp ~/.dotnet/host/awakecup/wwwroot
cp -R ~/.dotnet/host/awakecup/wwwroot/temp/* ~/.dotnet/host/awakecup/wwwroot/appdata
rm -R ~/.dotnet/host/awakecup/wwwroot/temp
cd ~/.dotnet/host/awakecup/
./aspnetcore
