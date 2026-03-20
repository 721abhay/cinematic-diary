import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../config/theme.dart';
import '../models/diary_entry.dart';
import '../providers/diary_provider.dart';
import 'entry_detail_screen.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});
  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final TextEditingController _textController = TextEditingController();
  Genre _selectedGenre = Genre.noir;
  EntryMode _selectedMode = EntryMode.digital;
  bool _isTransforming = false;

  @override
  void dispose() { _textController.dispose(); super.dispose(); }

  Future<void> _transform() async {
    if (_textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please write something first ✍️', style: GoogleFonts.inter()),
        backgroundColor: AppColors.charcoal, behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ));
      return;
    }
    setState(() => _isTransforming = true);
    try {
      final entry = await context.read<DiaryProvider>().createAndTransformEntry(
        rawInput: _textController.text, genre: _selectedGenre, mode: _selectedMode,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => EntryDetailScreen(entry: entry, isNewEntry: true)),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isTransforming = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Column(children: [
          _buildAppBar(),
          Expanded(child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildModeSelector().animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 24),
              _buildWritingArea().animate().fadeIn(delay: 100.ms, duration: 400.ms),
              const SizedBox(height: 28),
              Text('Choose Your Genre', style: GoogleFonts.playfairDisplay(
                fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.charcoal,
              )).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 4),
              Text('How should your story feel?', style: GoogleFonts.lora(
                fontSize: 13, color: AppColors.charcoalLight, fontStyle: FontStyle.italic,
              )).animate().fadeIn(delay: 250.ms),
              const SizedBox(height: 16),
              _buildGenreSelector().animate().fadeIn(delay: 300.ms, duration: 400.ms),
              const SizedBox(height: 32),
              _buildTransformButton().animate().fadeIn(delay: 400.ms, duration: 400.ms),
            ]),
          )),
        ]),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 24, 16),
      child: Row(children: [
        IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
        const SizedBox(width: 8),
        Text('New Entry', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.charcoal)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)),
          child: Text('${_textController.text.split(' ').where((w) => w.isNotEmpty).length} words',
            style: GoogleFonts.inter(fontSize: 12, color: AppColors.charcoalLight, fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }

  Widget _buildModeSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        _buildModeBtn('Digital ✍️', EntryMode.digital, Icons.keyboard_rounded),
        const SizedBox(width: 4),
        _buildModeBtn('Physical 📸', EntryMode.physical, Icons.camera_alt_rounded),
      ]),
    );
  }

  Widget _buildModeBtn(String label, EntryMode mode, IconData icon) {
    final sel = _selectedMode == mode;
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _selectedMode = mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: sel ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: sel ? [BoxShadow(color: AppColors.charcoal.withValues(alpha: 0.06), blurRadius: 8)] : null,
        ),
        child: Column(children: [
          Icon(icon, color: sel ? AppColors.midnightBlue : AppColors.charcoalLight, size: 22),
          const SizedBox(height: 6),
          Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: sel ? FontWeight.w600 : FontWeight.w500,
            color: sel ? AppColors.charcoal : AppColors.charcoalLight)),
        ]),
      ),
    ));
  }

  Widget _buildWritingArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),
        boxShadow: [BoxShadow(color: AppColors.charcoal.withValues(alpha: 0.03), blurRadius: 20, offset: const Offset(0, 4))],
      ),
      child: _selectedMode == EntryMode.digital ? _buildTextInput() : _buildScanPlaceholder(),
    );
  }

  Widget _buildTextInput() {
    return Column(children: [
      TextField(
        controller: _textController, maxLines: 8, minLines: 6,
        onChanged: (_) => setState(() {}),
        style: GoogleFonts.lora(fontSize: 16, color: AppColors.charcoal, height: 1.8),
        decoration: InputDecoration(
          hintText: 'Tell me about your day...\n\nWrite freely — AI will make it beautiful.',
          hintStyle: GoogleFonts.lora(color: AppColors.charcoalLight.withValues(alpha: 0.35), height: 1.8),
          border: InputBorder.none, contentPadding: const EdgeInsets.all(24), filled: false,
        ),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: AppColors.divider.withValues(alpha: 0.3)))),
        child: Row(children: [
          _toolBtn(Icons.mic_rounded), _toolBtn(Icons.format_quote_rounded), _toolBtn(Icons.emoji_emotions_rounded),
          const Spacer(),
          Text('${_textController.text.length} chars', style: GoogleFonts.inter(
            fontSize: 11, color: AppColors.charcoalLight.withValues(alpha: 0.4))),
        ]),
      ),
    ]);
  }

  Widget _toolBtn(IconData icon) => Padding(
    padding: const EdgeInsets.only(right: 8),
    child: Container(padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, size: 18, color: AppColors.charcoalLight)),
  );

  Widget _buildScanPlaceholder() {
    return Container(
      height: 220, width: double.infinity, padding: const EdgeInsets.all(24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 72, height: 72,
          decoration: BoxDecoration(color: AppColors.gold.withValues(alpha: 0.1), shape: BoxShape.circle),
          child: const Icon(Icons.document_scanner_rounded, size: 36, color: AppColors.gold)),
        const SizedBox(height: 16),
        Text('Scan Your Diary Page', style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.charcoal)),
        const SizedBox(height: 8),
        Text('Take a photo of your handwritten diary\nand AI will convert it to text',
          style: GoogleFonts.lora(fontSize: 13, color: AppColors.charcoalLight, height: 1.5), textAlign: TextAlign.center),
        const SizedBox(height: 16),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded, size: 18),
          label: Text('Open Camera', style: GoogleFonts.inter())),
      ]),
    );
  }

  Widget _buildGenreSelector() {
    return SizedBox(height: 150, child: ListView(scrollDirection: Axis.horizontal,
      children: Genre.values.map((g) => _buildGenreCard(g)).toList()));
  }

  Widget _buildGenreCard(Genre genre) {
    final sel = _selectedGenre == genre;
    final color = _genreColor(genre);
    final grads = _genreGrad(genre);
    return GestureDetector(
      onTap: () => setState(() => _selectedGenre = genre),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), width: 130, margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: sel ? grads : [Colors.white, AppColors.surface]),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: sel ? color : AppColors.divider, width: sel ? 2 : 1),
          boxShadow: sel ? [BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 16, offset: const Offset(0, 4))] : null,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(genre.emoji, style: const TextStyle(fontSize: 28)),
          const Spacer(),
          Text(genre.displayName, style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.bold,
            color: sel ? Colors.white : AppColors.charcoal)),
          const SizedBox(height: 4),
          Text(genre.description, style: GoogleFonts.inter(fontSize: 10,
            color: sel ? Colors.white.withValues(alpha: 0.7) : AppColors.charcoalLight, height: 1.3),
            maxLines: 2, overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }

  Widget _buildTransformButton() {
    return SizedBox(width: double.infinity, height: 60, child: ElevatedButton(
      onPressed: _isTransforming ? null : _transform,
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.gold, foregroundColor: AppColors.charcoal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4, shadowColor: AppColors.gold.withValues(alpha: 0.3)),
      child: _isTransforming
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: AppColors.charcoal)),
            const SizedBox(width: 12),
            Text('Transforming...', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
          ])
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.auto_fix_high_rounded, size: 22), const SizedBox(width: 10),
            Text('Transform to Cinematic ✨', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700)),
          ]),
    ));
  }

  Color _genreColor(Genre g) => switch(g) { Genre.noir => AppColors.noir, Genre.romantic => AppColors.romantic,
    Genre.sciFi => AppColors.sciFi, Genre.minimalist => AppColors.minimalist };
  List<Color> _genreGrad(Genre g) => switch(g) { Genre.noir => [AppColors.noir, AppColors.noirAccent],
    Genre.romantic => [AppColors.romantic, AppColors.romanticAccent], Genre.sciFi => [AppColors.sciFi, AppColors.sciFiAccent],
    Genre.minimalist => [AppColors.minimalist, AppColors.minimalistAccent] };
}
