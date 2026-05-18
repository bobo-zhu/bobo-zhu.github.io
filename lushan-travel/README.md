# Lushan Travel - 庐山行旅

一个展示庐山自然风光与人文历史的交互式旅游文化网站。

## 🌟 项目简介

Lushan Travel 是一个基于 Web 的庐山旅游文化展示平台，旨在向用户介绍庐山的自然景观、地质特征、历史文化等丰富内容。

## ✨ 功能特点

- **自然风光展示**：四季景色、河流、植被、瀑布等自然景观介绍
- **地质历史**：展示庐山第四纪冰川遗迹和各种地貌特征
- **文化历史**：时间线形式展示与庐山相关的历史名人
- **天气信息**：展示庐山的气候数据和天气图表
- **游客笔记**：景点介绍和游客分享内容
- **3D地图**：集成 Cesium 3D 地图展示

## 🛠️ 技术栈

| 类别 | 技术 |
|------|------|
| 前端框架 | jQuery、原生 JavaScript |
| 数据可视化 | ECharts |
| 轮播组件 | Swiper |
| 3D地图 | Cesium |
| 样式 | CSS3、Less |

## 📁 项目结构

```
lushine/
├── index.html          # 欢迎页面
├── lushine.html        # 主页（庐山概览）
├── CulHistory.html     # 文化历史时间线
├── GeoHistory.html     # 地质历史介绍
├── Daily.html          # 天气信息页
├── notes.html          # 笔记功能页
├── charts.html         # 数据图表页
├── visibility.html     # 能见度展示页
├── servers.js          # 后端服务器代码（开发环境）
├── package.json        # 依赖配置
├── .nojekyll           # GitHub Pages 配置
└── public/static/
    ├── content/        # CSS 样式文件
    ├── scripts/        # JavaScript 脚本
    ├── fonts/          # 图片资源
    ├── dist/ol/        # OpenLayers 地图库
    └── libs/ace/       # ACE 编辑器库
```

## 🚀 快速开始

### 开发环境运行

```bash
# 安装依赖
npm install

# 启动开发服务器（需要 Node.js 和 PostgreSQL）
node servers.js

# 访问 http://localhost/index
```

### GitHub Pages 部署

由于 GitHub Pages 只支持静态网站，项目已移除后端依赖，可直接部署：

1. 创建 GitHub 仓库
2. 上传代码到仓库
3. 在仓库 Settings → Pages 中配置：
   - Source: `main` 分支
   - Folder: `/ (root)`
4. 部署完成后访问 `https://username.github.io/repo-name/`

## 📄 页面说明

| 页面 | 描述 |
|------|------|
| `index.html` | 网站入口，欢迎页面 |
| `lushine.html` | 主页，展示四季、人口、河流、植被、瀑布等 |
| `CulHistory.html` | 文化历史，时间线展示历史名人 |
| `GeoHistory.html` | 地质历史，介绍冰川、地貌等 |
| `Daily.html` | 每日数据，天气图表展示 |
| `notes.html` | 游客笔记，景点介绍 |
| `charts.html` | 气候图表 |
| `visibility.html` | 能见度展示 |

## 📷 主要景点

- **大坳冰斗** - 庐山最大的冰斗
- **飞来石** - 第四纪冰川遗迹
- **三叠泉** - 著名瀑布景点
- **五老峰** - 山峰地貌
- **锦绣谷** - 峡谷风光
- **芦林湖冰窖** - 冰川地貌

## 📊 历史名人

- 王羲之、陶渊明、李白、白居易
- 欧阳修、苏轼、黄庭坚、朱熹
- 王守仁、康有为等

## 📝 License

MIT License

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

---

🌄 **庐山行旅** - 探索庐山之美
