09.23 8:21 PM
import 'package:flutter/material.dart';
import 'dart:ui';
void main() {
  runApp(const SuperMediaApp());
}
class SuperMediaApp extends StatelessWidget {
  const SuperMediaApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Media',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(),
    );
  }
}
// 1. Splash Screen with Camera Logo, Super Media & Powered by Adhwaith
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginSignupScreen()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.unsplash.com/photo-1579546929518-9e396f3cc809'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlassContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Icon(Icons.camera, size: 90, color: Colors.white),
                          const SizedBox(height: 15),
                          const Text(
                            'Super Media',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Powered by Adhwaith',
                    style: TextStyle(fontSize: 16, color: Colors.white70, letterSpacing: 1.5, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// Reusable Glassmorphism Container
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  const GlassContainer({Key? key, required this.child, this.padding, this.borderRadius}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: padding ?? const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? Colors.black.withOpacity(0.4) : Colors.white.withOpacity(0.2),
            borderRadius: borderRadius ?? BorderRadius.circular(20),
            border: Border.all(
              color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.4),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
// 2. Login & Signup Screen
class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: GlassContainer(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Welcome to Super Media', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email or Username',
                        hintStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.white60),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        minimumSize: const Size(double.infinity, 45),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainHomeScreen()),
                        );
                      },
                      child: const Text('Login / Sign Up', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
// 3. Main Home Screen with Feed, Stories, Chats, Reels, Marketplace, Games & Profile
class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);
  @override
  State<MainHomeScreen> createState() => MainHomeScreenState();
}
class MainHomeScreenState extends State<MainHomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const FeedScreen(),
    const StoriesScreen(),
    const ReelsScreen(),
    const ChatsScreen(),
    const SearchExploreScreen(),
    const ShoppingMarketplaceScreen(),
    const OfflineGamesScreen(),
    const UserProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1579546929518-9e396f3cc809'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),
          _pages[_currentIndex],
          // iPhone Status Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.black26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('9:41', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('SUPER MEDIA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, size: 16, color: Colors.white),
                      SizedBox(width: 5),
                      Icon(Icons.wifi, size: 16, color: Colors.white),
                      SizedBox(width: 5),
                      Text('98%', style: TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 0)),
              IconButton(icon: Icon(Icons.amp_stories, color: _currentIndex == 1 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 1)),
              IconButton(icon: Icon(Icons.slow_motion_video, color: _currentIndex == 2 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 2)),
              IconButton(icon: Icon(Icons.chat_bubble, color: _currentIndex == 3 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 3)),
              IconButton(icon: Icon(Icons.search, color: _currentIndex == 4 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 4)),
              IconButton(icon: Icon(Icons.shopping_bag, color: _currentIndex == 5 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 5)),
              IconButton(icon: Icon(Icons.sports_esports, color: _currentIndex == 6 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 6)),
              IconButton(icon: Icon(Icons.person, color: _currentIndex == 7 ? Colors.pinkAccent : Colors.white, size: 20), onPressed: () => setState(() => _currentIndex = 7)),
            ],
          ),
        ),
      ),
    );
  }
}
// Feed & Daily Notes Screen
class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 60, bottom: 80),
      children: [
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GlassContainer(
                  borderRadius: BorderRadius.circular(15),
                  child: const Center(child: Text('My Note ✨', style: TextStyle(color: Colors.white, fontSize: 12))),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: GlassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/60')),
                  title: Text('Adhwaith Official', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text('Super Media Post', style: TextStyle(color: Colors.white70)),
                  trailing: Icon(Icons.more_vert, color: Colors.white),
                ),
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(image: NetworkImage('https://picsum.photos/400/600'), fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.favorite, color: Colors.redAccent),
                        SizedBox(width: 15),
                        Icon(Icons.comment, color: Colors.white),
                        SizedBox(width: 15),
                        Icon(Icons.share, color: Colors.white),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white24, foregroundColor: Colors.white),
                      icon: const Icon(Icons.download, size: 16),
                      label: const Text('4K Download'),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Downloaded in 4K without watermark!')));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
// Stories View Screen
class StoriesScreen extends StatelessWidget {
  const StoriesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 80, left: 12, right: 12),
      child: Center(
        child: GlassContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.amp_stories, size: 60, color: Colors.pinkAccent),
              SizedBox(height: 15),
              Text('Stories Viewer & Creator', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 8),
              Text('Tap to view user stories with glassmorphism effects.', style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
// Chats Screen with EMO AI Floating/Integrated Chat Option
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 80, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.between,
            children: [
              const Text('Direct Messages', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              // WhatsApp style circular EMO AI Assistant chat shortcut icon
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmoAiChatScreen()));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.cyanAccent,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.cyanAccent.withOpacity(0.6), blurRadius: 10, spreadRadius: 2)],
                  ),
                  child: const Icon(Icons.smart_toy, color: Colors.black, size: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GlassContainer(
                    child: ListTile(
                      leading: const CircleAvatar(backgroundImage: NetworkImage('https://picsum.photos/50')),
                      title: Text('User ${index + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: const Text('Hey! Check out Super Media app.', style: TextStyle(color: Colors.white70)),
                      trailing: const Text('10:45 AM', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// EMO AI Chat Screen
class EmoAiChatScreen extends StatelessWidget {
  const EmoAiChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('EMO AI Assistant', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1579546929518-9e396f3cc809'), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: GlassContainer(
                      child: const Text('Hello! I am EMO AI, powered by Adhwaith. How can I help you today?', style: TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
                    ),
                  ),
                ),
                GlassContainer(
                  child: Row(
                    children: [
                      const Icon(Icons.mic, color: Colors.cyanAccent),
                      const SizedBox(width: 10),
                      const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Ask EMO AI anything...', hintStyle: TextStyle(color: Colors.white60), border: InputBorder.none), style: TextStyle(color: Colors.white))),
                      IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Dedicated Reels Screen
class ReelsScreen extends StatelessWidget {
  const ReelsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, bottom: 80),
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network('https://picsum.photos/400/800?random=$index', fit: BoxFit.cover),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('@adhwaith_reels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 5),
                    const Text('Super Media 4K Reel Video #Trending', style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                      icon: const Icon(Icons.download, color: Colors.white),
                      label: const Text('Download 4K Without Watermark', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reel downloaded in 4K successfully!')));
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
// Search & Explore Screen
class SearchExploreScreen extends StatefulWidget {
  const SearchExploreScreen({Key? key}) : super(key: key);
  @override
  State<SearchExploreScreen> createState() => _SearchExploreScreenState();
}
class _SearchExploreScreenState extends State<SearchExploreScreen> {
  bool isPrivateAccount = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 80),
      child: Column(
        children: [
          GlassContainer(
            child: Row(
              children: const [
                Icon(Icons.search, color: Colors.white),
                SizedBox(width: 10),
                Text('Search users & tags...', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SwitchListTile(
            title: const Text('Private Account Mode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            value: isPrivateAccount,
            onChanged: (val) => setState(() => isPrivateAccount = val),
            activeColor: Colors.pinkAccent,
          ),
          const Divider(color: Colors.white24),
          Expanded(
            child: GridView.builder(
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network('https://picsum.photos/200?random=$index', fit: BoxFit.cover),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Shopping & Business Marketplace Screen
class ShoppingMarketplaceScreen extends StatelessWidget {
  const ShoppingMarketplaceScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Marketplace (Buy/Sell iPhones)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GlassContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: const DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1511707171634-5f897ff02aa9'), fit: BoxFit.cover)))),
                      const SizedBox(height: 8),
                      const Text('Second-hand iPhone', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      const Text('\$499.00', style: TextStyle(color: Colors.pinkAccent)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// Offline Games Hub Screen
class OfflineGamesScreen extends StatelessWidget {
  const OfflineGamesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('1000+ Offline Games Hub', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 15),
          Expanded(
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return GlassContainer(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.gamepad, size: 36, color: Colors.pinkAccent),
                      const SizedBox(height: 8),
                      Text('Game ${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 12)),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// User Profile & Account Center Screen with Powered by Adhwaith branding
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 80),
      child: ListView(
        children: [
          GlassContainer(
            child: Column(
              children: [
                const CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://picsum.photos/100')),
                const SizedBox(height: 10),
                const Text('Adhwaith', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                const Text('@supermedia_official', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 5),
                const Text('Powered by Adhwaith', style: TextStyle(color: Colors.pinkAccent, fontSize: 12, fontWeight: FontWeight.w600)),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Column(children: [Text('12', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), Text('Posts', style: TextStyle(color: Colors.white60))]),
                    Column(children: [Text('1.5M', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), Text('Followers', style: TextStyle(color: Colors.white60))]),
                    Column(children: [Text('180', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)), Text('Following', style: TextStyle(color: Colors.white60))]),
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
                  onPressed: () {},
                  child: const Text('Edit Profile & Account Center', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Text('Account Posts', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network('https://picsum.photos/200?random=p$index', fit: BoxFit.cover),
              );
            },
          ),
        ],
      ),
    );
  }
}

