#!/bin/bash

# 文件检查脚本
# 使用方法: bash check-files.sh

echo "🔍 检查项目文件..."
echo ""

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 需要的文件列表
declare -a required_files=(
    "index.html"
    "vip-diamonds-style1.html"
    "vip-diamonds-style2.html"
    "vip-diamonds-style3.html"
    "vip-diamonds-gallery.html"
    "vercel.json"
    "README.md"
    ".gitignore"
)

# 检查计数
missing_count=0
found_count=0

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "必需文件检查："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file${NC}"
        ((found_count++))
    else
        echo -e "${RED}❌ $file (缺失)${NC}"
        ((missing_count++))
    fi
done

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "检查结果："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ 已找到: $found_count 个文件${NC}"

if [ $missing_count -gt 0 ]; then
    echo -e "${RED}❌ 缺失: $missing_count 个文件${NC}"
    echo ""
    echo -e "${YELLOW}⚠️  请添加缺失的文件后再部署${NC}"
    echo ""
    echo "缺失的HTML文件可能在桌面上，请复制到此文件夹。"
    echo "或者运行: cp ~/Desktop/vip-diamonds-*.html ."
    exit 1
else
    echo -e "${GREEN}✅ 所有文件都已准备好！${NC}"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🚀 下一步："
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "1. 运行一键部署脚本："
    echo -e "   ${GREEN}bash deploy.sh${NC}"
    echo ""
    echo "2. 或者查看快速开始指南："
    echo -e "   ${GREEN}open QUICKSTART.md${NC}"
    echo ""
    exit 0
fi
