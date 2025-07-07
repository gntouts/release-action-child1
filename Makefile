COMMIT         := $(shell git describe --dirty --long --always)
VERSION        := $(shell cat $(CURDIR)/VERSION)-$(COMMIT)
LDFLAGS_COMMON := -X main.version=$(VERSION)

.PHONY: build clean

build:
	exit 1
	CGO_ENABLED=0 go build -a -ldflags="$(LDFLAGS_COMMON) -s -w -extldflags=-static" -trimpath -o $(CURDIR)/dist/capitalecho main.go

build-all:
	# Linux AMD64
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags="$(LDFLAGS_COMMON) -s -w" -trimpath -o $(CURDIR)/dist/capitalecho-linux-amd64 main.go
	# Linux ARM64  
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -a -ldflags="$(LDFLAGS_COMMON) -s -w" -trimpath -o $(CURDIR)/dist/capitalecho-linux-arm64 main.go

# Clean build artifacts
clean:
	rm -rf $(CURDIR)/dist/