# 使用官方的Go镜像作为基础镜像
FROM golang:1.21 AS builder

# 设置工作目录
WORKDIR /app

# 复制go.mod和go.sum文件
COPY go.mod go.sum ./

# 设置Go模块代理
ENV GOPROXY=https://goproxy.cn,direct

# 下载依赖
RUN go mod download

# 复制当前目录下的所有文件到工作目录
COPY . .

# 构建Go应用
RUN go build -o main ./main.go

FROM alpine:latest

COPY --from=builder /app/main .

# 运行Go应用
CMD ["/bin/bash", "-c", "chmod +x && ./main"]
