FROM golang:alpine AS builder

WORKDIR /build

ADD go.mod .

COPY . .

RUN go build -o app ./cmd/main.go

FROM alpine

WORKDIR /build

COPY --from=builder /build/app /build/app
COPY rasp.xlsx /build/rasp.xlsx
COPY config/config.yaml /build/config/config.yaml
COPY migration /build/migrate
CMD ["./app"]