# SwiftUI-MarkdownStreamer

**A SwiftUI demo app for streaming Markdown rendering using MarkdownWebView.**

SwiftUI-MarkdownStreamer 演示如何在 SwiftUI 应用中借助 [MarkdownWebView](https://github.com/tomdai/markdown-webview) 包，以“流式”方式逐步渲染 Markdown 内容并自动滚动，同时保留空格和换行。

---

## 功能

* 按固定片段（token）动态加载 Markdown 文本。
* 保留空格与换行，确保原文格式一致。
* 加载完毕后自动清空并重新开始循环演示。
* 自动滚动至底部，并在底部保留可自定义的大间距。
* 基于 SwiftUI + WKWebView 的高性能 Markdown 渲染。

## 要求

* iOS 14.0+ 或 macOS 11.0+
* Xcode 14+
* Swift 5.7+

## 安装

1. 在 Xcode 中打开项目后，选择 **File > Add Packages...**。
2. 输入包地址：

   ```
   https://github.com/tomdai/markdown-webview.git
   ```
3. 选择合适版本并添加为依赖。

## 使用方法

1. 运行 `StreamingMarkdownApp`，即可看到演示界面。
2. 每隔 0.3 秒会加载一批 token，直至整个文档结束；接着自动清空并从头开始。
3. 底部预留了 200pt 的空白，可根据需求在 `ContentView` 中修改：

   ```swift
   .padding(.bottom, 200)
   ```

## 自定义

* **调整加载粒度**：在 `ContentView` 中修改 `chunkSize` 值。
* **调整加载间隔**：修改 `Timer.publish(every: …)` 的时间间隔。
* **更改底部间距**：修改 `.padding(.bottom, …)` 的值。
* **替换 Markdown 内容**：编辑 `StreamingContent.md`（项目资源）中的文本。

## 项目结构

```
StreamingMarkdownApp/
├── StreamingContent.md   # Markdown 原文
├── StreamingMarkdownApp.swift  # @main
└── ContentView.swift      # 核心逻辑与视图
```

## 原理说明

* 使用正则 `([\^\n ]+| +|\n+)` 将全文拆分为文字、空格、换行三种 token。
* 定时器调度：每次取出 `chunkSize` 个 token 拼接到 `displayedMarkdown` 中。
* `MarkdownWebView` 内部通过 `WKWebView` 渲染，支持自动高度适配。
* `ScrollViewReader` + `scrollTo` 实现自动滚动。

## 许可证

本项目采用 MIT 许可证，详情参见 [LICENSE](LICENSE)。

