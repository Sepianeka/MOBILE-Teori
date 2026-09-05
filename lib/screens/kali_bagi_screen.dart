import 'package:flutter/material.dart';

class KaliBagiScreen extends StatefulWidget {
  const KaliBagiScreen({super.key});

  @override
  State<KaliBagiScreen> createState() => _KaliBagiScreenState();
}

class _KaliBagiScreenState extends State<KaliBagiScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  double? _result;
  String _operation = '';
  String _expression = '';
  String? _errorMessage;

  void _calculate(String op) {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      final double n1 = double.parse(_num1Controller.text.replaceAll(',', '.'));
      final double n2 = double.parse(_num2Controller.text.replaceAll(',', '.'));

      setState(() {
        if (op == '*') {
          _result = n1 * n2;
          _operation = 'Perkalian';
          _expression = '${_formatNum(n1)} × ${_formatNum(n2)} = ${_formatNum(_result!)}';
        } else if (op == '/') {
          if (n2 == 0) {
            _result = null;
            _errorMessage = 'Pembagian dengan angka nol (0) tidak diperbolehkan!';
            return;
          }
          _result = n1 / n2;
          _operation = 'Pembagian';
          _expression = '${_formatNum(n1)} ÷ ${_formatNum(n2)} = ${_formatNum(_result!)}';
        }
      });
    }
  }

  String _formatNum(double num) {
    if (num == num.roundToDouble()) {
      return num.toInt().toString();
    }
    // Limit decimal display to 4 decimal places for clean formatting
    String str = num.toStringAsFixed(4);
    while (str.contains('.') && (str.endsWith('0') || str.endsWith('.'))) {
      str = str.substring(0, str.length - 1);
    }
    return str;
  }

  void _reset() {
    setState(() {
      _num1Controller.clear();
      _num2Controller.clear();
      _result = null;
      _operation = '';
      _expression = '';
      _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _num1Controller.dispose();
    _num2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF59E0B),
        title: const Text('Perkalian & Pembagian'),
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
              // Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
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
                      child: const Icon(Icons.calculate_rounded, color: Colors.white, size: 36),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Kalkulator Kali & Bagi',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Hitung perkalian (×) dan pembagian (÷) angka',
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
                          controller: _num1Controller,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          decoration: const InputDecoration(
                            labelText: 'Angka Pertama',
                            hintText: 'Contoh: 12 atau 4.5',
                            prefixIcon: Icon(Icons.looks_one_outlined, color: Color(0xFFF59E0B)),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Silakan masukkan angka pertama';
                            }
                            if (double.tryParse(value.replaceAll(',', '.')) == null) {
                              return 'Input harus berupa angka valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 18),
                        TextFormField(
                          controller: _num2Controller,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
                          decoration: const InputDecoration(
                            labelText: 'Angka Kedua',
                            hintText: 'Contoh: 5 atau 2',
                            prefixIcon: Icon(Icons.looks_two_outlined, color: Color(0xFFF59E0B)),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Silakan masukkan angka kedua';
                            }
                            if (double.tryParse(value.replaceAll(',', '.')) == null) {
                              return 'Input harus berupa angka valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _calculate('*'),
                                icon: const Icon(Icons.close_rounded, size: 22),
                                label: const Text('KALI (×)'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF59E0B),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _calculate('/'),
                                icon: const Icon(Icons.percent_rounded, size: 22),
                                label: const Text('BAGI (÷)'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE11D48),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: _reset,
                            icon: const Icon(Icons.refresh_rounded, color: Colors.grey),
                            label: const Text('Reset Form', style: TextStyle(color: Colors.grey)),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Error Message Warning (Division by zero)
              if (_errorMessage != null) ...[
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Color(0xFFEF4444), size: 28),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Color(0xFF991B1B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Hasil Perhitungan Card
              if (_result != null && _errorMessage == null) ...[
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.4), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 8),
                          Text(
                            'Hasil Perhitungan $_operation',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _expression,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatNum(_result!),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFD97706),
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
