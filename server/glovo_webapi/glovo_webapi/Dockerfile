#Create docker image with a .NET released app

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
COPY glovo_webapi/bin/Release/netcoreapp3.1/publish/ App/
WORKDIR /App
CMD ASPNETCORE_URLS=http://*:$PORT dotnet glovo_webapi.dll
