# MarkdownWebView 流式演示

**MarkdownWebView** 是一个性能惊人的 SwiftUI 组件，以 `WKWebView` 为底层但在 SwiftUI `ScrollView` 中仍能保持流畅滚动。

## 一、核心功能

- **自动调整视图高度**：无需手动计算，内容高度变化时自动适配。
- **文本选中**：支持用户长按选中，粘贴时仍保留原始格式。
- **动态内容更新**：绑定 `@State` 的 Markdown 内容改变后会实时刷新。
- **语法高亮**：对代码块进行自动高亮，支持多种语言。
- **LaTeX 渲染**：通过内置插件解析 `$$...$$` 数学公式。

## 二、安装步骤

1. 打开 Xcode，选择 **File > Add Packages...**
2. 在搜索框中粘贴：
   ```
   https://github.com/tomdai/markdown-webview.git
   ```
3. 选择 **Up to Next Major**，点击 **Add Package** 即可。

## 三、基本用法

```swift
import SwiftUI
import MarkdownWebView

struct DemoView: View {
    @State private var md = "# Hello SwiftUI + MarkdownWebView"
    var body: some View {
        NavigationStack {
            MarkdownWebView(md)
        }
    }
}
```

## 四、自定义样式

你可以提供自己的 CSS 文件来定制渲染效果：

```swift
let css = try? String(contentsOf: Bundle.main.url(forResource: "custom", withExtension: "css")!)
MarkdownWebView(markdownContent, customStylesheet: css)
```

- 调整字体：
  ```css
  body { font-family: "Helvetica Neue"; line-height: 1.6; }
  ```
- 更改背景色：
  ```css
  .markdown-body { background-color: #f9f9f9; padding: 20px; }
  ```

## 五、链接处理

默认会调用系统浏览器打开链接，你也可以拦截：

```swift
MarkdownWebView(markdownContent)
  .onLinkActivation { url in
      // 在应用内推送一个 WebView
      navigator.push(WebView(url: url))
  }
```

## 六、高级功能示例

### 6.1 任务列表

- [x] 支持打钩的任务列表
- [ ] 未完成的任务

### 6.2 表格渲染

| 功能           | 描述                              |
| -------------- | --------------------------------- |
| 自动适配高度   | 动态更新，精准无抖动              |
| 文本选中       | 长按选中，复制带格式              |
| 代码高亮       | 支持 Swift、JavaScript、Python 等 |
| LaTeX 渲染     | 内嵌数学公式，兼容大多数语法      |

### 6.3 数学公式

行内公式示例：Euler 定理 $e^{i\\pi} + 1 = 0$

块级公式示例：
$$
\\int_{0}^{\\infty} e^{-x^2} dx = \\frac{\\sqrt{\\pi}}{2}
$$

## 七、性能 & 限制

- **优点**：借助原生 WebView 渲染，复杂排版也能保持流畅滚动。
- **现有问题**：
  1. iOS 14 上偶现内容闪烁。
  2. 大量图片时可能内存占用较高。

## 八、未来计划

1. 增加深色模式自适应样式
2. 支持更多 LaTeX 宏包
3. 优化大文档滚动性能

**项目地址**：
[https://github.com/tomdai/markdown-webview](https://github.com/tomdai/markdown-webview)

> “开源是一种信仰，让代码成为连接世界的桥梁。”

---

感谢所有贡献者和使用者！
