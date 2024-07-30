# 使用官方的Go镜像作为基础镜像
FROM golang:1.22.3 AS builder

# 设置工作目录
WORKDIR /app

# 复制当前目录下的所有文件到工作目录
COPY . .

# 构建Go应用
RUN go build -o main  main.go

# 使用轻量的Alpine作为基础镜像
FROM alpine:latest

COPY --from=builder /app/main /app/main

RUN ["./app/main"]


