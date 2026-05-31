import 'package:flutter/material.dart';

void main() {
  runApp(const TraceBackApp());
}

class TraceBackApp extends StatelessWidget {
  const TraceBackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TraceBack Lost & Found',
      theme: ThemeData(
        primaryColor: const Color(0xFF1E3A8A),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          secondary: const Color(0xFF10B981),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class LocalDatabase {
  static List<Map<String, dynamic>> foundItems = [
    {
      'id': '1',
      'title': "Black leather men's wallet",
      'category': 'Wallets',
      'location': 'Bole, near Edna Mall Cafe',
      'date': 'May 31, 2026',
      'imageUrl':
          'https://images.unsplash.com/photo-1627123424574-724758594e93?w=500',
      'question':
          'What is the first name written on the ID card inside the wallet?',
      'correctAnswer': 'Michael',
      'finderName': 'Sara',
      'rewardPrice': '200 ETB',
    },
    {
      'id': '2',
      'title': 'iPhone 13 Pro Max',
      'category': 'Electronics',
      'location': 'Piassa, near Cathedral',
      'date': 'May 30, 2026',
      'imageUrl':
          'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=500',
      'question': 'What color is the phone case?',
      'correctAnswer': 'Red',
      'finderName': 'Alex',
      'rewardPrice': '1500 ETB',
    },
  ];

  static List<Map<String, dynamic>> activeChats = [];
  static Map<String, String>? currentUser;

  static const List<String> samplePickableImages = [
    'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500',
    'https://images.unsplash.com/photo-1582139329536-e7284fece509?w=500',
    'https://images.unsplash.com/photo-1627123424574-724758594e93?w=500',
    'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=500',
    'https://images.unsplash.com/photo-1553228892584-2162d10c052c?w=500',
  ];
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.security_update_good,
              size: 90,
              color: Color(0xFF1E3A8A),
            ),
            const SizedBox(height: 16),
            const Text(
              'TraceBack Ethiopia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E3A8A),
              ),
            ),
            const Text(
              'Recover your items securely. Reward honest finders.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AuthScreen()),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number or Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {
                LocalDatabase.currentUser = {
                  'name': 'Michael',
                  'phone': '0911223344',
                };
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainNavigationContainer(),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class MainNavigationContainer extends StatefulWidget {
  const MainNavigationContainer({super.key});

  @override
  State<MainNavigationContainer> createState() =>
      _MainNavigationContainerState();
}

class _MainNavigationContainerState extends State<MainNavigationContainer> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const FeedScreen(),
    const PostItemScreen(),
    const ChatsDashboardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF1E3A8A),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.gite), label: 'Feed'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo, size: 28),
            label: 'Post Found',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Chats / Rewards',
          ),
        ],
      ),
    );
  }
}

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TraceBack Live Feed',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: LocalDatabase.foundItems.length,
        itemBuilder: (context, index) {
          final item = LocalDatabase.foundItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  item['imageUrl'],
                  height: 190,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFDCFCE7,
                              ), // Soft background green
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'Reward: ${item['rewardPrice']}',
                              style: const TextStyle(
                                color: Color(0xFF16A34A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '📍 Location: ${item['location']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '👤 Finder: ${item['finderName']}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E3A8A),
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.verified, size: 18),
                        label: const Text('Ooooh, This is Mine!'),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ClaimVerificationScreen(item: item),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});

  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  final _title = TextEditingController();
  final _location = TextEditingController();
  final _reward = TextEditingController();
  final _question = TextEditingController();
  final _answer = TextEditingController();
  String _selectedImage = LocalDatabase.samplePickableImages[0];

  void _pickSimulatedImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Photo from Gallery / Camera Roll',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: LocalDatabase.samplePickableImages.length,
                  itemBuilder: (context, idx) {
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () => _selectedImage =
                              LocalDatabase.samplePickableImages[idx],
                        );
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                _selectedImage ==
                                    LocalDatabase.samplePickableImages[idx]
                                ? Colors.blue
                                : Colors.transparent,
                            width: 3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            LocalDatabase.samplePickableImages[idx],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Found Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _pickSimulatedImage,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(_selectedImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_a_photo),
                          Text(' Change Picture'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _location,
              decoration: const InputDecoration(
                labelText: 'Where did you find it?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reward,
              decoration: const InputDecoration(
                labelText: 'Required Finder Compensation Reward (e.g. 300 ETB)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _question,
              decoration: const InputDecoration(
                labelText: 'Ownership Challenge Question',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _answer,
              decoration: const InputDecoration(
                labelText: 'Secret Answer',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                if (_title.text.isNotEmpty) {
                  setState(() {
                    LocalDatabase.foundItems.insert(0, {
                      'id': DateTime.now().toString(),
                      'title': _title.text,
                      'location': _location.text,
                      'rewardPrice': _reward.text.contains('ETB')
                          ? _reward.text
                          : '${_reward.text} ETB',
                      'imageUrl': _selectedImage,
                      'question': _question.text,
                      'correctAnswer': _answer.text,
                      'finderName': 'You (Finder)',
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notice added to community feed!'),
                    ),
                  );
                }
              },
              child: const Text(
                'Publish Notice',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClaimVerificationScreen extends StatefulWidget {
  final Map<String, dynamic> item;
  const ClaimVerificationScreen({super.key, required this.item});

  @override
  State<ClaimVerificationScreen> createState() =>
      _ClaimVerificationScreenState();
}

class _ClaimVerificationScreenState extends State<ClaimVerificationScreen> {
  final _reply = TextEditingController();

  void _verifyMatch() {
    bool correct =
        _reply.text.trim().toLowerCase() ==
        widget.item['correctAnswer'].toString().toLowerCase();
    if (correct) {
      LocalDatabase.activeChats.insert(0, {
        'title': widget.item['title'],
        'finder': widget.item['finderName'],
        'reward': widget.item['rewardPrice'],
        'status': 'Verified! Waiting for Reward Release',
      });
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(correct ? 'Match Approved! 🎉' : 'Incorrect Answer ❌'),
        content: Text(
          correct
              ? 'Your response is correct. An app chat channel is now open with ${widget.item['finderName']} to claim your item and send compensation.'
              : 'That answer does not match the information provided by the founder. Double-check your details.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Verification')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Confirming ownership for: ${widget.item['title']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.amber[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Question from Finder:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.item['question'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reply,
              decoration: const InputDecoration(
                labelText: 'Type your answer here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
              ),
              onPressed: _verifyMatch,
              child: const Text('Submit Proof Answer'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatsDashboardScreen extends StatelessWidget {
  const ChatsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Claims & Chats')),
      body: LocalDatabase.activeChats.isEmpty
          ? const Center(
              child: Text(
                'No approved item chats yet.\nVerify an item from the feed to talk to finders!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: LocalDatabase.activeChats.length,
              itemBuilder: (context, idx) {
                final chat = LocalDatabase.activeChats[idx];
                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF1E3A8A),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      'Chat with ${chat['finder']} (${chat['title']})',
                    ),
                    subtitle: Text(
                      'Status: ${chat['status']}\nPending Reward: ${chat['reward']}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatRoomScreen(chatSession: chat),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ChatRoomScreen extends StatelessWidget {
  final Map<String, dynamic> chatSession;
  const ChatRoomScreen({super.key, required this.chatSession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(chatSession['finder'])),
      body: Column(
        children: [
          Container(
            color: Colors.yellow[50],
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Finder Compensation Price: ${chatSession['reward']}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.payment, size: 16),
                  label: const Text('Pay Reward'),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentGateScreen(chat: chatSession),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Hello! Thanks for validating the security question. Let me know when you release the payment so we can meet up inside a safe cafe for drop-off.',
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Card(
                      color: Color(0xFF1E3A8A),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Perfect, let me open the payment view to settle the reward immediately.',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type secure conversation thread details...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF1E3A8A)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentGateScreen extends StatelessWidget {
  final Map<String, dynamic> chat;
  const PaymentGateScreen({super.key, required this.chat});

  void _showSuccess(BuildContext context, String gateway) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green),
            Text(' Transfer Completed'),
          ],
        ),
        content: Text(
          'Your payment of ${chat['reward']} was successfully processed via $gateway to ${chat['finder']}. Your unlock handshake token is created.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Awesome'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local Gateway Secure Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        key: const Key('payment_gate_padding'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Settling Payment To: ${chat['finder']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Total Cost: ${chat['reward']}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Choose Your Ethiopian Payment Account Provider:',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              color: const Color(0xFF1D4ED8),
              child: ListTile(
                leading: const Icon(Icons.phone_android, color: Colors.white),
                title: const Text(
                  'Telebirr Mobile Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
                onTap: () => _showSuccess(context, 'Telebirr Wallet'),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: const Color(0xFF7C3AED),
              child: ListTile(
                leading: const Icon(Icons.account_balance, color: Colors.white),
                title: const Text(
                  'CBE Birr / Bank Transfer',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
                onTap: () =>
                    _showSuccess(context, 'Commercial Bank of Ethiopia'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
