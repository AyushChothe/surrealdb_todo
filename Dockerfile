FROM ghcr.io/cirruslabs/flutter:latest as build

WORKDIR /app

COPY . .

RUN flutter doctor -v
RUN flutter build web

FROM python:3

WORKDIR /app

COPY --from=build /app/build/web .

EXPOSE 8000

CMD python3 -m http.server 8000
