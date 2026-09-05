import 'package:flutter/material.dart';

class GanjilGenapScreen extends StatefulWidget {
  const GanjilGenapScreen({super.key});

  @override
  State<GanjilGenapScreen> createState() => _GanjilGenapScreenState();
}

class _GanjilGenapScreenState extends State<GanjilGenapScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numberController = TextEditingController();

  int? _checkedNumber;
  bool? _isEven;
  String _signInfo = '';

  void _checkNumber() {
    if (_formKey.currentState!.validate()) {
      final double? parsedVal = double.tryParse(_numberController.text.replaceAll(',', '.'));
      if (parsedVal == null) return;

      final int number = parsedVal.toInt();

      setState(() {
        _checkedNumber = number;
        _isEven = (number % 2 == 0);

        if (number > 0) {
          _signInfo = 'Bilangan Positif';
        } else if (number < 0) {
          _signInfo = 'Bilangan Negatif';
        } else {
          _signInfo = 'Bilangan Nol';
        }
      });
    }
  }

  void _reset() {
    setState(() {
      _numberController.clear();
      _checkedNumber = null;
      _isEven = null;
      _signInfo = '';
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFEC4899),
        title: const Text('Cek Ganjil / Genap'),
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
                    colors: [Color(0xFFEC4899), Color(0xFFDB2777)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEC4899).withValues(alpha: 0.3),
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
                      child: const Icon(Icons.exposure_rounded, color: Colors.white, size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Pemeriksa Ganjil & Genap',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Masukkan sebuah bilangan bulat untuk diperiksa sifatnya',
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _numberController,
                          keyboardType: const TextInputType.numberWithOptions(signed: true),
                          decoration: const InputDecoration(
                            labelText: 'Input Bilangan Bulat',
                            hintText: 'Contoh: 17 atau -42',
                            prefixIcon: Icon(Icons.pin_outlined, color: Color(0xFFEC4899)),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Silakan masukkan bilangan';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Input harus berupa bilangan bulat (tanpa desimal)';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _checkNumber,
                                icon: const Icon(Icons.analytics_outlined, size: 20),
                                label: const Text('CEK BILANGAN'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEC4899),
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
              ),

              // Result Display Card
              if (_checkedNumber != null && _isEven != null) ...[
                const SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: _isEven! ? const Color(0xFF3B82F6) : const Color(0xFFF59E0B),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (_isEven! ? const Color(0xFF3B82F6) : const Color(0xFFF59E0B)).withValues(alpha: 0.15),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isEven! ? const Color(0xFFEFF6FF) : const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isEven! ? Icons.looks_two : Icons.looks_one,
                              color: _isEven! ? const Color(0xFF2563EB) : const Color(0xFFD97706),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _signInfo,
                              style: TextStyle(
                                color: _isEven! ? const Color(0xFF1E40AF) : const Color(0xFFB45309),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Angka $_checkedNumber adalah',
                        style: const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _isEven! ? 'BILANGAN GENAP' : 'BILANGAN GANJIL',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: _isEven! ? const Color(0xFF2563EB) : const Color(0xFFD97706),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _isEven!
                              ? 'Alasan: $_checkedNumber habis dibagi 2 (sisa pembagian % 2 = 0).'
                              : 'Alasan: $_checkedNumber tidak habis dibagi 2 (sisa pembagian % 2 = ${_checkedNumber!.abs() % 2}).',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
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
}
