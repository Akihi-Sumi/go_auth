# golangはversion1.16のalpine版を取得
FROM golang:1.17-alpine
# 最初はGO111MODULE=onにする
ENV  GO111MODULE=on
# アップデートとgitのインストール
RUN apk update && apk add git
# appディレクトリの作成
RUN mkdir /go/src/app
# ワーキングディレクトリの設定
WORKDIR /go/src/app
# ホストのファイルをコンテナの作業ディレクトリに移行
ADD . /go/src/app

RUN go get -u gorm.io/gorm && \
    go get -u gorm.io/driver/mysql && \
    go get -u github.com/gofiber/fiber/v2 && \
    go get -u github.com/gofiber/fiber/v2/middleware/recover && \
    go get -u github.com/dgrijalva/jwt-go && \
    go get -u golang.org/x/crypto/bcrypt
# realizeするときはGO111MODULE=offにする
RUN GO111MODULE=off go get -u github.com/oxequa/realize

CMD ["realize", "start"]