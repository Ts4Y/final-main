
FROM golang:1.24.2-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o tracker .


FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/tracker .

RUN apk add --no-cache libc6-compat
CMD ["./tracker"]