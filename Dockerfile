FROM cirrusci/flutter:stable as build

WORKDIR /app

COPY . .

RUN flutter doctor -v
RUN flutter build web

FROM python:3

WORKDIR /app

COPY --from=build /app/build/web .

CMD python3 -m http.server $PORT