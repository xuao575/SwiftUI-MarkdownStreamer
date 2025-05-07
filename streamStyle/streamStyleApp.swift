import SwiftUI
import MarkdownWebView
import Foundation   // 读取文件需要

@main
struct StreamingMarkdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    /// 从 Bundle 里加载外部 Markdown 文件
    private let fullMarkdown: String = {
        guard let url = Bundle.main.url(forResource: "StreamingContent", withExtension: "md") else {
            return "# 错误：未找到 StreamingContent.md"
        }
        return (try? String(contentsOf: url, encoding: .utf8))
            ?? "# 错误：无法读取 StreamingContent.md"
    }()

    // 正则依旧按之前的拆分逻辑
    private var chunks: [String] {
        let pattern = #"([^\n ]+| +|\n+)"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        let ns = fullMarkdown as NSString
        return regex
            .matches(in: fullMarkdown, range: NSRange(location: 0, length: ns.length))
            .map { ns.substring(with: $0.range) }
    }

    private let chunkSize = 5
    @State private var displayedMarkdown = ""
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        MarkdownWebView(displayedMarkdown)
                            .id("MARKDOWN")
                        Color.clear.frame(height: 1).id("BOTTOM")
                    }
                    // 普通四周 padding
                    .padding()
                    // 单独给底部留出大间距
                    .padding(.bottom, 200)
                }
                .navigationTitle("流式 Markdown")
                .onReceive(timer) { _ in
                    withAnimation(.easeIn) {
                        streamNextChunk(scrollProxy: proxy)
                    }
                }
            }
        }
    }

    private func streamNextChunk(scrollProxy proxy: ScrollViewProxy) {
        guard !chunks.isEmpty else { return }
        if currentIndex < chunks.count {
            let end = min(currentIndex + chunkSize, chunks.count)
            let next = chunks[currentIndex..<end].joined()
            displayedMarkdown += next
            currentIndex = end
        } else {
            displayedMarkdown = ""
            currentIndex = 0
        }
        // proxy.scrollTo("BOTTOM", anchor: .bottom)
    }
}
