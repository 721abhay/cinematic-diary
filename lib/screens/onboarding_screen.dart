import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/theme.dart';
import '../services/storage_service.dart';
import 'home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.edit_note_rounded,
      title: 'Write Your Way',
      subtitle: 'Type, speak, or scan your diary entries.\nYour words, your style.',
      accentColor: AppColors.gold,
      bgGradient: [AppColors.midnightBlue, const Color(0xFF0F1128)],
    ),
    _OnboardingPage(
      icon: Icons.auto_fix_high_rounded,
      title: 'AI Transforms',
      subtitle: 'Watch your simple notes become\ncinematic, beautifully written prose.',
      accentColor: AppColors.romanticAccent,
      bgGradient: [const Color(0xFF2D1B36), const Color(0xFF1A0F20)],
    ),
    _OnboardingPage(
      icon: Icons.palette_rounded,
      title: 'Choose Your Genre',
      subtitle: 'Noir • Romantic • Sci-Fi • Minimalist\nEvery entry becomes a unique story.',
      accentColor: AppColors.sciFiAccent,
      bgGradient: [const Color(0xFF0A2E2F), const Color(0xFF061A1B)],
    ),
    _OnboardingPage(
      icon: Icons.translate_rounded,
      title: 'हिंदी Support',
      subtitle: 'Full Hindi language support for\ndiary entries and prose generation.',
      accentColor: AppColors.goldLight,
      bgGradient: [const Color(0xFF2B1F0E), const Color(0xFF1A1308)],
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    await StorageService.setOnboardingComplete();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final page = _pages[index];
              return _buildPage(page);
            },
          ),
          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(32, 20, 32, 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button
                  if (_currentPage < _pages.length - 1)
                    TextButton(
                      onPressed: _finish,
                      child: Text(
                        'Skip',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                      ),
                    )
                  else
                    const SizedBox(width: 60),

                  // Page indicators
                  Row(
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == _currentPage ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == _currentPage
                              ? _pages[_currentPage].accentColor
                              : Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  // Next/Get Started button
                  GestureDetector(
                    onTap: _nextPage,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: _currentPage == _pages.length - 1 ? 140 : 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: _pages[_currentPage].accentColor,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: _pages[_currentPage].accentColor.withValues(alpha: 0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: _currentPage == _pages.length - 1
                            ? Text(
                                'Get Started',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              )
                            : const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(_OnboardingPage page) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: page.bgGradient,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              // Animated icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: page.accentColor.withValues(alpha: 0.1),
                  border: Border.all(
                    color: page.accentColor.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Icon(
                  page.icon,
                  size: 56,
                  color: page.accentColor,
                ),
              )
                  .animate(
                    onPlay: (c) => c.repeat(reverse: true),
                  )
                  .scaleXY(
                    begin: 1.0,
                    end: 1.05,
                    duration: 2000.ms,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(height: 48),
              Text(
                page.title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 20),
              Text(
                page.subtitle,
                style: GoogleFonts.lora(
                  fontSize: 16,
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final List<Color> bgGradient;

  _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.bgGradient,
  });
}
