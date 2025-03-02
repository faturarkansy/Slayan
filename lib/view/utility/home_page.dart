import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  WebViewController? _controller;
  bool _isLoading = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for the rotating image
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely

    // Initialize the WebViewController
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // You can update the loading bar progress here if needed
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            Timer(Duration(seconds: 15), () {
              setState(() {
                _isLoading = false;
              });
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://www.figma.com/proto/cZQXetN1602ib98uZwE7rc/SLAYAN')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.figma.com/proto/cZQXetN1602ib98uZwE7rc/SLAYAN'));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller!),
          if (_isLoading)
            Opacity(
              opacity: 1.0, // Set opacity to 100%
              child: Container(
                color: Colors.white, // Ensure the background is solid
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _animationController,
                        child: Image.asset(
                          'assets/images/icon_slayan.png',
                          width: 60, // Reduced size
                          height: 60, // Reduced size
                        ),
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animationController.value *
                                2 *
                                3.1415927, // 2 * pi
                            child: child,
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text('Sedang Memproses Data Terbaru...',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            color: Color(0xFF004D93),
                          )),
                      SizedBox(height: 20),
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: Duration(seconds: 15),
                        builder: (context, double value, child) {
                          return LinearProgressIndicator(value: value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
