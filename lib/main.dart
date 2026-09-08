import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const CuteVideosApp());
}

class CuteVideosApp extends StatelessWidget {
  const CuteVideosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cute Videos',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F1014),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF4F81),
          brightness: Brightness.dark,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String demoVideoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cute Videos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SearchPage(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _welcomeCard(),

          const SizedBox(height: 26),

          const Text(
            'Featured Videos',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          VideoCard(
            title: 'Featured Video',
            category: 'Featured',
            paid: false,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const VideoDetailsPage(
                    title: 'Featured Video',
                    category: 'Featured',
                    paid: false,
                    videoUrl: demoVideoUrl,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 28),

          const Text(
            'Free Videos',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...List.generate(
            3,
            (index) {
              final title = 'Free Video ${index + 1}';

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: VideoListTile(
                  title: title,
                  category: 'Free',
                  paid: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoDetailsPage(
                          title: title,
                          category: 'Free',
                          paid: false,
                          videoUrl: demoVideoUrl,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          const Text(
            'Premium Videos',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...List.generate(
            3,
            (index) {
              final title = 'Premium Video ${index + 1}';
              final price = 20 + (index * 10);

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: VideoListTile(
                  title: title,
                  category: 'Premium',
                  paid: true,
                  price: price,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoDetailsPage(
                          title: title,
                          category: 'Premium',
                          paid: true,
                          price: price,
                          videoUrl: demoVideoUrl,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),

      // NavigationBar is intentionally NOT const.
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.video_library_outlined),
            selectedIcon: Icon(Icons.video_library),
            label: 'My Videos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _welcomeCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF40202E),
            Color(0xFF1C171B),
          ],
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 29,
            backgroundColor: Color(0xFFFF4F81),
            child: Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 34,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              'Welcome to Cute Videos\n'
              'Watch your favorite videos.',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String title;
  final String category;
  final bool paid;
  final VoidCallback onTap;

  const VideoCard({
    super.key,
    required this.title,
    required this.category,
    required this.paid,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF282B35),
              Color(0xFF15161A),
            ],
          ),
        ),
        child: Stack(
          children: [
            const Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 68,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (paid)
                    const Icon(
                      Icons.lock,
                      size: 20,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoListTile extends StatelessWidget {
  final String title;
  final String category;
  final bool paid;
  final int? price;
  final VoidCallback onTap;

  const VideoListTile({
    super.key,
    required this.title,
    required this.category,
    required this.paid,
    this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Row(
        children: [
          Container(
            width: 125,
            height: 78,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: const Color(0xFF202127),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.play_circle_fill,
                    size: 42,
                  ),
                ),
                if (paid)
                  const Positioned(
                    top: 7,
                    right: 7,
                    child: Icon(
                      Icons.lock,
                      size: 17,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),

                if (paid && price != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    '$price Birr',
                    style: const TextStyle(
                      color: Color(0xFFFF4F81),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Colors.white38,
          ),
        ],
      ),
    );
  }
}

class VideoDetailsPage extends StatelessWidget {
  final String title;
  final String category;
  final bool paid;
  final int? price;
  final String videoUrl;

  const VideoDetailsPage({
    super.key,
    required this.title,
    required this.category,
    required this.paid,
    this.price,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video'),
      ),
      body: ListView(
        children: [
          if (paid)
            _lockedPreview()
          else
            VideoPlayerWidget(
              videoUrl: videoUrl,
            ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  category,
                  style: const TextStyle(
                    color: Colors.white60,
                  ),
                ),

                const SizedBox(height: 22),

                if (paid)
                  _paymentButton(context)
                else
                  const Text(
                    'This video is free to watch.',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                const SizedBox(height: 28),

                const Text(
                  'About this video',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'This video will be connected to your own video '
                  'storage when the upload system is added.',
                  style: TextStyle(
                    color: Colors.white60,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockedPreview() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.lock_outline,
                size: 58,
                color: Colors.white,
              ),
              SizedBox(height: 10),
              Text(
                'Premium Video',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (dialogContext) {
              return AlertDialog(
                title: const Text('Premium Video'),
                content: Text(
                  'Payment system is not connected yet.\n\n'
                  'Price: ${price ?? 0} Birr',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text('CLOSE'),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(Icons.lock_open),
        label: Text(
          'UNLOCK FOR ${price ?? 0} BIRR',
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideoFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    _initializeVideoFuture = _controller.initialize();
    _controller.addListener(_videoListener);
  }

  void _videoListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeVideoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _errorView();
          }

          if (!_controller.value.isInitialized) {
            return _errorView();
          }

          final aspectRatio = _controller.value.aspectRatio > 0
              ? _controller.value.aspectRatio
              : 16 / 9;

          return Column(
            children: [
              AspectRatio(
                aspectRatio: aspectRatio,
                child: Container(
                  color: Colors.black,
                  child: VideoPlayer(_controller),
                ),
              ),

              Container(
                color: const Color(0xFF18191E),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),

                    Expanded(
                      child: VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        if (snapshot.hasError) {
          return _errorView();
        }

        return const AspectRatio(
          aspectRatio: 16 / 9,
          child: ColoredBox(
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget _errorView() {
    return const AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Unable to load video.\n'
              'Please check your internet connection.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search videos...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: const Color(0xFF1A1B20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(
            radius: 45,
            backgroundColor: Color(0xFF3A202A),
            child: Icon(
              Icons.person,
              size: 48,
              color: Color(0xFFFF4F81),
            ),
          ),

          const SizedBox(height: 14),

          const Center(
            child: Text(
              'Guest User',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Sign In'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Create Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(
              Icons.account_balance_wallet_outlined,
            ),
            title: const Text('Wallet'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
