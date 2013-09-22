# ウェブページをキャッシュで保存してオフライン閲覧するためのシンプルな実装 

　UIWebViewで読み込んだウェブページをキャッシュ（Cache）で保存して、オフラインで閲覧するための実装です。今回は、あとで読む機能を搭載する「Pocket」などのアプリように、テキストデータのみを抽出して保存するのではなく、テキスト・画像・サイドバーなどのすべてのページの状態を記録する手法をとります。つまり、見たページをそのまんま保存するということです。

　こちらが[サンプルコード](https://github.com/EntreGulss/CachedWebpage)です。

　ページキャッシュの実装方法は基本的に、こちらの記事「[Drop-in offline caching for UIWebView (and NSURLProtocol)](http://robnapier.net/blog/offline-uiwebview-nsurlprotocol-588)」を参考にしています。ちなみに、プログレスバーの実装はこちらの記事「[UIWebViewにプログレスバーを出すためのモジュールを作りました](http://ninjinkun.hatenablog.com/entry/2013/04/22/130200)」を参考にしました。

## (1) 必要なファイル・プレームワーク

* Reachability.h
* Reachability.m
* RNCachingURLProtocol.h
* RNCachingURLProtocol.m
* SystemConfiguration.framework（フレームワーク）

## (2) 実装
　「RNCachingURLProtocol」は、ネットワークのプロトコルをカスタムしています。「AppDelegate.m」でこのプロトコルを以下のように設定してしまいます。すると、どこでNSURLConnectionを使っても、このプロトコルに従って動くようになります。少し工夫するとプロトコルを、通常と「RNCachingURLProtocol」のモードを切り替えるように実装することもできると思います。

```AppDelegate.m
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // プロトコルの設定
    [NSURLProtocol registerClass:[RNCachingURLProtocol class]];

	.
	.
	.
}
```

　このプロトコルの挙動は、

* **初めての読み込みのときは普通にロードする。**
* **一度読み込みが完了した場合、それをキャッシュディレクトリに保存する。**
* **次読み込んだときに、すでにキャッシュが保存されていればそれをUIWebViewに表示する。**

となっています。

　あとは、通常と同じようにUIWebViewでページを読み込めばこのプロトコルに従って読み込みが開始されます。

```WebViewController.m
- (void)reloadWebView 
{
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_urlString]]];
}
```

## (3) もっとできそうなこと

* 記事全体を保存するのではなく、テキストだけを抽出する機能
* ページに含まれる画像だけを抽出して保存する機能
* 保存した記事の情報をユーザーが管理する機能（delegateメソッドなどの実装？）
* 読み込んだページだけでなく、それに含まれるリンク階層の部分も含めて保存する機能


※ 参考記事：
[ネットワーク接続が3GかWifiか圏外かを調べる簡単な方法 - YoheiM .NET](http://www.yoheim.net/blog.php?q=20120625)


