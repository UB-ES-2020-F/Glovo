#Create docker image with a .NET released app

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
COPY publish/ App/
WORKDIR /App
CMD ASPNETCORE_URLS=http://*:$PORT dotnet glovo_webapi.dll
