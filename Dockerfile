FROM golang:1.12.9

RUN go get github.com/PuerkitoBio/goquery    \
    github.com/andybalholm/cascadia \
    github.com/fjukstad/gocache \
    github.com/gorilla/context \
    github.com/gorilla/mux \
    github.com/pkg/errors \
    golang.org/x/net/html \
    golang.org/x/net/html/atom 

RUN go get -d github.com/kolibrid/kvik/...

ADD . $GOPATH/src/github.com/kolibrid/mixt/
WORKDIR $GOPATH/src/github.com/kolibrid/mixt/
RUN go install 

ENV PORT :80
ENV COMPUTE_SERVICE compute-service:80

ENTRYPOINT mixt -port=$PORT -compute-service=$COMPUTE_SERVICE