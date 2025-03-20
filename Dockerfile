# استخدم صورة رسمية لـ .NET Core SDK لبناء التطبيق
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

# نسخ الملفات واستعادة الحزم
COPY *.csproj ./
RUN dotnet restore

# نسخ باقي الملفات وبناء التطبيق
COPY . ./
RUN dotnet publish -c Release -o out

# استخدم صورة .NET Runtime لتشغيل التطبيق
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .

# تحديد المنفذ الذي سيعمل عليه التطبيق
EXPOSE 80
ENTRYPOINT ["dotnet", "WebAPI.dll"]
