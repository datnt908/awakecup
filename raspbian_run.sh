cd reactjs/
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
rm -R ~/.dotnet/host/awakecup
mkdir ~/.dotnet/host/awakecup
cp -R * ~/.dotnet/host/awakecup/
cd ~/.dotnet/host/awakecup/
./aspnetcore
