FROM golang:1.22-alpine AS builder

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -trimpath -ldflags="-s -w" -o /out/dns-image-gen .

FROM alpine:3.20

RUN addgroup -S app && adduser -S app -G app

WORKDIR /app

COPY --from=builder /out/dns-image-gen /usr/local/bin/dns-image-gen
COPY --from=builder /src/*.png /app/
COPY --from=builder /src/*.ttf /app/
COPY --from=builder /src/*.otf /app/

USER app
EXPOSE 8000

ENTRYPOINT ["dns-image-gen"]
CMD ["--prefix", "/app", "--host", "0.0.0.0:8000"]
