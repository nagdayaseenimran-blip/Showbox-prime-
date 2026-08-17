import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FlickBizzApp());
}

class FlickBizzApp extends StatelessWidget {
  const FlickBizzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlickBizz Media',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF00F0FF),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1E1E1E),
          selectedItemColor: Color(0xFF00F0FF),
          unselectedItemColor: Colors.grey,
        ),
      ),
      home: const MainMediaScreen(),
    );
  }
}

class MainMediaScreen extends StatefulWidget {
  const MainMediaScreen({super.key});

  @override
  State<MainMediaScreen> createState() => _MainMediaScreenState();
}

class _MainMediaScreenState extends State<MainMediaScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _navItems = [
    {
      'title': 'Movies',
      'icon': Icons.movie_outlined,
      'activeIcon': Icons.movie,
      'url': 'https://www.flickbizz.com.pk/movies',
    },
    {
      'title': 'Music',
      'icon': Icons.music_note_outlined,
      'activeIcon': Icons.music_note,
      'url': 'https://www.flickbizz.com.pk/music',
    },
    {
      'title': 'Web TV',
      'icon': Icons.live_tv_outlined,
      'activeIcon': Icons.live_tv,
      'url': 'https://www.flickbizz.com.pk/webtv',
    },
    {
      'title': 'Videos',
      'icon': Icons.video_library_outlined,
      'activeIcon': Icons.video_library,
      'url': 'https://www.flickbizz.com.pk/videos',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Text(
          _navItems[_currentIndex]['title'],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _navItems.map((item) {
          return WebViewTab(url: item['url']);
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon']),
            activeIcon: Icon(item['activeIcon']),
            label: item['title'],
          );
        }).toList(),
      ),
    );
  }
}

class WebViewTab extends StatefulWidget {
  final String url;
  const WebViewTab({super.key, required this.url});

  @override
  State<WebViewTab> createState() => _WebViewTabState();
}

class _WebViewTabState extends State<WebViewTab> {
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.url)),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            mediaPlaybackRequiresUserGesture: false,
            allowsInlineMediaPlayback: true,
            useHybridComposition: true,
          ),
          onProgressChanged: (controller, progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
        ),
        if (_progress < 1.0)
          LinearProgressIndicator(
            value: _progress,
            color: const Color(0xFF00F0FF),
            backgroundColor: Colors.black26,
          ),
      ],
    );
  }
}
