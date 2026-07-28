# 使用官方 Node.js 22 轻量版镜像作为基础镜像
FROM node:22-alpine

ARG NPM_REGISTRY=https://registry.npmmirror.com

# 设置工作目录为项目根目录
WORKDIR /app

# 复制 package.json 和 package-lock.json（如果存在）
COPY package*.json ./

# 安装项目依赖
RUN npm config set registry "${NPM_REGISTRY}" \
    && npm config set fetch-retries 5 \
    && npm config set fetch-retry-mintimeout 2000 \
    && npm config set fetch-retry-maxtimeout 20000 \
    && npm install --no-audit --no-fund

# 复制所有源代码
COPY danmu_api/ ./danmu_api/
COPY config/ ./config_example/

# 暴露端口
EXPOSE 9321

# 启动命令
CMD ["node", "danmu_api/server.js"]
