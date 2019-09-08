FROM golang:1.12.9

RUN go get github.com/PuerkitoBio/goquery          
RUN go get github.com/andybalholm/cascadia         
RUN go get github.com/fjukstad/gocache             
RUN go get -d github.com/kolibrid/kvik/...
RUN go get github.com/gorilla/context              
RUN go get github.com/gorilla/mux                  
RUN go get github.com/pkg/errors                   
RUN go get golang.org/x/net/html                   
RUN go get golang.org/x/net/html/atom              

ADD . $GOPATH/src/github.com/kolibrid/mixt/
WORKDIR $GOPATH/src/github.com/kolibrid/mixt/
RUN go install 

ENTRYPOINT mixt -port=:80
