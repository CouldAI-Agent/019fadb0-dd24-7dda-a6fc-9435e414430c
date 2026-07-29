import 'package:flutter/material.dart';

void main() {
  runApp(const ReelsApp());
}

class ReelsApp extends StatelessWidget {
  const ReelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reels UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        useMaterial3: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ReelsScreen(),
      },
    );
  }
}

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();

  final List<ReelData> _reels = [
    ReelData(
      id: '1',
      imageUrl: 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?q=80&w=1000&auto=format&fit=crop',
      username: '@flutter_dev',
      caption: 'Building a beautiful Reels UI in Flutter! 🚀 #flutter #ui #dev',
      likes: '124K',
      comments: '4,092',
      shares: '12K',
      musicTrack: 'Original Audio - Flutter Dev',
    ),
    ReelData(
      id: '2',
      imageUrl: 'https://images.unsplash.com/photo-1516280440502-3c469ea7173e?q=80&w=1000&auto=format&fit=crop',
      username: '@coding_life',
      caption: 'Late night coding sessions... ☕️💻 #coding #developer',
      likes: '89K',
      comments: '1,200',
      shares: '5K',
      musicTrack: 'Lofi Vibes - Chill Beats',
    ),
    ReelData(
      id: '3',
      imageUrl: 'https://images.unsplash.com/photo-1526304640581-d334cdbbf45e?q=80&w=1000&auto=format&fit=crop',
      username: '@finance_tips',
      caption: 'Money moves for 2026! 📈💰 #finance #investing',
      likes: '302K',
      comments: '15K',
      shares: '80K',
      musicTrack: 'Trending Song - DJ Tech',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Reels',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.camera_alt_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: _reels.length,
        itemBuilder: (context, index) {
          return ReelItem(reel: _reels[index]);
        },
      ),
    );
  }
}

class ReelData {
  final String id;
  final String imageUrl;
  final String username;
  final String caption;
  final String likes;
  final String comments;
  final String shares;
  final String musicTrack;

  ReelData({
    required this.id,
    required this.imageUrl,
    required this.username,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.musicTrack,
  });
}

class ReelItem extends StatelessWidget {
  final ReelData reel;

  const ReelItem({super.key, required this.reel});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image (Mocking a video)
        Image.network(
          reel.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey.shade900,
            child: const Center(child: Icon(Icons.error_outline, size: 48)),
          ),
        ),
        
        // Gradient overlay for better text readability
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black54,
                Colors.transparent,
                Colors.transparent,
                Colors.black87,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 0.2, 0.6, 1.0],
            ),
          ),
        ),

        // Content (Right Actions & Bottom Info)
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Bottom Info (Username, Caption, Music)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person, color: Colors.grey),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                reel.username,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Follow',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            reel.caption,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.music_note, color: Colors.white, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  reel.musicTrack,
                                  style: const TextStyle(color: Colors.white, fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Right Actions (Like, Comment, Share)
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, bottom: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildAction(Icons.favorite_border, reel.likes),
                        const SizedBox(height: 20),
                        _buildAction(Icons.chat_bubble_outline, reel.comments),
                        const SizedBox(height: 20),
                        _buildAction(Icons.send_outlined, reel.shares),
                        const SizedBox(height: 20),
                        _buildAction(Icons.more_vert, ''),
                        const SizedBox(height: 20),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                              image: NetworkImage('https://images.unsplash.com/photo-1611162616305-c69b3fa7fbe0?q=80&w=100&auto=format&fit=crop'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 32),
        if (label.isNotEmpty) const SizedBox(height: 6),
        if (label.isNotEmpty)
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
