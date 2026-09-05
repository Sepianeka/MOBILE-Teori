import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: const [
              Icon(Icons.logout, color: Color(0xFFEF4444)),
              SizedBox(width: 10),
              Text('Konfirmasi Keluar'),
            ],
          ),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pushReplacementNamed(context, '/login'); // Redirect to login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Data Kelompok',
        'subtitle': 'Daftar & Profil Anggota Tim',
        'icon': Icons.groups_rounded,
        'color1': const Color(0xFF6366F1),
        'color2': const Color(0xFF4F46E5),
        'route': '/kelompok',
      },
      {
        'title': 'Penjumlahan & Pengurangan',
        'subtitle': 'Operasi Hitung (+) dan (-)',
        'icon': Icons.add_circle_outline_rounded,
        'color1': const Color(0xFF10B981),
        'color2': const Color(0xFF059669),
        'route': '/tambah_kurang',
      },
      {
        'title': 'Perkalian & Pembagian',
        'subtitle': 'Operasi Hitung (×) dan (÷)',
        'icon': Icons.calculate_rounded,
        'color1': const Color(0xFFF59E0B),
        'color2': const Color(0xFFD97706),
        'route': '/kali_bagi',
      },
      {
        'title': 'Ganjil / Genap',
        'subtitle': 'Cek Sifat Bilangan Bulat',
        'icon': Icons.exposure_rounded,
        'color1': const Color(0xFFEC4899),
        'color2': const Color(0xFFDB2777),
        'route': '/ganjil_genap',
      },
      {
        'title': 'Jumlah Total Angka',
        'subtitle': 'Hitung Total Suatu Field Input',
        'icon': Icons.summarize_rounded,
        'color1': const Color(0xFF8B5CF6),
        'color2': const Color(0xFF7C3AED),
        'route': '/total_angka',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Utama'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person_rounded, size: 40, color: Color(0xFF6366F1)),
              ),
              accountName: const Text(
                'Pengguna Terautentikasi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              accountEmail: const Text('admin@mobileteori.com'),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_rounded, color: Color(0xFF6366F1)),
              title: const Text('Dashboard Utama'),
              onTap: () => Navigator.pop(context),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.groups_rounded, color: Color(0xFF6366F1)),
              title: const Text('Data Kelompok'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/kelompok');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline, color: Color(0xFF10B981)),
              title: const Text('Penjumlahan & Pengurangan'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tambah_kurang');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate_rounded, color: Color(0xFFF59E0B)),
              title: const Text('Perkalian & Pembagian'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/kali_bagi');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exposure_rounded, color: Color(0xFFEC4899)),
              title: const Text('Cek Ganjil / Genap'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/ganjil_genap');
              },
            ),
            ListTile(
              leading: const Icon(Icons.summarize_rounded, color: Color(0xFF8B5CF6)),
              title: const Text('Jumlah Total Angka'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/total_angka');
              },
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFFEF4444)),
              title: const Text('Keluar dari Aplikasi', style: TextStyle(color: Color(0xFFEF4444))),
              onTap: () {
                Navigator.pop(context);
                _showLogoutDialog(context);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Welcome Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.waving_hand_rounded, color: Colors.amber, size: 28),
                        ),
                        const SizedBox(width: 14),
                        const Text(
                          'Selamat Datang!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Silakan pilih menu kalkulasi atau informasi data kelompok di bawah ini.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              const Text(
                'Menu Utama Aplikasi',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),

              // Grid Menu Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWideScreen = constraints.maxWidth > 600;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isWideScreen ? 3 : 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: isWideScreen ? 1.2 : 0.95,
                    ),
                    itemCount: menuItems.length,
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, item['route']);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [item['color1'], item['color2']],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: (item['color1'] as Color).withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(item['icon'], color: Colors.white, size: 32),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                item['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['subtitle'],
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
