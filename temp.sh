#!/bin/bash

echo "🚀 强制触发 GitHub Actions 重新部署..."

# 1. 检查当前状态
echo "📊 当前状态检查："
echo "Git 状态:"
git status --porcelain

echo ""
echo "最后的提交:"
git log -1 --oneline

echo ""
echo "当前分支:"
git branch --show-current

# 2. 确保所有文章都是发布状态
echo ""
echo "📝 确保文章状态正确..."
find content/posts -name "*.md" -exec grep -l "draft: true" {} \; | while read file; do
  echo "修复文章: $file"
  sed -i '' 's/draft: true/draft: false/g' "$file"
done

# 3. 检查 workflow 文件
echo ""
echo "⚙️ 检查 GitHub Actions 配置..."
if [ -f ".github/workflows/hugo.yml" ]; then
  echo "✅ 找到 workflow 文件"
  echo "baseURL 配置:"
  grep -n "baseURL" .github/workflows/hugo.yml || echo "未找到 baseURL 设置"
else
  echo "❌ 未找到 .github/workflows/hugo.yml"
  echo "请确保 GitHub Actions 配置文件存在"
fi

# 4. 添加时间戳文件来强制触发部署
echo ""
echo "🕐 创建时间戳文件强制重新部署..."
echo "Last updated: $(date)" >.deploy-timestamp
git add .deploy-timestamp

# 5. 提交所有更改
echo ""
echo "📤 提交更改..."
if git diff --staged --quiet && git diff --quiet; then
  echo "没有更改，创建空提交来触发部署..."
  git commit --allow-empty -m "Force rebuild: trigger GitHub Actions $(date '+%Y-%m-%d %H:%M:%S')"
else
  git add .
  git commit -m "Fix articles and force rebuild $(date '+%Y-%m-%d %H:%M:%S')"
fi

# 6. 推送到 GitHub
echo ""
echo "🚀 推送到 GitHub..."
git push origin main

# 7. 提供监控链接
echo ""
echo "✅ 部署已触发！"
echo ""
echo "🔍 请立即检查以下链接："
echo "1. GitHub Actions 状态: https://github.com/wurslu/blog/actions"
echo "2. 等待 2-5 分钟后检查网站: https://blog.urlu.cool/posts/"
echo "3. GitHub Pages 设置: https://github.com/wurslu/blog/settings/pages"

echo ""
echo "📋 部署检查清单："
echo "□ Actions 开始运行 (绿色点或黄色圆圈)"
echo "□ 'Build with Hugo' 步骤成功"
echo "□ 'Deploy to GitHub Pages' 步骤成功"
echo "□ 网站更新 (可能需要清除浏览器缓存)"

echo ""
echo "⏰ 预计等待时间: 2-5 分钟"
echo "如果 10 分钟后仍未更新，请检查 Actions 日志中的错误信息"
