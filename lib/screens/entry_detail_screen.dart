import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../config/theme.dart';
import '../models/diary_entry.dart';
import '../providers/diary_provider.dart';

class EntryDetailScreen extends StatefulWidget {
  final DiaryEntry entry;
  final bool isNewEntry;
  const EntryDetailScreen({super.key, required this.entry, this.isNewEntry = false});
  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  bool _showOriginal = false;

  Color get _genreColor => switch (widget.entry.genre) {
    Genre.noir => AppColors.noir, Genre.romantic => AppColors.romantic,
    Genre.sciFi => AppColors.sciFi, Genre.minimalist => AppColors.minimalist,
  };

  List<Color> get _genreGrad => switch (widget.entry.genre) {
    Genre.noir => [AppColors.noir, const Color(0xFF16213E)],
    Genre.romantic => [AppColors.romantic, const Color(0xFFD4446C)],
    Genre.sciFi => [AppColors.sciFi, const Color(0xFF14BDBD)],
    Genre.minimalist => [AppColors.minimalist, const Color(0xFF9E9E9E)],
  };

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(entry.timestamp);
    final timeStr = DateFormat('h:mm a').format(entry.timestamp);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: CustomScrollView(slivers: [
        // Cinematic hero header
        SliverAppBar(
          expandedHeight: 220, pinned: true,
          backgroundColor: _genreColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), shape: BoxShape.circle),
              child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.read<DiaryProvider>().toggleFavorite(entry.id).then((_) => setState(() {})),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), shape: BoxShape.circle),
                child: Icon(entry.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: entry.isFavorite ? AppColors.romanticAccent : Colors.white, size: 20),
              ),
            ),
            IconButton(
              onPressed: () => _shareEntry(entry),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.2), shape: BoxShape.circle),
                child: const Icon(Icons.share_rounded, color: Colors.white, size: 20),
              ),
            ),
            const SizedBox(width: 8),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: _genreGrad),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Text(entry.genre.emoji, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                          Text(entry.genre.displayName, style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
                        ]),
                      ),
                      const SizedBox(height: 12),
                      Text(dateStr, style: GoogleFonts.playfairDisplay(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(timeStr, style: GoogleFonts.inter(
                        fontSize: 13, color: Colors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Toggle original/cinematic
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  _toggleBtn('Cinematic ✨', false),
                  _toggleBtn('Original 📝', true),
                ]),
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: 24),

              // Prose content
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: Container(
                  key: ValueKey(_showOriginal),
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: AppColors.charcoal.withValues(alpha: 0.04), blurRadius: 16, offset: const Offset(0, 4))],
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    if (!_showOriginal) ...[
                      Container(width: 40, height: 3,
                        decoration: BoxDecoration(color: _genreColor, borderRadius: BorderRadius.circular(2))),
                      const SizedBox(height: 20),
                    ],
                    Text(
                      _showOriginal ? entry.rawInput : entry.processedProse,
                      style: _showOriginal
                        ? GoogleFonts.inter(fontSize: 15, color: AppColors.charcoal, height: 1.8)
                        : GoogleFonts.lora(fontSize: 16, color: AppColors.charcoal, height: 1.9,
                            fontStyle: FontStyle.italic),
                    ),
                    if (!_showOriginal) ...[
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('— ${entry.genre.displayName} Style',
                          style: GoogleFonts.playfairDisplay(fontSize: 13, color: _genreColor,
                            fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ]),
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

              const SizedBox(height: 24),

              // Action buttons
              Row(children: [
                Expanded(child: OutlinedButton.icon(
                  onPressed: () { Clipboard.setData(ClipboardData(text: entry.processedProse));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Copied to clipboard ✨', style: GoogleFonts.inter()),
                      backgroundColor: AppColors.midnightBlue, behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))));
                  },
                  icon: const Icon(Icons.copy_rounded, size: 18),
                  label: Text('Copy', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                )),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton.icon(
                  onPressed: () => _shareEntry(entry),
                  icon: const Icon(Icons.share_rounded, size: 18),
                  label: Text('Share', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                )),
              ]).animate().fadeIn(delay: 300.ms),

              const SizedBox(height: 16),

              // Delete button
              Center(child: TextButton.icon(
                onPressed: () => _confirmDelete(entry),
                icon: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.error),
                label: Text('Delete Entry', style: GoogleFonts.inter(color: AppColors.error, fontSize: 13)),
              )),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _toggleBtn(String label, bool isOriginal) {
    final sel = _showOriginal == isOriginal;
    return Expanded(child: GestureDetector(
      onTap: () => setState(() => _showOriginal = isOriginal),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: sel ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10),
          boxShadow: sel ? [BoxShadow(color: AppColors.charcoal.withValues(alpha: 0.06), blurRadius: 8)] : null,
        ),
        child: Text(label, style: GoogleFonts.inter(fontSize: 13,
          fontWeight: sel ? FontWeight.w600 : FontWeight.w500,
          color: sel ? AppColors.charcoal : AppColors.charcoalLight), textAlign: TextAlign.center),
      ),
    ));
  }

  void _shareEntry(DiaryEntry entry) {
    SharePlus.instance.share(ShareParams(
      text: '${entry.processedProse}\n\n— Written with Cinematic Diary ✨',
    ));
  }

  void _confirmDelete(DiaryEntry entry) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Delete Entry?', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
      content: Text('This action cannot be undone.', style: GoogleFonts.lora()),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx),
          child: Text('Cancel', style: GoogleFonts.inter(color: AppColors.charcoalLight))),
        TextButton(onPressed: () {
          context.read<DiaryProvider>().deleteEntry(entry.id);
          Navigator.pop(ctx); Navigator.pop(context);
        }, child: Text('Delete', style: GoogleFonts.inter(color: AppColors.error, fontWeight: FontWeight.w600))),
      ],
    ));
  }
}
