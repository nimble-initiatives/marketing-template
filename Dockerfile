FROM mcr.microsoft.com/dotnet/aspnet:6.0.1-alpine3.14 AS base
WORKDIR /app
EXPOSE 80
#EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0.101-alpine3.14 AS build
# RUN apk add --update npm
WORKDIR /src
COPY ["marketing-template.csproj", "web/"]
# COPY nuget.config web
RUN dotnet restore "web/marketing-template.csproj"
COPY . .
#WORKDIR "src/web"
# RUN npm i
RUN dotnet build "marketing-template.csproj" -c Release -o /app/build

FROM build AS publish
#ARG SHA
RUN dotnet publish "marketing-template.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
#COPY src/web/prod.strife.client.certificate.with.password.pfx /ravendb/prod.strife.client.certificate.with.password.pfx
ENTRYPOINT ["dotnet", "marketing-template.dll"]