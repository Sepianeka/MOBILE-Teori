import 'package:flutter/material.dart';

class KelompokScreen extends StatefulWidget {
  const KelompokScreen({super.key});

  @override
  State<KelompokScreen> createState() => _KelompokScreenState();
}

class _KelompokScreenState extends State<KelompokScreen> {
  final List<Map<String, dynamic>> _anggota = [
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

  final List<List<Color>> _presetGradients = [
    [const Color(0xFF6366F1), const Color(0xFF4F46E5)],
    [const Color(0xFFEC4899), const Color(0xFFD946EF)],
    [const Color(0xFF06B6D4), const Color(0xFF0D9488)],
    [const Color(0xFFF59E0B), const Color(0xFFD97706)],
    [const Color(0xFF10B981), const Color(0xFF059669)],
    [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)],
  ];

  String _generateInisial(String nama) {
    if (nama.trim().isEmpty) return 'A';
    final parts = nama.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts[0].substring(0, parts[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  void _showFormDialog({Map<String, dynamic>? memberToEdit, int? editIndex}) {
    final isEditing = memberToEdit != null && editIndex != null;
    final namaController = TextEditingController(text: isEditing ? memberToEdit['nama'] : '');
    final nimController = TextEditingController(text: isEditing ? memberToEdit['nim'] : '');
    final kelasController = TextEditingController(text: isEditing ? memberToEdit['kelas'] : 'IF-A');
    final peranController = TextEditingController(text: isEditing ? memberToEdit['peran'] : '');
    final skillController = TextEditingController(
      text: isEditing ? (memberToEdit['keterampilan'] as List).join(', ') : '',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            children: [
              Icon(
                isEditing ? Icons.edit_note_rounded : Icons.person_add_alt_1_rounded,
                color: const Color(0xFF6366F1),
              ),
              const SizedBox(width: 10),
              Text(isEditing ? 'Edit Data Anggota' : 'Tambah Anggota Baru'),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: namaController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                      hintText: 'Contoh: Ahmad Subagyo',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Nama harus diisi' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: nimController,
                    decoration: const InputDecoration(
                      labelText: 'NIM',
                      hintText: 'Contoh: 123220005',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'NIM harus diisi' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: kelasController,
                    decoration: const InputDecoration(
                      labelText: 'Kelas',
                      hintText: 'Contoh: IF-A',
                      prefixIcon: Icon(Icons.class_outlined),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Kelas harus diisi' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: peranController,
                    decoration: const InputDecoration(
                      labelText: 'Peran / Tanggung Jawab',
                      hintText: 'Contoh: Developer / UI Designer',
                      prefixIcon: Icon(Icons.work_outline),
                    ),
                    validator: (val) => val == null || val.trim().isEmpty ? 'Peran harus diisi' : null,
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: skillController,
                    decoration: const InputDecoration(
                      labelText: 'Keahlian (Pisahkan koma)',
                      hintText: 'Contoh: Flutter, Dart, UI/UX',
                      prefixIcon: Icon(Icons.star_outline),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final String nama = namaController.text.trim();
                  final String nim = nimController.text.trim();
                  final String kelas = kelasController.text.trim();
                  final String peran = peranController.text.trim();
                  final List<String> skills = skillController.text
                      .split(',')
                      .map((s) => s.trim())
                      .where((s) => s.isNotEmpty)
                      .toList();

                  setState(() {
                    if (isEditing) {
                      _anggota[editIndex] = {
                        'nama': nama,
                        'nim': nim,
                        'kelas': kelas,
                        'peran': peran,
                        'inisial': _generateInisial(nama),
                        'gradien': memberToEdit['gradien'],
                        'keterampilan': skills.isNotEmpty ? skills : ['Team Member'],
                      };
                    } else {
                      final grad = _presetGradients[_anggota.length % _presetGradients.length];
                      _anggota.add({
                        'nama': nama,
                        'nim': nim,
                        'kelas': kelas,
                        'peran': peran,
                        'inisial': _generateInisial(nama),
                        'gradien': grad,
                        'keterampilan': skills.isNotEmpty ? skills : ['Team Member'],
                      });
                    }
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEditing ? 'Data berhasil diperbarui!' : 'Anggota baru berhasil ditambahkan!'),
                      backgroundColor: const Color(0xFF10B981),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(isEditing ? 'Simpan' : 'Tambah'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(int index) {
    final member = _anggota[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Hapus Anggota'),
          content: Text('Apakah Anda yakin ingin menghapus "${member['nama']}" dari kelompok?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _anggota.removeAt(index);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Anggota "${member['nama']}" telah dihapus.'),
                    backgroundColor: const Color(0xFFEF4444),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Kelompok'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1_rounded),
            tooltip: 'Tambah Anggota',
            onPressed: () => _showFormDialog(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showFormDialog(),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Tambah Anggota'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Header Card
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
                          _buildHeaderStat('Total Anggota', '${_anggota.length} Orang'),
                          Container(height: 20, width: 1, color: Colors.white30),
                          _buildHeaderStat('Kelas', _anggota.isNotEmpty ? _anggota[0]['kelas'] : 'IF-A'),
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
                      '${_anggota.length} Anggota Terdaftar',
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

              if (_anggota.isEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: const [
                      Icon(Icons.people_outline, size: 48, color: Colors.grey),
                      SizedBox(height: 12),
                      Text(
                        'Belum Ada Anggota Kelompok',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Tekan tombol "Tambah Anggota" untuk menambahkan data.',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],

              // Daftar Anggota Cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _anggota.length,
                itemBuilder: (context, index) {
                  final item = _anggota[index];
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
                                        Expanded(
                                          child: Text(
                                            item['nama']!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1E293B),
                                            ),
                                            overflow: TextOverflow.ellipsis,
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
                              // Edit & Delete Action Buttons
                              PopupMenuButton<String>(
                                icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                onSelected: (action) {
                                  if (action == 'edit') {
                                    _showFormDialog(memberToEdit: item, editIndex: index);
                                  } else if (action == 'delete') {
                                    _confirmDelete(index);
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: const [
                                        Icon(Icons.edit_outlined, size: 18, color: Color(0xFF6366F1)),
                                        SizedBox(width: 10),
                                        Text('Edit Data'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete_outline, size: 18, color: Color(0xFFEF4444)),
                                        SizedBox(width: 10),
                                        Text('Hapus Anggota', style: TextStyle(color: Color(0xFFEF4444))),
                                      ],
                                    ),
                                  ),
                                ],
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
              const SizedBox(height: 60), // Extra space for FAB
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
