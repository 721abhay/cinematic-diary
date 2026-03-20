import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../providers/diary_provider.dart';
import '../services/storage_service.dart';
import 'onboarding_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = context.read<DiaryProvider>().username;
  }

  @override
  void dispose() { _nameController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream, elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded)),
        title: Text('Settings', style: GoogleFonts.playfairDisplay(
          fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.charcoal)),
      ),
      body: Consumer<DiaryProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Profile section
              _sectionTitle('Profile').animate().fadeIn(),
              const SizedBox(height: 12),
              _buildCard([
                _buildNameTile(provider),
              ]).animate().fadeIn(delay: 100.ms),
              const SizedBox(height: 28),

              // Language
              _sectionTitle('Language').animate().fadeIn(delay: 150.ms),
              const SizedBox(height: 12),
              _buildCard([
                _buildLangTile('English', 'en', provider),
                const Divider(height: 1),
                _buildLangTile('हिंदी (Hindi)', 'hi', provider),
              ]).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 28),

              // About
              _sectionTitle('About').animate().fadeIn(delay: 250.ms),
              const SizedBox(height: 12),
              _buildCard([
                _infoTile('Version', '1.0.0', Icons.info_outline_rounded),
                const Divider(height: 1),
                _infoTile('Made with', '❤️ in Hyderabad', Icons.location_on_outlined),
                const Divider(height: 1),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.replay_rounded, color: AppColors.gold, size: 20),
                  ),
                  title: Text('Replay Onboarding', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
                  trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.charcoalLight),
                  onTap: () async {
                    await StorageService.setOnboardingComplete();
                    if (!context.mounted) return;
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                      (route) => false,
                    );
                  },
                ),
              ]).animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 32),

              // App branding
              Center(child: Column(children: [
                Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gold.withValues(alpha: 0.3), width: 2),
                  ),
                  child: const Icon(Icons.auto_stories_rounded, color: AppColors.gold, size: 28),
                ),
                const SizedBox(height: 12),
                Text('CINEMATIC DIARY', style: GoogleFonts.playfairDisplay(
                  fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.charcoal, letterSpacing: 3)),
                const SizedBox(height: 4),
                Text('Your story, beautifully told.', style: GoogleFonts.lora(
                  fontSize: 13, color: AppColors.charcoalLight, fontStyle: FontStyle.italic)),
              ])).animate().fadeIn(delay: 400.ms),
            ]),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title) => Text(title, style: GoogleFonts.playfairDisplay(
    fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.charcoal));

  Widget _buildCard(List<Widget> children) => Container(
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: AppColors.charcoal.withValues(alpha: 0.04), blurRadius: 12, offset: const Offset(0, 4))],
    ),
    child: Column(children: children),
  );

  Widget _buildNameTile(DiaryProvider provider) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.midnightBlue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
        child: const Icon(Icons.person_rounded, color: AppColors.midnightBlue, size: 20),
      ),
      title: Text('Display Name', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(provider.username, style: GoogleFonts.inter(fontSize: 12, color: AppColors.charcoalLight)),
      trailing: const Icon(Icons.edit_rounded, color: AppColors.charcoalLight, size: 18),
      onTap: () => _showNameDialog(provider),
    );
  }

  void _showNameDialog(DiaryProvider provider) {
    _nameController.text = provider.username;
    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Your Name', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
      content: TextField(
        controller: _nameController,
        style: GoogleFonts.inter(fontSize: 16),
        decoration: InputDecoration(
          hintText: 'Enter your name',
          hintStyle: GoogleFonts.inter(color: AppColors.charcoalLight.withValues(alpha: 0.4)),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx),
          child: Text('Cancel', style: GoogleFonts.inter(color: AppColors.charcoalLight))),
        ElevatedButton(onPressed: () {
          if (_nameController.text.trim().isNotEmpty) {
            provider.setUsername(_nameController.text.trim());
          }
          Navigator.pop(ctx);
        }, child: Text('Save', style: GoogleFonts.inter(fontWeight: FontWeight.w600))),
      ],
    ));
  }

  Widget _buildLangTile(String label, String code, DiaryProvider provider) {
    final selected = provider.language == code;
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? AppColors.gold.withValues(alpha: 0.1) : AppColors.surface,
          borderRadius: BorderRadius.circular(10)),
        child: Text(code == 'en' ? '🇬🇧' : '🇮🇳', style: const TextStyle(fontSize: 20)),
      ),
      title: Text(label, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: selected
        ? const Icon(Icons.check_circle_rounded, color: AppColors.gold, size: 22)
        : const Icon(Icons.circle_outlined, color: AppColors.charcoalLight, size: 22),
      onTap: () => provider.setLanguage(code),
    );
  }

  Widget _infoTile(String title, String value, IconData icon) => ListTile(
    leading: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: AppColors.charcoalLight, size: 20)),
    title: Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
    trailing: Text(value, style: GoogleFonts.inter(fontSize: 13, color: AppColors.charcoalLight)),
  );
}
