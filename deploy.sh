#!/bin/bash

# VIP Diamond Collection 一键部署脚本
# 使用方法: bash deploy.sh

echo "🚀 开始部署 VIP Diamond Collection..."
echo ""

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 检查 Git 是否安装
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git 未安装，请先安装 Git${NC}"
    echo "macOS: brew install git"
    echo "或访问: https://git-scm.com/downloads"
    exit 1
fi

# 检查是否已经是 Git 仓库
if [ ! -d ".git" ]; then
    echo -e "${BLUE}📦 初始化 Git 仓库...${NC}"
    git init
    echo -e "${GREEN}✅ Git 仓库初始化完成${NC}"
    echo ""
else
    echo -e "${GREEN}✅ Git 仓库已存在${NC}"
    echo ""
fi

# 添加所有文件
echo -e "${BLUE}📝 添加文件到 Git...${NC}"
git add .

# 提交更改
echo -e "${BLUE}💾 提交更改...${NC}"
COMMIT_MSG="Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$COMMIT_MSG" || echo "没有新的更改"

# 检查是否有远程仓库
if git remote | grep -q "origin"; then
    echo -e "${GREEN}✅ 检测到远程仓库${NC}"
    echo ""

    # 推送到 GitHub
    echo -e "${BLUE}⬆️  推送到 GitHub...${NC}"
    git push origin main || git push origin master

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ 推送成功！${NC}"
        echo ""
    else
        echo -e "${RED}❌ 推送失败，请检查网络或权限${NC}"
        exit 1
    fi
else
    echo -e "${RED}⚠️  未配置远程仓库${NC}"
    echo ""
    echo "请先创建 GitHub 仓库，然后运行："
    echo -e "${BLUE}git remote add origin https://github.com/你的用户名/你的仓库名.git${NC}"
    echo ""
    echo "然后重新运行此脚本"
    exit 1
fi

# 检查 Vercel CLI 是否安装
if ! command -v vercel &> /dev/null; then
    echo -e "${RED}⚠️  Vercel CLI 未安装${NC}"
    echo ""
    echo "请运行以下命令安装:"
    echo -e "${BLUE}npm install -g vercel${NC}"
    echo ""
    echo "安装后重新运行此脚本进行部署"
    exit 0
fi

# 部署到 Vercel
echo -e "${BLUE}🚀 部署到 Vercel...${NC}"
vercel --prod

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}🎉 部署成功！${NC}"
    echo ""
    echo "您的网站已经上线！"
    echo "Vercel 会显示访问链接，通常格式为："
    echo -e "${BLUE}https://你的项目名.vercel.app${NC}"
else
    echo -e "${RED}❌ 部署失败${NC}"
    exit 1
fi

echo ""
echo "==============================================="
echo -e "${GREEN}✨ 完成！${NC}"
echo "==============================================="
