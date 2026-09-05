import 'package:flutter/material.dart';

class TotalAngkaScreen extends StatefulWidget {
  const TotalAngkaScreen({super.key});

  @override
  State<TotalAngkaScreen> createState() => _TotalAngkaScreenState();
}

class _TotalAngkaScreenState extends State<TotalAngkaScreen> {
  final TextEditingController _inputController = TextEditingController();

  List<double> _parsedNumbers = [];
  double? _totalSum;
  double? _average;
  double? _maxVal;
  double? _minVal;
  bool _isCalculated = false;

  void _calculateTotal() {
    final String rawText = _inputController.text.trim();
    if (rawText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Silakan masukkan angka pada field input!'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    // Split text by common separators: comma, space, newline, semicolon, plus
    final RegExp regExp = RegExp(r'[\s,;\+]+');
    final List<String> tokens = rawText.split(regExp);

    List<double> numbers = [];
    for (String token in tokens) {
      final cleanToken = token.trim().replaceAll(',', '.');
      if (cleanToken.isNotEmpty) {
        final double? val = double.tryParse(cleanToken);
        if (val != null) {
          numbers.add(val);
        }
      }
    }

    if (numbers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tidak ditemukan angka valid pada field input!'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      setState(() {
        _isCalculated = false;
      });
      return;
    }

    double sum = numbers.reduce((a, b) => a + b);
    double avg = sum / numbers.length;
    double maxV = numbers.reduce((a, b) => a > b ? a : b);
    double minV = numbers.reduce((a, b) => a < b ? a : b);

    setState(() {
      _parsedNumbers = numbers;
      _totalSum = sum;
      _average = avg;
      _maxVal = maxV;
      _minVal = minV;
      _isCalculated = true;
    });
  }

  void _loadPreset(String text) {
    _inputController.text = text;
    _calculateTotal();
  }

  void _reset() {
    setState(() {
      _inputController.clear();
      _parsedNumbers = [];
      _totalSum = null;
      _average = null;
      _maxVal = null;
      _minVal = null;
      _isCalculated = false;
    });
  }

  String _formatNum(double numberVal) {
    if (numberVal == numberVal.roundToDouble()) {
      return numberVal.toInt().toString();
    }
    String str = numberVal.toStringAsFixed(4);
    while (str.contains('.') && (str.endsWith('0') || str.endsWith('.'))) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8B5CF6),
        title: const Text('Jumlah Total Angka'),
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
              // Header Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.summarize_rounded, color: Colors.white, size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Kalkulator Total Input Data',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hitung jumlah total dari deret angka dalam field input',
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Masukkan Angka (Pisahkan dengan koma, spasi, atau baris baru):',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _inputController,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Contoh: 10, 20, 35.5, 40\natau\n15 25 50 100',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: Icon(Icons.edit_note_rounded, color: Color(0xFF8B5CF6)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Quick Preset Chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          const Text(
                            'Contoh Cepat: ',
                            style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                          ActionChip(
                            label: const Text('10, 20, 30, 40'),
                            backgroundColor: const Color(0xFFF3E8FF),
                            labelStyle: const TextStyle(color: Color(0xFF7C3AED), fontSize: 12),
                            onPressed: () => _loadPreset('10, 20, 30, 40'),
                          ),
                          ActionChip(
                            label: const Text('12.5, 7.5, 20, 50'),
                            backgroundColor: const Color(0xFFF3E8FF),
                            labelStyle: const TextStyle(color: Color(0xFF7C3AED), fontSize: 12),
                            onPressed: () => _loadPreset('12.5, 7.5, 20, 50'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _calculateTotal,
                              icon: const Icon(Icons.functions_rounded, size: 20),
                              label: const Text('HITUNG TOTAL'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8B5CF6),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: _reset,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Icon(Icons.refresh_rounded, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Summary Results Card
              if (_isCalculated && _totalSum != null) ...[
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.4), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'JUMLAH TOTAL ANGKA',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatNum(_totalSum!),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 14),

                      // Grid Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('Banyak Angka', '${_parsedNumbers.length} item', Icons.tag),
                          _buildStatItem('Rata-rata', _formatNum(_average!), Icons.show_chart),
                          _buildStatItem('Maksimum', _formatNum(_maxVal!), Icons.arrow_upward),
                          _buildStatItem('Minimum', _formatNum(_minVal!), Icons.arrow_downward),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // List of Parsed Numbers
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Angka yang Terdeteksi (${_parsedNumbers.length}):',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _parsedNumbers.map((itemNum) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E8FF),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFFDDD6FE)),
                            ),
                            child: Text(
                              _formatNum(itemNum),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF6D28D9),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF8B5CF6)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
