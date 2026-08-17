import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: DashboardScreen()));
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Movies', 'icon': Icons.movie, 'url': 'https://www.flickbizz.com.pk/movies', 'color': Colors.red},
      {'title': 'Music', 'icon': Icons.music_note, 'url': 'https://www.flickbizz.com.pk/music', 'color': Colors.blue},
      {'title': 'Web TV', 'icon': Icons.live_tv, 'url': 'https://www.flickbizz.com.pk/webtv', 'color': Colors.green},
      {'title': 'Videos', 'icon': Icons.video_library, 'url': 'https://www.flickbizz.com.pk/videos', 'color': Colors.orange},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(title: const Text("FlickBizz Hub"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WebPlayer(url: menuItems[index]['url'], title: menuItems[index]['title']))),
              child: Container(
                decoration: BoxDecoration(color: menuItems[index]['color'], borderRadius: BorderRadius.circular(20)),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(menuItems[index]['icon'], size: 50, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(menuItems[index]['title'], style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class WebPlayer extends StatelessWidget {
  final String url;
  final String title;
  const WebPlayer({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri(url)),
        initialSettings: InAppWebViewSettings(javaScriptEnabled: true, allowsInlineMediaPlayback: true),
      ),
    );
  }
}
