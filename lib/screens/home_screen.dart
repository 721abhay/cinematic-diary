import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../config/theme.dart';
import '../models/diary_entry.dart';
import '../providers/diary_provider.dart';
import 'new_entry_screen.dart';
import 'entry_detail_screen.dart';
import 'settings_screen.dart';
import 'explore_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedTab = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiaryProvider>().init();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Consumer<DiaryProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              );
            }

            return CustomScrollView(
              slivers: [
                // App Bar
                SliverToBoxAdapter(
                  child: _buildHeader(provider),
                ),
                // Stats row
                SliverToBoxAdapter(
                  child: _buildStatsRow(provider),
                ),
                // Tab bar
                SliverToBoxAdapter(
                  child: _buildTabBar(),
                ),
                // Entries list
                if (_selectedTab == 0)
                  _buildEntriesList(provider.entries)
                else
                  _buildEntriesList(provider.favoriteEntries),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const NewEntryScreen()),
          );
        },
        backgroundColor: AppColors.gold,
        icon: const Icon(Icons.edit_rounded, color: AppColors.charcoal),
        label: Text(
          'New Entry',
          style: GoogleFonts.inter(
            color: AppColors.charcoal,
            fontWeight: FontWeight.w700,
          ),
        ),
      )
          .animate()
          .scale(delay: 500.ms, duration: 400.ms, curve: Curves.easeOutBack),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader(DiaryProvider provider) {
    final greeting = _getGreeting();
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.charcoalLight,
                ),
              ).animate().fadeIn(duration: 400.ms),
              const SizedBox(height: 4),
              Text(
                provider.username,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.charcoal,
                ),
              ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SettingsScreen()),
                  );
                },
                icon: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.settings_rounded,
                    color: AppColors.charcoal,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(DiaryProvider provider) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
      child: Row(
        children: [
          _buildStatCard(
            '${provider.totalEntries}',
            'Entries',
            Icons.book_rounded,
            AppColors.midnightBlue,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            '${provider.favoriteEntries.length}',
            'Favorites',
            Icons.favorite_rounded,
            AppColors.romantic,
          ),
          const SizedBox(width: 12),
          _buildStatCard(
            '4',
            'Genres',
            Icons.palette_rounded,
            AppColors.sciFi,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.playfairDisplay(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.charcoalLight,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildTabButton('All Entries', 0),
            _buildTabButton('Favorites', 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.charcoal.withValues(alpha: 0.06),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.charcoal : AppColors.charcoalLight,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildEntriesList(List<DiaryEntry> entries) {
    if (entries.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _selectedTab == 0
                    ? Icons.auto_stories_rounded
                    : Icons.favorite_border_rounded,
                size: 64,
                color: AppColors.charcoalLight.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              Text(
                _selectedTab == 0
                    ? 'No entries yet'
                    : 'No favorites yet',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  color: AppColors.charcoalLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _selectedTab == 0
                    ? 'Tap "+ New Entry" to begin your cinematic journey'
                    : 'Heart your favorite entries to see them here',
                style: GoogleFonts.lora(
                  fontSize: 14,
                  color: AppColors.charcoalLight.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildEntryCard(entries[index], index);
          },
          childCount: entries.length,
        ),
      ),
    );
  }

  Widget _buildEntryCard(DiaryEntry entry, int index) {
    final genreColor = _getGenreColor(entry.genre);
    final dateStr = DateFormat('MMM d, yyyy • h:mm a').format(entry.timestamp);
    final preview = entry.processedProse.length > 120
        ? '${entry.processedProse.substring(0, 120)}...'
        : entry.processedProse;

    return Dismissible(
      key: ValueKey(entry.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 28),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text('Delete Entry?', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
            content: Text('This action cannot be undone.', style: GoogleFonts.lora()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text('Cancel', style: GoogleFonts.inter(color: AppColors.charcoalLight)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text('Delete', style: GoogleFonts.inter(color: AppColors.error, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        context.read<DiaryProvider>().deleteEntry(entry.id);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Entry deleted', style: GoogleFonts.inter()),
          backgroundColor: AppColors.charcoal, behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ));
      },
      child: GestureDetector(
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
            border: Border(
              left: BorderSide(color: genreColor, width: 4),
            ),
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
                  if (entry.isFavorite)
                    const Icon(
                      Icons.favorite_rounded,
                      color: AppColors.romantic,
                      size: 18,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    dateStr,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.charcoalLight.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                preview,
                style: GoogleFonts.lora(
                  fontSize: 14,
                  color: AppColors.charcoal.withValues(alpha: 0.8),
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    entry.mode == EntryMode.digital
                        ? Icons.keyboard_rounded
                        : Icons.camera_alt_rounded,
                    size: 14,
                    color: AppColors.charcoalLight.withValues(alpha: 0.4),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    entry.mode == EntryMode.digital ? 'Digital' : 'Scanned',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.charcoalLight.withValues(alpha: 0.4),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Read more →',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: genreColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
          .animate()
          .fadeIn(delay: (100 * index).ms, duration: 400.ms)
          .slideY(begin: 0.1, end: 0, delay: (100 * index).ms, duration: 400.ms),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.charcoal.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.charcoalLight.withValues(alpha: 0.4),
        selectedLabelStyle: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
        onTap: (index) {
          if (index == 2) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            );
          } else if (index == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ExploreScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories_rounded),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_rounded),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Color _getGenreColor(Genre genre) {
    switch (genre) {
      case Genre.noir:
        return AppColors.noir;
      case Genre.romantic:
        return AppColors.romantic;
      case Genre.sciFi:
        return AppColors.sciFi;
      case Genre.minimalist:
        return AppColors.minimalist;
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning ☀️';
    if (hour < 17) return 'Good Afternoon 🌤️';
    if (hour < 21) return 'Good Evening 🌅';
    return 'Good Night 🌙';
  }
}
