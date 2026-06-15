# dns-image-gen

TON DNS image generator used by MyTonWallet.

## Docker image

Images are published by GitHub Actions to GHCR under the MyTonWallet organization:

```bash
docker pull ghcr.io/mytonwallet-org/dns-image-gen:master
```

Every push to `master` also publishes an immutable branch+SHA tag such as
`ghcr.io/mytonwallet-org/dns-image-gen:master-<short-sha>`.

## Run locally

```bash
docker build -t dns-image-gen .
docker run --rm -p 8000:8000 dns-image-gen
curl 'http://127.0.0.1:8000/img?d=mytonwallet-dev' --output dns-image.png
```
