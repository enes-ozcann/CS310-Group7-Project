import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/shared_widgets.dart';

class NewTripPage extends StatefulWidget {
  final VoidCallback onBack;

  const NewTripPage({super.key, required this.onBack});

  @override
  State<NewTripPage> createState() => _NewTripPageState();
}

class _NewTripPageState extends State<NewTripPage> {
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final budgetController = TextEditingController(text: '1000');
  DateTime? startDate = DateTime(2025, 6, 1);
  DateTime? endDate = DateTime(2025, 6, 7);
  String currency = '€';
  String? selectedCity;

  @override
  void dispose() {
    nameController.dispose();
    cityController.dispose();
    countryController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  String dateLabel(DateTime? date) {
    if (date == null) return 'Tarih seçin';
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  Future<void> pickDate(bool isStart) async {
    final initial = (isStart ? startDate : endDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(picked)) endDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 22),
      children: [
        Row(
          children: [
            TextButton.icon(
              onPressed: widget.onBack,
              icon: const Icon(Icons.arrow_back, size: 16),
              label: const Text('Gezilerime Dön'),
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.text,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                shape: const StadiumBorder(),
                textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            const SectionPill('Gezi Planlama', light: true),
          ],
        ),
        const SizedBox(height: 13),
        PageCard(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Yeni Gezi Oluştur', style: TextStyle(color: AppColors.navy, fontSize: 22, fontWeight: FontWeight.w900)),
              const SizedBox(height: 5),
              const Text('Hedef şehir, tarih aralığı ve bütçenizi belirleyin; smartPack valiz ve harcama listenizi hazırlasın.', style: TextStyle(color: AppColors.muted, fontSize: 11, height: 1.35)),
              const SizedBox(height: 18),
              const _FieldLabel('HIZLI POPÜLER ŞEHİR SEÇİMİ'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _CityChoice(name: 'Roma', selected: selectedCity == 'Roma', onTap: () => chooseCity('Roma', 'İtalya')),
                  _CityChoice(name: 'Paris', selected: selectedCity == 'Paris', onTap: () => chooseCity('Paris', 'Fransa')),
                  _CityChoice(name: 'Barcelona', selected: selectedCity == 'Barcelona', onTap: () => chooseCity('Barcelona', 'İspanya')),
                  _CityChoice(name: 'Tokyo', selected: selectedCity == 'Tokyo', onTap: () => chooseCity('Tokyo', 'Japonya')),
                  _CityChoice(name: 'İstanbul', selected: selectedCity == 'İstanbul', onTap: () => chooseCity('İstanbul', 'Türkiye')),
                ],
              ),
              const SizedBox(height: 18),
              _FieldLabel('GEZİ ADI', required: true),
              const SizedBox(height: 6),
              _TextInput(controller: nameController, hint: 'Örn: Roma Kaçamağı 2025, Paris Balayı'),
              const SizedBox(height: 16),
              _FieldLabel('HEDEF ŞEHİR', required: true),
              const SizedBox(height: 6),
              _TextInput(controller: cityController, hint: 'Örn: Roma', icon: Icons.location_on_outlined),
              const SizedBox(height: 16),
              _FieldLabel('ÜLKE', required: true),
              const SizedBox(height: 6),
              _TextInput(controller: countryController, hint: 'Örn: İtalya'),
              const SizedBox(height: 16),
              _FieldLabel('BAŞLANGIÇ TARİHİ', required: true),
              const SizedBox(height: 6),
              _DateInput(label: dateLabel(startDate), onTap: () => pickDate(true)),
              const SizedBox(height: 16),
              _FieldLabel('BİTİŞ TARİHİ', required: true),
              const SizedBox(height: 6),
              _DateInput(label: dateLabel(endDate), onTap: () => pickDate(false)),
              const SizedBox(height: 17),
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(color: const Color(0xFFF7F9FC), border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.currency_exchange, color: AppColors.teal, size: 17),
                        SizedBox(width: 8),
                        Text('BAŞLANGIÇ BÜTÇESİ & PARA BİRİMİ', style: TextStyle(color: AppColors.navy, fontSize: 10, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const _FieldLabel('PARA BİRİMİ'),
                    const SizedBox(height: 7),
                    Row(
                      children: ['€', r'$', '฿', '£'].map((symbol) {
                        final active = currency == symbol;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: OutlinedButton(
                              onPressed: () => setState(() => currency = symbol),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: active ? AppColors.teal : Colors.white,
                                foregroundColor: active ? Colors.white : AppColors.navy,
                                side: BorderSide(color: active ? AppColors.teal : AppColors.border),
                                padding: const EdgeInsets.symmetric(vertical: 9),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                              ),
                              child: Text(symbol, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    const _FieldLabel('TOPLAM BAŞLANGIÇ BÜTÇESİ'),
                    const SizedBox(height: 6),
                    TextField(
                      controller: budgetController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: '$currency  ',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('* Bu bütçe daha sonra Bütçe sekmesindeki kalem ikonu ile her zaman güncellenebilir.', style: TextStyle(color: AppColors.muted, fontSize: 9, height: 1.35)),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: createTrip,
                  icon: const Icon(Icons.auto_awesome, size: 17),
                  label: const Text('Create Trip (Gezimi Oluştur)'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void chooseCity(String city, String country) {
    setState(() {
      selectedCity = city;
      cityController.text = city;
      countryController.text = country;
    });
  }

  void createTrip() {
    if (nameController.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        countryController.text.trim().isEmpty ||
        startDate == null ||
        endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen zorunlu alanları doldurun.')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Gezi oluşturuldu. (Demo)')),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  final bool required;

  const _FieldLabel(this.text, {this.required = false});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Color(0xFF52647F), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: .5),
        children: [
          TextSpan(text: text),
          if (required) const TextSpan(text: ' *', style: TextStyle(color: Colors.red)),
        ],
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData? icon;

  const _TextInput({required this.controller, required this.hint, this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.blueGrey, fontSize: 12),
        prefixIcon: icon == null ? null : Icon(icon, size: 17, color: AppColors.muted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: AppColors.teal)),
      ),
    );
  }
}

class _DateInput extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _DateInput({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(11)),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_outlined, size: 17, color: AppColors.muted),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(color: AppColors.navy, fontSize: 12, fontWeight: FontWeight.w600)),
            const Spacer(),
            const Icon(Icons.calendar_today_outlined, size: 15, color: AppColors.navy),
          ],
        ),
      ),
    );
  }
}

class _CityChoice extends StatelessWidget {
  final String name;
  final bool selected;
  final VoidCallback onTap;

  const _CityChoice({required this.name, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: 72,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: selected ? AppColors.pale : Colors.white,
          border: Border.all(color: selected ? AppColors.teal : AppColors.border),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Container(
              height: 43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                gradient: const LinearGradient(colors: [Color(0xFF83C6D1), Color(0xFF315E7B)]),
              ),
              child: const Center(child: Icon(Icons.location_city, color: Colors.white, size: 25)),
            ),
            const SizedBox(height: 5),
            Text(name, style: const TextStyle(color: AppColors.navy, fontSize: 10, fontWeight: FontWeight.w800)),
          ],
        ),
      ),
    );
  }
}
