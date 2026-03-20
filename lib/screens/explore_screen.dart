import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../models/diary_entry.dart';
import 'entry_detail_screen.dart';

import '../services/supabase_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<DiaryEntry> _entries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await SupabaseService.fetchExploreEntries();
    
    if (mounted) {
      setState(() {
        _entries = entries.isNotEmpty ? entries : _mockEntries;
        _isLoading = false;
      });
    }
  }

  // Fallback data if Supabase is empty
  final _mockEntries = [
    DiaryEntry(
      id: '1',
      rawInput: 'Went to the beach today...',
      processedProse: 'The waves crashed like shattered glass against the shore. A memory of salt and silence.',
      genre: Genre.noir,
      mode: EntryMode.digital,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isPublic: true,
    ),
    DiaryEntry(
      id: '2',
      rawInput: 'Met someone special at the coffee shop.',
      processedProse: 'Amidst the clatter of porcelain and the scent of roasted beans, our eyes met—a quiet gravity pulling two orbits into one.',
      genre: Genre.romantic,
      mode: EntryMode.physical,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isPublic: true,
    ),
    DiaryEntry(
      id: '3',
      rawInput: 'Read a book all day in my room.',
      processedProse: 'Pages turned. Hours dissolved. The world outside ceased to exist.',
      genre: Genre.minimalist,
      mode: EntryMode.digital,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isPublic: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        backgroundColor: AppColors.cream,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.charcoal),
        ),
        title: Text('Explore', style: GoogleFonts.playfairDisplay(
          fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.charcoal)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Community Spotlight',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.charcoal,
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
                  const SizedBox(height: 8),
                  Text(
                    'Discover cinematic stories written by others around the world.',
                    style: GoogleFonts.lora(
                      fontSize: 14,
                      color: AppColors.charcoalLight,
                      fontStyle: FontStyle.italic,
                    ),
                  ).animate().fadeIn(delay: 100.ms),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = _entries[index];
                  final genreColor = _getGenreColor(entry.genre);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EntryDetailScreen(entry: entry),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border(left: BorderSide(color: genreColor, width: 4)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.charcoal.withValues(alpha: 0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: genreColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(entry.genre.emoji, style: const TextStyle(fontSize: 12)),
                                    const SizedBox(width: 4),
                                    Text(
                                      entry.genre.displayName,
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: genreColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const Icon(Icons.public_rounded, size: 16, color: AppColors.charcoalLight),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            entry.processedProse,
                            style: GoogleFonts.lora(
                              fontSize: 14,
                              color: AppColors.charcoal.withValues(alpha: 0.8),
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: (200 + (100 * index)).ms).slideY(begin: 0.1, end: 0);
                },
                childCount: _entries.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getGenreColor(Genre genre) {
    switch (genre) {
      case Genre.noir: return AppColors.noir;
      case Genre.romantic: return AppColors.romantic;
      case Genre.sciFi: return AppColors.sciFi;
      case Genre.minimalist: return AppColors.minimalist;
    }
  }
}
