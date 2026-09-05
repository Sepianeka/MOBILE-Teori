import 'package:flutter/material.dart';

void main() {
  runApp(const ProjekSem5App());
}

class ProjekSem5App extends StatelessWidget {
  const ProjekSem5App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projek Sem 5',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool started = false;

  void mulaiSekarang() {
    setState(() {
      started = !started;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          started
              ? 'Mantap! Kamu sudah memulai 🚀'
              : 'Kembali ke halaman utama',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FC),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= NAVBAR =================
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 70,
                vertical: 22,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 15,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Logo
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF6C63FF),
                          Color(0xFF9B8CFF),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.rocket_launch_rounded,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Text(
                    'PROJEK SEM 5',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const Spacer(),

                  if (!isMobile) ...[
                    TextButton(
                      onPressed: () {},
                      child: const Text('Home'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Fitur'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Tentang'),
                    ),
                    const SizedBox(width: 20),
                  ],

                  ElevatedButton(
                    onPressed: mulaiSekarang,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Mulai'),
                  ),
                ],
              ),
            ),

            // ================= HERO =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 25 : 90,
                vertical: isMobile ? 70 : 110,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF2EFFF),
                    Color(0xFFFFFFFF),
                    Color(0xFFEFF8FF),
                  ],
                ),
              ),
              child: isMobile
                  ? Column(
                      children: [
                        _heroText(),
                        const SizedBox(height: 55),
                        _heroCard(),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: _heroText(),
                        ),
                        const SizedBox(width: 70),
                        Expanded(
                          flex: 4,
                          child: _heroCard(),
                        ),
                      ],
                    ),
            ),

            // ================= FEATURES =================
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 25 : 80,
                vertical: 80,
              ),
              child: Column(
                children: [
                  const Text(
                    'Kenapa Memilih Kami?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Dibangun dengan teknologi modern untuk pengalaman yang lebih nyaman.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 45),

                  isMobile
                      ? Column(
                          children: [
                            _featureCard(
                              Icons.speed_rounded,
                              'Cepat',
                              'Performa aplikasi ringan dan responsif.',
                            ),
                            const SizedBox(height: 20),
                            _featureCard(
                              Icons.palette_rounded,
                              'Modern',
                              'Tampilan bersih dengan desain kekinian.',
                            ),
                            const SizedBox(height: 20),
                            _featureCard(
                              Icons.security_rounded,
                              'Aman',
                              'Dibuat dengan struktur aplikasi yang terorganisir.',
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _featureCard(
                                Icons.speed_rounded,
                                'Cepat',
                                'Performa aplikasi ringan dan responsif.',
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: _featureCard(
                                Icons.palette_rounded,
                                'Modern',
                                'Tampilan bersih dengan desain kekinian.',
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: _featureCard(
                                Icons.security_rounded,
                                'Aman',
                                'Dibuat dengan struktur aplikasi yang terorganisir.',
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),

            // ================= FOOTER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(35),
              color: const Color(0xFF17152B),
              child: const Column(
                children: [
                  Text(
                    'PROJEK SEM 5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dibuat menggunakan Flutter 💜',
                    style: TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _heroText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE9E6FF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Text(
            '✨ FLUTTER PROJECT',
            style: TextStyle(
              color: Color(0xFF5A4DD7),
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Bangun Sesuatu\nYang Luar Biasa.',
          style: TextStyle(
            fontSize: 52,
            height: 1.1,
            fontWeight: FontWeight.w800,
            letterSpacing: -1.5,
          ),
        ),

        const SizedBox(height: 22),

        const Text(
          'Eksplorasi ide, buat project, dan kembangkan '
          'kreativitasmu dengan teknologi Flutter.',
          style: TextStyle(
            fontSize: 18,
            height: 1.6,
            color: Colors.black54,
          ),
        ),

        const SizedBox(height: 35),

        ElevatedButton.icon(
          onPressed: mulaiSekarang,
          icon: const Icon(Icons.arrow_forward_rounded),
          label: const Text(
            'Mulai Sekarang',
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _heroCard() {
    return Container(
      height: 330,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C63FF),
            Color(0xFF8E7CFF),
            Color(0xFFB4ACFF),
          ],
        ),
        borderRadius: BorderRadius.circular(35),
        boxShadow: const [
          BoxShadow(
            color: Color(0x306C63FF),
            blurRadius: 40,
            offset: Offset(0, 20),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.12),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -70,
            left: -40,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.10),
                shape: BoxShape.circle,
              ),
            ),
          ),

          const Center(
            child: Icon(
              Icons.flutter_dash_rounded,
              size: 130,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureCard(
    IconData icon,
    String title,
    String description,
  ) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFEDEAFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF6C63FF),
              size: 28,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: const TextStyle(
              color: Colors.black54,
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}