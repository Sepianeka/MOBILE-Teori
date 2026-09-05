import 'package:flutter/material.dart';

class KelompokScreen extends StatelessWidget {
  const KelompokScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> anggota = [
      {
        'nama': 'Anggota 1',
        'nim': '123220001',
        'kelas': 'IF-A',
        'peran': 'Ketua Kelompok & Lead Developer',
        'inisial': 'A1',
        'gradien': [const Color(0xFF6366F1), const Color(0xFF4F46E5)],
        'keterampilan': ['Flutter', 'Dart', 'Architecture'],
      },
      {
        'nama': 'Anggota 2',
        'nim': '123220002',
        'kelas': 'IF-A',
        'peran': 'Frontend & UI/UX Designer',
        'inisial': 'A2',
        'gradien': [const Color(0xFFEC4899), const Color(0xFFD946EF)],
        'keterampilan': ['Figma', 'UI Design', 'CSS/Styling'],
      },
      {
        'nama': 'Anggota 3',
        'nim': '123220003',
        'kelas': 'IF-A',
        'peran': 'Backend & Logic Specialist',
        'inisial': 'A3',
        'gradien': [const Color(0xFF06B6D4), const Color(0xFF0D9488)],
        'keterampilan': ['Algorithms', 'Logic', 'Data Structures'],
      },
      {
        'nama': 'Anggota 4',
        'nim': '123220004',
        'kelas': 'IF-A',
        'peran': 'QA & Technical Writer',
        'inisial': 'A4',
        'gradien': [const Color(0xFFF59E0B), const Color(0xFFD97706)],
        'keterampilan': ['Testing', 'QA', 'Documentation'],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kelompok'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Header Card dengan Gradasi Modern
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED), Color(0xFF2563EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4F46E5).withValues(alpha: 0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.diversity_3_rounded, color: Colors.white, size: 36),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Tim Pengembangan Aplikasi',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Pemrograman Aplikasi Bergerak • Semester 5',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildHeaderStat('Total Anggota', '${anggota.length} Orang'),
                          Container(height: 20, width: 1, color: Colors.white30),
                          _buildHeaderStat('Kelas', 'IF-A'),
                          Container(height: 20, width: 1, color: Colors.white30),
                          _buildHeaderStat('Status', 'Aktif'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daftar Anggota Kelompok',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFC7D2FE)),
                    ),
                    child: Text(
                      '${anggota.length} Anggota Terdaftar',
                      style: const TextStyle(
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Daftar Anggota dengan Card Premium
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: anggota.length,
                itemBuilder: (context, index) {
                  final item = anggota[index];
                  final List<Color> gradien = item['gradien'] as List<Color>;
                  final List<String> skills = item['keterampilan'] as List<String>;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 5,
                    shadowColor: gradien[0].withValues(alpha: 0.15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                      side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // Avatar Ring Gradasi
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: gradien),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: gradien[0].withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: gradien),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        item['inisial']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item['nama']!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1E293B),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF1F5F9),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            item['kelas']!,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF475569),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Icon(Icons.badge_outlined, size: 16, color: Colors.grey.shade600),
                                        const SizedBox(width: 6),
                                        Text(
                                          'NIM: ${item['nim']}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          const Divider(),
                          const SizedBox(height: 10),

                          // Badge Peran
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: gradien[0].withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: gradien[0].withValues(alpha: 0.2)),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.work_outline_rounded, size: 18, color: gradien[0]),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    item['peran']!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: gradien[0],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Skill / Sub-tag Chips
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: skills.map((skill) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Text(
                                  skill,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
