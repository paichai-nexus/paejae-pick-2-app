import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'smart_mobility.dart';

void main() {
  runApp(const PaejaePickApp());
}

class PaejaePickApp extends StatelessWidget {
  const PaejaePickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '배재Pick 2.0',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.notoSansKrTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blue,
          primary: AppColors.blue,
          secondary: AppColors.green,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class AppColors {
  static const blue = Color(0xFF2563EB);
  static const lightBlue = Color(0xFFEAF4FF);
  static const darkBlue = Color(0xFF0F2F6E);
  static const green = Color(0xFF10B981);
  static const yellow = Color(0xFFFBBF24);
  static const orange = Color(0xFFF97316);
  static const purple = Color(0xFF7C3AED);
  static const red = Color(0xFFEF4444);
  static const bg = Color(0xFFF8FAFC);
  static const text = Color(0xFF111827);
  static const sub = Color(0xFF6B7280);
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            children: [
              const Spacer(),
              const Nasumi(size: 140, label: 'P'),
              const SizedBox(height: 26),
              const Text(
                '배재Pick 2.0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '학교를 더 자주 탐험하고,\n나섬이와 캠퍼스 도감을 수집하는\n배재대학교형 스마트캠퍼스 앱',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.6,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    '배재Pick 시작하기',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Campus Quest · CityBrain · Nasumi Collection',
                style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 28, 22, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Nasumi(size: 56, label: 'P'),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '배재Pick',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'Smart Campus Quest',
                        style: TextStyle(color: AppColors.sub, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 34),
              const Text(
                '오늘의 캠퍼스를\nPick 해보세요.',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '학교 이메일 인증 기반으로 시작하는\n배재대학교 학생용 스마트캠퍼스 앱입니다.',
                style: TextStyle(
                  color: AppColors.sub,
                  fontSize: 15,
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 28),
              const AppInput(label: '학교 이메일', hint: 'example@pcu.ac.kr'),
              const SizedBox(height: 14),
              const AppInput(label: '비밀번호', hint: '비밀번호 입력', obscure: true),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainShell()),
                    );
                  },
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 58,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.blue,
                    side: const BorderSide(color: AppColors.blue, width: 1.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainShell()),
                    );
                  },
                  child: const Text(
                    '이메일 인증 후 시작하기',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const PrivacyGuideScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.privacy_tip_outlined),
                  label: const Text(
                    '개인정보 및 로컬 저장 안내 보기',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const AppCard(
                child: Row(
                  children: [
                    Icon(Icons.verified_user_outlined, color: AppColors.green),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'v0.2에서는 로그인/이메일 인증 UI mock만 제공합니다. 실제 인증은 Firebase 또는 Supabase 연동 단계에서 구현합니다.',
                        style: TextStyle(
                          color: AppColors.sub,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppInput extends StatelessWidget {
  final String label;
  final String hint;
  final bool obscure;

  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.sub),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: AppColors.blue, width: 1.6),
            ),
          ),
        ),
      ],
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  final pages = const [
    HomeScreen(),
    SmartMobilityHubScreen(),
    CollectionScreen(),
    ClubScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        height: 72,
        selectedIndex: index,
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route),
            label: '스마트맵',
          ),
          NavigationDestination(
            icon: Icon(Icons.collections_bookmark_outlined),
            selectedIcon: Icon(Icons.collections_bookmark),
            label: '도감',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign),
            label: '동아리',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '마이',
          ),
        ],
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsets padding;

  const AppCard({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(18),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class Nasumi extends StatelessWidget {
  final double size;
  final String label;

  const Nasumi({
    super.key,
    this.size = 72,
    this.label = 'P',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFFFB84D),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellow.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: size * 0.13,
            child: Text(
              '|||',
              style: TextStyle(
                fontSize: size * 0.24,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF7C2D12),
                letterSpacing: -4,
              ),
            ),
          ),
          Positioned(top: size * 0.40, left: size * 0.28, child: _eye(size)),
          Positioned(top: size * 0.40, right: size * 0.28, child: _eye(size)),
          Positioned(
            bottom: size * 0.22,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: size * 0.12, vertical: size * 0.04),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: size * 0.16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _eye(double size) {
    return Container(
      width: size * 0.08,
      height: size * 0.08,
      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(title: '안녕하세요, 영준님 👋', subtitle: '오늘도 캠퍼스 탐험 준비됐나요?'),
          const SizedBox(height: 20),
          AppCard(
            color: AppColors.blue,
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('오늘의 Pick', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800)),
                      SizedBox(height: 8),
                      Text('도서관 나섬이 출현 중!', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
                      SizedBox(height: 6),
                      Text('도서관 2층 열람실 · 남은 시간 02:13:45', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                const Nasumi(size: 92, label: '책'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(child: CafeteriaMiniCard()),
              SizedBox(width: 12),
              Expanded(child: MissionMiniCard()),
            ],
          ),
          const SizedBox(height: 16),
          const SmartMobilityPreviewCard(),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'QR·코드 미션',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                const Text(
                  '건물이나 행사 현장에서 받은 코드를 입력하고 나섬이 카드를 수집하세요.',
                  style: TextStyle(
                    color: AppColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.darkBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MissionCodeScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.qr_code_2),
                    label: const Text(
                      '미션 코드 입력하기',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          AppCard(
            color: const Color(0xFFFFFBEB),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '학과 나섬이 투어',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                const Text(
                  '학과 건물을 돌아다니며 학과별 나섬이를 수집하고 캠퍼스 구조를 익혀보세요.',
                  style: TextStyle(
                    color: AppColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DepartmentNasumiTourScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.school),
                    label: const Text(
                      '학과 나섬이 보러가기',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle(title: '캠퍼스 참여 허브', action: '전체 보기'),
          const SizedBox(height: 12),
              const SizedBox(height: 14),
              AppCard(
                color: AppColors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '배재 팀링크',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '공모전 공지와 팀원 모집을 역할 중심으로 연결합니다.',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w700,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const TeamLinkScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.groups_2_outlined),
                        label: const Text(
                          '배재 팀링크 열기',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          const ClubCard(title: '오늘 모집 중인 참여 공고', category: '동아리 · 프로젝트 · 행사 모집', deadline: 'D-3', place: '캠퍼스 참여 허브'),
          const SizedBox(height: 10),
          const ClubCard(title: '배재 방송국', category: '방송 · 영상 제작', deadline: 'D-7', place: '방송센터'),
          const SizedBox(height: 24),
          const SectionTitle(title: '도감 완성도'),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('37%', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppColors.blue)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.37,
                  backgroundColor: Colors.grey.shade200,
                  color: AppColors.yellow,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(999),
                ),
                const SizedBox(height: 10),
                const Text('45 / 120 카드 수집 완료', style: TextStyle(color: AppColors.sub, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CafeteriaMiniCard extends StatelessWidget {
  const CafeteriaMiniCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const CafeteriaDetailScreen(),
          ),
        );
      },
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('학생식당', style: TextStyle(fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            const Text('오늘 메뉴', style: TextStyle(color: AppColors.sub, fontSize: 12)),
            const SizedBox(height: 2),
            const Text('돈육폭찹 정식', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.green.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: const Text('혼잡도 보통', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}


class CafeteriaDetailScreen extends StatefulWidget {
  const CafeteriaDetailScreen({super.key});

  @override
  State<CafeteriaDetailScreen> createState() => _CafeteriaDetailScreenState();
}

class _CafeteriaDetailScreenState extends State<CafeteriaDetailScreen> {
  String selectedFeedback = '';
  bool menuCardSaved = false;

  final String menuCardTitle = '돈육폭찹 정식 카드';

  @override
  void initState() {
    super.initState();
    loadMenuCardState();
  }

  Future<void> loadMenuCardState() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList('collected_cards') ?? [];
    setState(() {
      menuCardSaved = current.contains(menuCardTitle);
    });
  }

  Future<void> acquireMenuCard() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList('collected_cards') ?? [];

    if (!current.contains(menuCardTitle)) {
      current.add(menuCardTitle);
      await prefs.setStringList('collected_cards', current);
    }

    setState(() {
      menuCardSaved = true;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('돈육폭찹 정식 카드를 획득했습니다.'),
      ),
    );
  }

  String congestionStatus() {
    final now = DateTime.now();
    final minutes = now.hour * 60 + now.minute;

    final startLunch = 11 * 60 + 30;
    final peakStart = 12 * 60;
    final peakEnd = 12 * 60 + 40;
    final lateLunch = 13 * 60 + 10;

    if (minutes < startLunch) return '준비 중';
    if (minutes >= peakStart && minutes <= peakEnd) return '혼잡';
    if (minutes <= lateLunch) return '보통';
    return '여유';
  }

  Color congestionColor(String status) {
    switch (status) {
      case '혼잡':
        return AppColors.red;
      case '보통':
        return AppColors.orange;
      case '여유':
        return AppColors.green;
      default:
        return AppColors.sub;
    }
  }

  String waitingTime(String status) {
    switch (status) {
      case '혼잡':
        return '약 12~15분';
      case '보통':
        return '약 5~7분';
      case '여유':
        return '거의 없음';
      default:
        return '운영 전';
    }
  }

  String recommendedTime(String status) {
    switch (status) {
      case '혼잡':
        return '12:40 이후 방문 추천';
      case '보통':
        return '지금 방문 가능';
      case '여유':
        return '지금 바로 방문 추천';
      default:
        return '11:30 이후 확인';
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = congestionStatus();
    final color = congestionColor(status);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Header(
                      title: '학생식당',
                      subtitle: '오늘 메뉴와 혼잡도를 확인하세요.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppCard(
                color: AppColors.blue,
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '오늘의 학생식당',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '돈육폭찹 정식',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '운영 시간 11:30 ~ 13:30',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const Nasumi(size: 92, label: '식당'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '현재 혼잡도',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: color,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            '예상 대기 시간: ${waitingTime(status)}',
                            style: const TextStyle(
                              color: AppColors.sub,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.green.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        recommendedTime(status),
                        style: const TextStyle(
                          color: AppColors.green,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '오늘 메뉴 정보',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 14),
                    const ProfileRow(label: '메뉴', value: '돈육폭찹 정식'),
                    const ProfileRow(label: '예상 가격', value: '학생식당 기준'),
                    const ProfileRow(label: '메뉴 카드', value: '획득 가능'),
                    const ProfileRow(label: '식당 나섬이', value: '출현 중'),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: menuCardSaved ? AppColors.green : AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: menuCardSaved ? null : acquireMenuCard,
                        icon: Icon(menuCardSaved ? Icons.check_circle : Icons.collections_bookmark),
                        label: Text(
                          menuCardSaved ? '메뉴 카드 획득 완료' : '오늘의 메뉴 카드 받기',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '메뉴 만족도',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'v0.5에서는 서버 저장 없이 화면 상태만 반영합니다. 이후 익명 집계 방식으로 확장할 수 있습니다.',
                      style: TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        feedbackChip('맛있어요'),
                        feedbackChip('보통이에요'),
                        feedbackChip('아쉬워요'),
                        feedbackChip('줄이 길어요'),
                        feedbackChip('다시 먹고 싶어요'),
                      ],
                    ),
                    if (selectedFeedback.isNotEmpty) ...[
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.blue.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '선택한 의견: $selectedFeedback',
                          style: const TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: const Color(0xFFFFFBEB),
                child: Row(
                  children: const [
                    Icon(Icons.lightbulb_outline, color: AppColors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '학생식당은 배재Pick을 매일 열게 만드는 핵심 진입점입니다. 이후 CityBrain API와 연결해 실제 혼잡도와 운영 데이터를 반영할 수 있습니다.',
                        style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget feedbackChip(String label) {
    final selected = selectedFeedback == label;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w900,
          color: selected ? Colors.white : AppColors.text,
        ),
      ),
      selected: selected,
      selectedColor: AppColors.blue,
      onSelected: (_) {
        setState(() {
          selectedFeedback = label;
        });
      },
    );
  }
}

class MissionMiniCard extends StatelessWidget {
  const MissionMiniCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('오늘의 미션', style: TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          const Text('배재관 QR 찾기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: 0.33,
            backgroundColor: Colors.grey.shade200,
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(999),
          ),
          const SizedBox(height: 8),
          const Text('1 / 3 완료', style: TextStyle(color: AppColors.sub, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class CampusMapScreen extends StatelessWidget {
  const CampusMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(title: '3D 캠퍼스맵', subtitle: '건물, 미션, 나섬이, 학생식당, 흡연구역을 한눈에 확인하세요.'),
          const SizedBox(height: 16),
          Expanded(
            child: AppCard(
              padding: const EdgeInsets.all(14),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCEBFA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const Positioned(left: 22, top: 22, child: MapBuilding(label: '배재관', color: AppColors.orange, width: 120, height: 90)),
                  const Positioned(right: 26, top: 40, child: MapBuilding(label: '정보과학관', color: AppColors.blue, width: 110, height: 110)),
                  const Positioned(left: 64, bottom: 120, child: MapBuilding(label: '학생식당', color: AppColors.green, width: 130, height: 70)),
                  const Positioned(right: 58, bottom: 90, child: MapBuilding(label: '도서관', color: AppColors.purple, width: 125, height: 85)),
                  const Positioned(left: 190, top: 210, child: Nasumi(size: 58, label: '책')),
                  Positioned(
                    left: 18,
                    bottom: 18,
                    right: 18,
                    child: AppCard(
                      color: Colors.white.withValues(alpha: 0.94),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('도서관 나섬이', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                          SizedBox(height: 4),
                          Text('Rare · 도서관 2층 열람실 · 남은 시간 01:42:10', style: TextStyle(color: AppColors.sub, fontWeight: FontWeight.w600)),
                          SizedBox(height: 12),
                          Text('위치 보기', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w900)),
                        ],
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
}

class MapBuilding extends StatelessWidget {
  final String label;
  final Color color;
  final double width;
  final double height;

  const MapBuilding({
    super.key,
    required this.label,
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.15,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.35), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
      ),
    );
  }
}

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = [
      ['도서관 나섬이', 'Rare', true],
      ['학생식당 나섬이', 'Common', false],
      ['배재관 장소 카드', 'Common', true],
      ['축제 나섬이', 'Limited', false],
      ['IT관 개발자 나섬이', 'Rare', true],
      ['운동장 러너 나섬이', 'Common', false],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(title: '캠퍼스 도감', subtitle: '완성도 37% · 45 / 120'),
          const SizedBox(height: 18),
          GridView.builder(
            itemCount: cards.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.82,
            ),
            itemBuilder: (context, index) {
              final card = cards[index];
              final owned = card[2] as bool;
              return AppCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    owned
                        ? const Nasumi(size: 86, label: 'P')
                        : Container(
                            width: 86,
                            height: 86,
                            decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle),
                            child: const Icon(Icons.lock, color: Colors.white),
                          ),
                    const SizedBox(height: 14),
                    Text(card[0] as String, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    Text(card[1] as String, style: TextStyle(color: owned ? AppColors.blue : AppColors.sub, fontWeight: FontWeight.w800)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}


class DepartmentNasumiTourScreen extends StatelessWidget {
  const DepartmentNasumiTourScreen({super.key});

  final List<Map<String, String>> departments = const [
    {
      'name': '컴퓨터공학과 나섬이',
      'code': 'CS-NASUMI',
      'building': '정보과학관',
      'desc': '코딩, 시스템, 앱, 임베디드에 관심 있는 학생들을 위한 학과 나섬이입니다.',
      'office': '학과 사무실은 건물 안내 또는 학과 홈페이지를 참고하세요.',
    },
    {
      'name': '인공지능학과 나섬이',
      'code': 'AI-NASUMI',
      'building': '정보과학관',
      'desc': 'AI, 데이터, 모델링에 관심 있는 학생들을 위한 학과 나섬이입니다.',
      'office': '학과 사무실/연구실 위치는 공식 안내 기준으로 확인합니다.',
    },
    {
      'name': '게임공학과 나섬이',
      'code': 'GAME-NASUMI',
      'building': '콘텐츠 관련 건물',
      'desc': '게임, 그래픽, 인터랙티브 콘텐츠를 좋아하는 학생들을 위한 나섬이입니다.',
      'office': '정확한 위치는 학과 공식 안내를 따릅니다.',
    },
    {
      'name': '경영학과 나섬이',
      'code': 'BUSINESS-NASUMI',
      'building': '경영 관련 건물',
      'desc': '기획, 마케팅, 창업, 운영에 관심 있는 학생들을 위한 나섬이입니다.',
      'office': '학과 사무실 위치는 공식 안내를 따릅니다.',
    },
    {
      'name': '관광축제한류대학 나섬이',
      'code': 'TOURISM-NASUMI',
      'building': '관광축제한류대학 관련 건물',
      'desc': '축제, 관광, 한류 콘텐츠를 좋아하는 학생들을 위한 나섬이입니다.',
      'office': '학과 사무실 위치는 공식 안내를 따릅니다.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 4),
                  const Expanded(
                    child: Header(
                      title: '학과 나섬이 투어',
                      subtitle: '학과 건물을 탐험하고 나섬이를 수집하세요.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '캠퍼스 공간 학습',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '다른 학과 건물을\n돌아볼 명분을 만듭니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '신입생, 통학생, 기숙사생 모두에게 필요한 캠퍼스 탐험 기능입니다.',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 92, label: '학과'),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              AppCard(
                color: const Color(0xFFFFFBEB),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: AppColors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'v0.7은 실시간 위치 추적 없이 코드 입력 기반으로 동작합니다. 학생 이동 동선은 서버에 저장하지 않습니다.',
                        style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const SectionTitle(title: '수집 가능한 학과 나섬이'),
              const SizedBox(height: 12),
              ...departments.map((department) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DepartmentCard(department: department),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class DepartmentCard extends StatelessWidget {
  final Map<String, String> department;

  const DepartmentCard({
    super.key,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final name = department['name']!;
    final code = department['code']!;
    final building = department['building']!;
    final desc = department['desc']!;
    final office = department['office']!;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Nasumi(size: 64, label: '학과'),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 4),
                    Text(building, style: const TextStyle(color: AppColors.sub, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            desc,
            style: const TextStyle(color: AppColors.sub, fontWeight: FontWeight.w700, height: 1.5),
          ),
          const SizedBox(height: 10),
          Text(
            office,
            style: const TextStyle(color: AppColors.sub, fontWeight: FontWeight.w600, height: 1.5),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.blue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '수집 코드: $code',
              style: const TextStyle(color: AppColors.blue, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const MissionCodeScreen()),
                );
              },
              icon: const Icon(Icons.qr_code_2),
              label: const Text(
                '코드 입력하러 가기',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClubScreen extends StatelessWidget {
  const ClubScreen({super.key});

  static const List<Map<String, String>> clubs = [
    {
      'title': '크로우즈',
      'category': '야구 · 스포츠 · 친목',
      'deadline': 'D-7',
      'place': '운동장 / 캠퍼스',
      'period': '상시 모집 mock',
      'target': '야구와 스포츠 활동에 관심 있는 재학생',
      'day': '추후 공지',
      'beginner': '가능',
      'skills': '참여 의지, 팀 활동 관심',
      'intro': '크로우즈는 스포츠 활동과 팀 문화를 중심으로 운영되는 캠퍼스 동아리입니다. 실제 모집 정보는 운영진 확인 후 업데이트가 필요합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '프리마',
      'category': '공연 · 문화 · 예술',
      'deadline': 'D-9',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '공연과 문화 활동에 관심 있는 재학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '성실한 참여, 문화 활동 관심',
      'intro': '프리마 동아리의 모집 공고 mock입니다. 실제 활동 분야와 모집 조건은 동아리 운영진 확인이 필요합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '플레이어',
      'category': '게임 · 콘텐츠 · 취미',
      'deadline': 'D-10',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '게임, 콘텐츠, 취미 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '팀 활동 관심',
      'intro': '플레이어 동아리의 모집 공고 mock입니다. 실제 세부 활동은 확인 후 업데이트합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '한울회',
      'category': '봉사 · 교류 · 캠퍼스 활동',
      'deadline': 'D-12',
      'place': '캠퍼스',
      'period': '상시 모집 mock',
      'target': '봉사와 교류 활동에 관심 있는 재학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '책임감, 꾸준한 참여',
      'intro': '한울회 동아리의 모집 공고 mock입니다. 실제 모집 정보는 운영진 확인이 필요합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': 'ABIS',
      'category': '학술 · 전공 · 스터디',
      'deadline': 'D-14',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '전공 학습과 스터디 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '학습 의지, 협업',
      'intro': 'ABIS 동아리의 모집 공고 mock입니다. 실제 분야와 활동 내용은 확인 후 반영합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': 'CCC',
      'category': '종교 · 봉사 · 캠퍼스 모임',
      'deadline': 'D-15',
      'place': '캠퍼스',
      'period': '상시 모집 mock',
      'target': '캠퍼스 모임과 봉사 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '참여 의지',
      'intro': 'CCC 동아리의 모집 공고 mock입니다. 실제 활동 내용은 운영진 확인이 필요합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': 'DFC',
      'category': '스포츠 · 취미 · 활동',
      'deadline': 'D-16',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '활동형 동아리에 관심 있는 재학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '성실한 참여',
      'intro': 'DFC 동아리의 모집 공고 mock입니다. 실제 세부 정보는 확인 후 업데이트합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': 'M.A.C',
      'category': '문화 · 예술 · 취미',
      'deadline': 'D-18',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '문화 활동에 관심 있는 재학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '참여 의지',
      'intro': 'M.A.C 동아리의 모집 공고 mock입니다. 실제 활동 분야는 확인 후 반영합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': 'oao/농구',
      'category': '농구 · 스포츠',
      'deadline': 'D-5',
      'place': '체육 시설 / 운동장',
      'period': '상시 모집 mock',
      'target': '농구와 스포츠 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '운동 참여, 팀워크',
      'intro': 'oao/농구 동아리의 모집 공고 mock입니다. 실제 활동 요일과 장소 확인이 필요합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': 'VOLLEY',
      'category': '배구 · 스포츠',
      'deadline': 'D-6',
      'place': '체육 시설 / 운동장',
      'period': '상시 모집 mock',
      'target': '배구와 스포츠 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '운동 참여, 팀워크',
      'intro': 'VOLLEY 동아리의 모집 공고 mock입니다. 실제 모집 정보는 운영진 확인이 필요합니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '신선놀음',
      'category': '취미 · 문화 · 친목',
      'deadline': 'D-20',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '취미와 친목 활동에 관심 있는 재학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '참여 의지',
      'intro': '신선놀음 동아리의 모집 공고 mock입니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '야생마',
      'category': '스포츠 · 활동',
      'deadline': 'D-21',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '활동형 동아리에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '활동성, 팀워크',
      'intro': '야생마 동아리의 모집 공고 mock입니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '오선회',
      'category': '문화 · 취미 · 교류',
      'deadline': 'D-22',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '문화와 교류 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '참여 의지',
      'intro': '오선회 동아리의 모집 공고 mock입니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '위더스',
      'category': '봉사 · 서포터즈 · 교류',
      'deadline': 'D-23',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '봉사와 교류 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '책임감, 성실함',
      'intro': '위더스 동아리의 모집 공고 mock입니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '저거넛',
      'category': '농구 · 스포츠',
      'deadline': 'D-8',
      'place': '체육 시설 / 운동장',
      'period': '상시 모집 mock',
      'target': '농구와 팀 스포츠에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '운동 참여, 팀워크',
      'intro': '저거넛 동아리의 모집 공고 mock입니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '청춘',
      'category': '문화 · 친목 · 캠퍼스 활동',
      'deadline': 'D-24',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '캠퍼스 활동에 관심 있는 재학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '참여 의지',
      'intro': '청춘 동아리의 모집 공고 mock입니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
    {
      'title': '체나',
      'category': '문화 · 취미',
      'deadline': 'D-25',
      'place': '캠퍼스',
      'period': '모집 기간 확인 필요',
      'target': '문화 활동에 관심 있는 학생',
      'day': '확인 필요',
      'beginner': '가능',
      'skills': '참여 의지',
      'intro': '체나 동아리의 모집 공고 mock입니다.',
      'apply': 'Apply link mock',
      'contact': 'Club contact mock',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header(
            title: '캠퍼스 참여 허브',
            subtitle: '동아리·행사·프로젝트 모집을 한곳에 모으는 참여 공고관입니다.',
          ),
          const SizedBox(height: 18),
          AppCard(
            color: const Color(0xFFEFF6FF),
            child: Row(
              children: const [
                Icon(Icons.campaign_outlined, color: AppColors.blue),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '캠퍼스 참여 허브는 행사를 직접 주최하지 않고, 모집·행사·프로젝트 참여 정보를 구조화해 보여주는 인프라입니다.',
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          AppCard(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '동아리 운영진인가요?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  '공고 등록 요청 mock으로 동아리 모집 공고 등록 흐름을 테스트할 수 있습니다.',
                  style: TextStyle(
                    color: AppColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.darkBlue,
                      side: const BorderSide(color: AppColors.darkBlue, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ClubNoticeSubmitMockScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.post_add_outlined),
                    label: const Text(
                      '공고 등록 요청',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '참여 유형',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                const Text(
                  '초기에는 동아리 모집부터 시작하고, 이후 학과 행사·프로젝트 팀원 모집·봉사·서포터즈 공고까지 확장할 수 있습니다.',
                  style: TextStyle(
                    color: AppColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(label: Text('동아리 모집')),
                    Chip(label: Text('학과/부서 행사')),
                    Chip(label: Text('프로젝트 팀원')),
                    Chip(label: Text('봉사/서포터즈')),
                    Chip(label: Text('공모전 팀원')),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.darkBlue,
                      side: const BorderSide(color: AppColors.darkBlue, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ParticipationTypeGuideScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.category_outlined),
                    label: const Text(
                      '참여 공고 유형 보기',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            color: AppColors.darkBlue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '운영 원칙',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '배재Pick은 행사를 주최하지 않습니다. 공고 등록, 노출, 관심 저장, 신청 흐름을 보조하는 참여 인프라입니다.',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '공고 상태 라벨',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  '공식 승인, 주최 측 등록, 검토 중, 모집 마감 등을 구분해 공고 신뢰도를 명확히 표시합니다.',
                  style: TextStyle(
                    color: AppColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.darkBlue,
                      side: const BorderSide(color: AppColors.darkBlue, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ParticipationStatusGuideScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.verified_outlined),
                    label: const Text(
                      '공고 상태 라벨 보기',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          AppCard(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '필터 / 마감 임박',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                const Text(
                  '공고가 많아질수록 유형별 필터와 마감 임박 정렬이 필요합니다.',
                  style: TextStyle(
                    color: AppColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    Chip(label: Text('전체')),
                    Chip(label: Text('동아리')),
                    Chip(label: Text('행사')),
                    Chip(label: Text('프로젝트')),
                    Chip(label: Text('마감 임박')),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.darkBlue,
                      side: const BorderSide(color: AppColors.darkBlue, width: 1.2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ParticipationFilterGuideScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                    label: const Text(
                      '참여 허브 필터 보기',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          ...clubs.map((club) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ClubCard(
                title: club['title']!,
                category: club['category']!,
                deadline: club['deadline']!,
                place: club['place']!,
                club: club,
              ),
            );
          }),
        ],
      ),
    );
  }
}


class ClubNoticeSubmitMockScreen extends StatefulWidget {
  const ClubNoticeSubmitMockScreen({super.key});

  @override
  State<ClubNoticeSubmitMockScreen> createState() => _ClubNoticeSubmitMockScreenState();
}

class _ClubNoticeSubmitMockScreenState extends State<ClubNoticeSubmitMockScreen> {
  final clubNameController = TextEditingController();
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final contactController = TextEditingController();
  final descController = TextEditingController();

  String selectedType = '정기 모집';

  @override
  void dispose() {
    clubNameController.dispose();
    titleController.dispose();
    categoryController.dispose();
    contactController.dispose();
    descController.dispose();
    super.dispose();
  }

  void submitMock() {
    final clubName = clubNameController.text.trim();
    final title = titleController.text.trim();

    if (clubName.isEmpty || title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('동아리명과 공고 제목은 필수입니다.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('공고 등록 요청 완료'),
        content: Text(
          '$clubName 공고가 등록 요청 mock으로 접수되었습니다.\n\n'
          '실제 출시 전에는 관리자 승인 후 공고관에 노출되는 구조가 필요합니다.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  Widget field({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final types = ['정기 모집', '프로젝트 모집', '행사 스태프', '신입 부원 모집', '기타'];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '동아리 공고 등록 요청',
                subtitle: '익명 게시판이 아닌 공고형 모집 구조를 테스트합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Notice Submit Mock',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '동아리 운영진이\n공고를 요청하는 흐름',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '현재는 서버 저장 없이 화면 흐름만 검증합니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '공고'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '등록 요청 정보',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    field(
                      label: '동아리명',
                      hint: '예: SkyEdge',
                      controller: clubNameController,
                    ),
                    field(
                      label: '공고 제목',
                      hint: '예: 드론/임베디드 프로젝트 팀원 모집',
                      controller: titleController,
                    ),
                    field(
                      label: '분야',
                      hint: '예: 드론 · ROS2 · PX4',
                      controller: categoryController,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: DropdownButtonFormField<String>(
                        initialValue: selectedType,
                        items: types
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() => selectedType = value);
                        },
                        decoration: InputDecoration(
                          labelText: '모집 유형',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    field(
                      label: '연락 방법',
                      hint: '예: 인스타 DM, 오픈채팅, 대표 연락처',
                      controller: contactController,
                    ),
                    field(
                      label: '공고 설명',
                      hint: '모집 대상, 활동 내용, 초보 가능 여부 등을 적어주세요.',
                      controller: descController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: submitMock,
                        icon: const Icon(Icons.send_outlined),
                        label: const Text(
                          '공고 등록 요청 mock',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '운영 원칙',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '이 기능은 자유 익명 게시판이 아니라 동아리 모집 정보를 구조화해서 보여주는 공고관을 목표로 합니다. 실제 출시 전에는 관리자 승인, 학교 이메일 인증, 동아리 대표 권한 확인이 필요합니다.',
                      style: TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ClubDetailScreen extends StatefulWidget {
  final Map<String, String> club;

  const ClubDetailScreen({
    super.key,
    required this.club,
  });

  @override
  State<ClubDetailScreen> createState() => _ClubDetailScreenState();
}

class _ClubDetailScreenState extends State<ClubDetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavorite();
  }

  Future<void> loadFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_clubs') ?? [];
    setState(() {
      isFavorite = favorites.contains(widget.club['title']);
    });
  }

  Future<void> toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorite_clubs') ?? [];
    final title = widget.club['title']!;

    if (favorites.contains(title)) {
      favorites.remove(title);
    } else {
      favorites.add(title);
    }

    await prefs.setStringList('favorite_clubs', favorites);

    setState(() {
      isFavorite = favorites.contains(title);
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isFavorite ? '$title 관심 동아리에 저장했습니다.' : '$title 관심 동아리에서 제거했습니다.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final club = widget.club;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              AppCard(
                color: AppColors.blue,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '모집 중',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            club['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            club['category']!,
                            style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    const Nasumi(size: 88, label: '동아리'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('모집 정보', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 12),
                    ProfileRow(label: '모집 기간', value: club['period']!),
                    ProfileRow(label: '모집 대상', value: club['target']!),
                    ProfileRow(label: '활동 장소', value: club['place']!),
                    ProfileRow(label: '활동 요일', value: club['day']!),
                    ProfileRow(label: '초보 가능', value: club['beginner']!),
                    ProfileRow(label: '필요 역량', value: club['skills']!),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('동아리 소개', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 10),
                    Text(
                      club['intro']!,
                      style: const TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: const Color(0xFFFFFBEB),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: AppColors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'v0.8에서는 실제 외부 링크 대신 mock 링크로 표시합니다. 실제 출시 전에는 동아리 대표 또는 관리자 승인 방식이 필요합니다.',
                        style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: isFavorite ? AppColors.green : AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: toggleFavorite,
                  icon: Icon(isFavorite ? Icons.check_circle : Icons.bookmark_add),
                  label: Text(
                    isFavorite ? '관심 동아리 저장됨' : '관심 동아리 저장',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.blue,
                    side: const BorderSide(color: AppColors.blue, width: 1.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('지원 링크: ${club['apply']}')),
                    );
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text(
                    '지원 링크 열기 mock',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.darkBlue,
                    side: const BorderSide(color: AppColors.darkBlue, width: 1.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('문의 링크: ${club['contact']}')),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text(
                    '문의 링크 열기 mock',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  int favoriteClubCount = 0;
  int collectedCardCount = 0;

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteClubCount = (prefs.getStringList('favorite_clubs') ?? []).length;
      collectedCardCount = (prefs.getStringList('collected_cards') ?? []).length;
    });
  }

  Future<void> resetLocalData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('favorite_clubs');
    await prefs.remove('collected_cards');

    await loadStats();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('로컬 저장 데이터를 초기화했습니다.'),
      ),
    );
  }

  Future<void> confirmReset() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('로컬 데이터 초기화'),
          content: const Text(
            '이 기기에 저장된 도감 카드와 관심 동아리 정보가 삭제됩니다. 서버 데이터는 사용하지 않으므로 현재는 이 기기에서만 초기화됩니다.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('초기화'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      await resetLocalData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      child: Column(
        children: [
          const Nasumi(size: 96, label: 'P'),
          const SizedBox(height: 14),
          const Text('영준', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          const Text('컴퓨터공학과 · 캠퍼스 탐험가', style: TextStyle(color: AppColors.sub, fontWeight: FontWeight.w700)),
          const SizedBox(height: 24),
          AppCard(
            child: Column(
              children: [
                const ProfileRow(label: '도감 완성도', value: '로컬 기준'),
                ProfileRow(label: '로컬 획득 카드', value: '$collectedCardCount개'),
                const ProfileRow(label: '완료 미션', value: '코드 기반'),
                const ProfileRow(label: '대표 칭호', value: '신입 탐험가'),
                ProfileRow(label: '관심 동아리', value: '$favoriteClubCount개'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.blue,
                side: const BorderSide(color: AppColors.blue, width: 1.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: loadStats,
              icon: const Icon(Icons.refresh),
              label: const Text(
                '로컬 상태 새로고침',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.darkBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PrivacyGuideScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.privacy_tip_outlined),
              label: const Text(
                '개인정보 / 로컬 저장 안내',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.red,
                side: const BorderSide(color: AppColors.red, width: 1.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: confirmReset,
              icon: const Icon(Icons.delete_outline),
              label: const Text(
                '로컬 데이터 초기화',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






class ParticipationFilterGuideScreen extends StatelessWidget {
  const ParticipationFilterGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      {
        'title': '전체',
        'desc': '현재 노출 가능한 모든 참여 공고를 보여줍니다.',
      },
      {
        'title': '동아리 모집',
        'desc': '정규 동아리, 프로젝트형 동아리, 학과 소모임 모집 공고입니다.',
      },
      {
        'title': '학과/부서 행사',
        'desc': '특강, 설명회, 학과 행사, 체험 부스 공고입니다.',
      },
      {
        'title': '프로젝트 팀원',
        'desc': '앱 개발, 연구, 창업, 전공 프로젝트 팀원 모집 공고입니다.',
      },
      {
        'title': '봉사/서포터즈',
        'desc': '행사 스태프, 봉사, 홍보단, 서포터즈 모집 공고입니다.',
      },
      {
        'title': '마감 임박',
        'desc': '모집 마감이 가까운 공고를 우선 보여줍니다.',
      },
    ];

    final sortRules = [
      '마감 임박 공고를 상단에 표시',
      '노출 중 상태만 기본 목록에 표시',
      '모집 마감 공고는 별도 영역으로 이동',
      '정보 확인 필요/검토 중 공고는 일반 학생에게 노출하지 않음',
      '숨김 처리 공고는 목록에서 제외',
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '참여 허브 필터',
                subtitle: '학생이 지금 참여 가능한 공고를 빠르게 찾게 합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Filter / Deadline',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '공고가 많아질수록\n필터와 마감 정렬이 핵심',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '캠퍼스 참여 허브는 게시판이 아니라 찾기 쉬운 모집 인프라여야 합니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '필터'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '필터 유형',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    ...filters.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ProfileRow(
                          label: filter['title']!,
                          value: filter['desc']!,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '정렬 / 노출 규칙',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    ...sortRules.map(
                      (rule) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_outline, size: 19, color: AppColors.blue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                rule,
                                style: const TextStyle(
                                  color: AppColors.sub,
                                  fontWeight: FontWeight.w700,
                                  height: 1.45,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: AppColors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '제품 원칙',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '학생은 게시글을 뒤지는 게 아니라, 지금 참여 가능한 공고를 바로 찾아야 합니다.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ParticipationStatusGuideScreen extends StatelessWidget {
  const ParticipationStatusGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final statuses = [
      {
        'title': '주최 측 등록',
        'desc': '동아리·학과·프로젝트 운영진이 직접 등록 요청한 상태입니다.',
        'risk': '아직 앱 운영자가 내용을 확인하지 않았습니다.',
      },
      {
        'title': '정보 확인 필요',
        'desc': '장소, 기간, 문의 채널, 담당자 정보가 부족한 상태입니다.',
        'risk': '학생에게 노출하기 전 추가 확인이 필요합니다.',
      },
      {
        'title': '검토 중',
        'desc': '앱 운영자 또는 담당자가 공고 내용을 확인하는 상태입니다.',
        'risk': '공식 승인과는 다르며, 정보 품질 확인 단계입니다.',
      },
      {
        'title': '노출 중',
        'desc': '학생들이 볼 수 있는 공고 상태입니다.',
        'risk': '행사 운영 책임은 주최 단체에 있습니다.',
      },
      {
        'title': '모집 마감',
        'desc': '모집 기간이 끝났거나 주최 측이 마감을 요청한 상태입니다.',
        'risk': '신청 버튼은 비활성화되어야 합니다.',
      },
      {
        'title': '숨김 처리',
        'desc': '정보 오류, 민원, 운영 문제 등으로 임시 비노출된 상태입니다.',
        'risk': '분쟁 판단이 아니라 공고 노출 중단 조치입니다.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '공고 상태 라벨',
                subtitle: '공식 승인과 단순 등록을 명확히 구분합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status Labels',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '공고의 신뢰도를\n상태값으로 구분',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '앱은 공식 승인 여부를 과장하지 않고, 등록/확인/노출 상태를 분리합니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '상태'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...statuses.map((status) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status['title']!,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          status['desc']!,
                          style: const TextStyle(
                            color: AppColors.sub,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ProfileRow(label: '주의', value: status['risk']!),
                      ],
                    ),
                  ),
                );
              }),
              AppCard(
                color: AppColors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '핵심 원칙',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '확인됨은 공식 승인이 아니다. 공식성은 학교 또는 주최 단체가 책임진다.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ParticipationTypeGuideScreen extends StatelessWidget {
  const ParticipationTypeGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final types = [
      {
        'title': '동아리 모집',
        'desc': '정규 동아리, 학과 소모임, 프로젝트형 동아리의 부원 모집 공고입니다.',
        'owner': '동아리 대표 / 운영진',
        'risk': '대표자 확인, 모집 기간, 문의 채널 필요',
      },
      {
        'title': '학과/부서 행사',
        'desc': '학과 행사, 특강, 설명회, 체험 부스 등 참여자를 모집하는 공고입니다.',
        'owner': '학과 / 부서 / 주최자',
        'risk': '장소 확정, 담당자, 학교/부서 확인 필요',
      },
      {
        'title': '프로젝트 팀원 모집',
        'desc': '앱 개발, 공모전, 연구, 창업, 전공 프로젝트 팀원을 찾는 공고입니다.',
        'owner': '프로젝트 리더',
        'risk': '역할 분담, 기간, 결과물 기준 필요',
      },
      {
        'title': '봉사 / 서포터즈',
        'desc': '행사 운영 보조, 봉사 활동, 홍보단, 서포터즈 모집 공고입니다.',
        'owner': '주최 단체 / 담당자',
        'risk': '활동 시간, 장소, 안전 책임, 확인서 여부 필요',
      },
      {
        'title': '공모전 팀원',
        'desc': '대회·해커톤·아이디어 공모전 참가를 위한 팀원 모집 공고입니다.',
        'owner': '팀장 / 참가자',
        'risk': '마감일, 요구 역량, 제출물, 팀 규칙 필요',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '참여 공고 유형',
                subtitle: '캠퍼스 참여 허브가 다룰 수 있는 공고 구조입니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Participation Model',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '모든 참여 정보를\n같은 형식으로 정리',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '앱은 행사를 주최하지 않고, 공고 구조와 참여 흐름만 제공합니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '참여'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...types.map((type) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type['title']!,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          type['desc']!,
                          style: const TextStyle(
                            color: AppColors.sub,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ProfileRow(label: '주최/등록 주체', value: type['owner']!),
                        ProfileRow(label: '확인 필요', value: type['risk']!),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 4),
              AppCard(
                color: AppColors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '핵심 원칙',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '배재Pick은 공고를 구조화한다. 행사는 주최 단체가 운영한다.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class DepartmentFilterGuideScreen extends StatelessWidget {
  const DepartmentFilterGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      {
        'title': '전체',
        'body': '모든 학과를 한 번에 확인합니다.',
        'icon': Icons.apps_outlined,
      },
      {
        'title': '인문사회',
        'body': '경영, 행정, 심리, 항공서비스, 미디어 등 사람과 사회를 다루는 학과입니다.',
        'icon': Icons.groups_outlined,
      },
      {
        'title': '자연과학',
        'body': '간호, 식품, 생명, 보건 등 건강과 자연과학 기반 학과입니다.',
        'icon': Icons.biotech_outlined,
      },
      {
        'title': '공학',
        'body': '컴퓨터, AI, 보안, 전기, 건축, 로봇 등 기술 중심 학과입니다.',
        'icon': Icons.memory_outlined,
      },
      {
        'title': '예체능',
        'body': '웹툰, 디자인, 영상, 음악, 스포츠 등 창작과 실기를 다루는 학과입니다.',
        'icon': Icons.palette_outlined,
      },
      {
        'title': '평생교육',
        'body': '라이프스타일, 복지상담, 부동산, 시니어 운동 등 융합형 학습 분야입니다.',
        'icon': Icons.school_outlined,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '학과백과 필터',
                subtitle: '학과가 많아질수록 계열, 관심 분야, 건물 기준으로 빠르게 찾을 수 있어야 합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Department Browsing',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '긴 학과 목록을\n탐색 가능한 구조로',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '전체 목록은 유지하되, 계열 필터와 검색으로 학생의 탐색 비용을 줄입니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '검색'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...filters.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppCard(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.lightBlue,
                          child: Icon(
                            item['icon'] as IconData,
                            color: AppColors.blue,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item['body'] as String,
                                style: const TextStyle(
                                  color: AppColors.sub,
                                  fontWeight: FontWeight.w700,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              AppCard(
                color: AppColors.lightBlue,
                child: const Text(
                  '다음 단계에서는 실제 학과 리스트에 검색창과 계열 필터 칩을 연결합니다.',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class TeamLinkScreen extends StatelessWidget {
  const TeamLinkScreen({super.key});

  static const contests = [
    {
      'title': '스마트캠퍼스 아이디어 공모전',
      'field': '기획 / 앱 / 캠퍼스 문제 해결',
      'deadline': 'D-12',
      'organizer': '교내 공모전',
      'status': '모집 중',
      'roles': ['기획', '개발', '디자인', '발표'],
    },
    {
      'title': 'AI 활용 서비스 기획 공모전',
      'field': 'AI / 데이터 / 서비스 기획',
      'deadline': 'D-18',
      'organizer': '외부 공모전',
      'status': '팀 모집 가능',
      'roles': ['AI', '자료조사', '문서', '발표'],
    },
    {
      'title': '지역문제 해결 프로젝트',
      'field': '사회문제 / 데이터 / 정책 제안',
      'deadline': 'D-24',
      'organizer': '지자체 연계',
      'status': '마감 임박 아님',
      'roles': ['기획', '자료조사', '디자인', '대외 연락'],
    },
  ];

  static const teams = [
    {
      'name': '캠퍼스 생활 개선팀',
      'contest': '스마트캠퍼스 아이디어 공모전',
      'members': '2 / 4',
      'need': ['UI 디자인', '발표'],
      'desc': '학식, 동아리, 학과 정보를 앱으로 연결하는 아이디어를 준비 중입니다.',
      'status': '모집 중',
    },
    {
      'name': 'AI 자료조사팀',
      'contest': 'AI 활용 서비스 기획 공모전',
      'members': '1 / 3',
      'need': ['자료조사', '문서 작성'],
      'desc': 'AI 서비스를 공모전 제안서 형태로 정리할 팀원을 찾습니다.',
      'status': '일부 모집 완료',
    },
    {
      'name': '지역 데이터 분석팀',
      'contest': '지역문제 해결 프로젝트',
      'members': '3 / 5',
      'need': ['데이터 분석', '발표'],
      'desc': '지역 문제를 데이터로 분석하고 발표 자료까지 함께 만들 팀입니다.',
      'status': '모집 중',
    },
  ];

  static const roleTags = [
    '기획',
    '개발',
    '디자인',
    '발표',
    '자료조사',
    '문서',
    'AI',
    '데이터',
    '영상',
    '팀장',
    '하드웨어',
    '마케팅',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '배재 팀링크',
                subtitle: '공모전 공지와 팀원 모집을 역할 중심으로 연결합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TeamLink',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '혼자서도\n공모전 팀 찾기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '기획·개발·디자인·발표처럼 필요한 역할을 기준으로 팀원을 찾습니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '팀'),
                  ],
                ),
              ),
              AppCard(
                color: AppColors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '공식 공고 출처',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '공모전·프로그램 공지는 배재대학교 일반공지와 학과/부서 공지를 기준으로 확인합니다.',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w700,
                        height: 1.45,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '공식 공고와 학생 모집글은 반드시 구분해서 표시합니다.',
                      style: TextStyle(
                        color: AppColors.darkBlue,
                        fontWeight: FontWeight.w900,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Row(
                children: const [
                  Expanded(
                    child: _TeamLinkStatCard(
                      title: '공모전',
                      value: '3',
                      icon: Icons.emoji_events_outlined,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _TeamLinkStatCard(
                      title: '모집팀',
                      value: '3',
                      icon: Icons.groups_outlined,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _TeamLinkStatCard(
                      title: '역할',
                      value: '12',
                      icon: Icons.sell_outlined,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const CreateTeamRecruitmentMockScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text(
                    '팀 모집글 만들기',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.blue,
                    side: const BorderSide(color: AppColors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TeamLinkSafetyPolicyScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.verified_user_outlined),
                  label: const Text(
                    '팀링크 운영정책 보기',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 18),
              const Text(
                '역할 태그',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: roleTags
                    .map(
                      (role) => Chip(
                        backgroundColor: Colors.white,
                        label: Text(
                          role,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 22),
              const Text(
                '마감 임박 / 추천 공모전',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              ...contests.map((contest) {
                final roles = contest['roles'] as List<String>;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(
                              backgroundColor: AppColors.lightBlue,
                              label: Text(
                                contest['deadline'] as String,
                                style: const TextStyle(
                                  color: AppColors.darkBlue,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              contest['status'] as String,
                              style: const TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          contest['title'] as String,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          contest['field'] as String,
                          style: const TextStyle(
                            color: AppColors.sub,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 7,
                          runSpacing: 7,
                          children: roles.map((role) => Chip(label: Text(role))).toList(),
                        ),
                        const SizedBox(height: 10),
                        ProfileRow(label: '주관', value: contest['organizer'] as String),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 10),
              const Text(
                '팀원 모집',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 12),
              ...teams.map((team) {
                final need = team['need'] as List<String>;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: AppCard(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                team['name'] as String,
                                style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Chip(
                              label: Text(
                                team['members'] as String,
                                style: const TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          team['contest'] as String,
                          style: const TextStyle(
                            color: AppColors.blue,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          team['desc'] as String,
                          style: const TextStyle(
                            color: AppColors.sub,
                            fontWeight: FontWeight.w700,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 7,
                          runSpacing: 7,
                          children: need
                              .map(
                                (role) => Chip(
                                  backgroundColor: AppColors.lightBlue,
                                  label: Text(role),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => TeamRecruitmentDetailScreen(
                                    team: team,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.chat_bubble_outline),
                            label: const Text(
                              '모집글 자세히 보기',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 8),
              AppCard(
                color: AppColors.lightBlue,
                child: const Text(
                  '현재 화면은 mock입니다. 실제 서비스에서는 부적절한 모집글 신고, 개인정보 보호, 공식 공모전 여부 표시가 필요합니다.',
                  style: TextStyle(
                    color: AppColors.darkBlue,
                    fontWeight: FontWeight.w800,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class TeamRecruitmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> team;

  const TeamRecruitmentDetailScreen({
    super.key,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    final need = team['need'] as List<String>;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '모집글 상세',
                subtitle: '공모전 팀이 어떤 역할을 찾고 있는지 확인합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Recruitment Detail',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            team['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            team['contest'] as String,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Nasumi(size: 84, label: '모집'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '팀 소개',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      team['desc'] as String,
                      style: const TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ProfileRow(label: '현재 인원', value: team['members'] as String),
                    ProfileRow(label: '모집 상태', value: team['status'] as String),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: AppColors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '필요한 역할',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: need
                          .map(
                            (role) => Chip(
                              backgroundColor: Colors.white,
                              label: Text(
                                role,
                                style: const TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '지원 전 확인',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    _BulletLine(text: '공식 공고와 학생 모집글은 서로 다를 수 있습니다.'),
                    _BulletLine(text: '최종 제출 조건은 반드시 공식 공고에서 확인해야 합니다.'),
                    _BulletLine(text: '현재 단계에서는 실제 지원이 아니라 mock 흐름입니다.'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('지원 기능은 mock입니다. v4.x 이후 구현 예정입니다.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send_outlined),
                  label: const Text(
                    '이 팀에 관심 표시하기',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateTeamRecruitmentMockScreen extends StatelessWidget {
  const CreateTeamRecruitmentMockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      '기획',
      '개발',
      '디자인',
      '발표',
      '자료조사',
      '문서',
      'AI',
      '데이터',
      '영상',
      '팀장',
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '모집글 만들기',
                subtitle: '공모전 팀에서 필요한 역할을 정리하는 mock 화면입니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Recruitment',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '필요한 역할을\n명확하게 모집',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '팀원이 필요한 이유와 역할을 구체적으로 쓰면 매칭 성공률이 높아집니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '작성'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '입력 항목',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 12),
                    ProfileRow(label: '공모전 선택', value: '스마트캠퍼스 아이디어 공모전'),
                    ProfileRow(label: '팀 이름', value: '예: 캠퍼스 생활 개선팀'),
                    ProfileRow(label: '현재 인원', value: '예: 2 / 4'),
                    ProfileRow(label: '연락 방식', value: 'DM / 오픈채팅 / 이메일'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: AppColors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '필요 역할 선택',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: roles
                          .map(
                            (role) => Chip(
                              backgroundColor: Colors.white,
                              label: Text(
                                role,
                                style: const TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '작성 가이드',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    _BulletLine(text: '팀이 해결하려는 주제를 먼저 적습니다.'),
                    _BulletLine(text: '필요한 역할을 구체적으로 적습니다.'),
                    _BulletLine(text: '개인 연락처 노출은 최소화해야 합니다.'),
                    _BulletLine(text: '공식 공고 링크를 함께 확인해야 합니다.'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('모집글 생성은 mock입니다. 실제 저장은 이후 구현 예정입니다.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_note),
                  label: const Text(
                    '모집글 mock 생성',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class TeamLinkSafetyPolicyScreen extends StatelessWidget {
  const TeamLinkSafetyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reportReasons = [
      '허위 모집글',
      '개인정보 과다 요구',
      '부적절한 표현',
      '공식 공고 사칭',
      '금전 요구',
      '외부 링크 위험',
      '팀원 괴롭힘/분쟁',
    ];

    final trustRules = [
      '학교 공식 공고와 학생 모집글을 분리해서 표시합니다.',
      'mock 데이터와 실제 공고를 구분해야 합니다.',
      '개인 연락처는 최소한으로 노출해야 합니다.',
      '팀원 실력이나 수상 가능성을 보장하지 않습니다.',
      '최종 제출 조건은 공식 공고에서 확인해야 합니다.',
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '팀링크 운영정책',
                subtitle: '팀원 매칭 기능의 신뢰, 신고, 개인정보 기준을 정리합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trust & Safety',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '공식 공고와\n학생 모집글을 구분',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'TeamLink는 팀을 연결하지만, 팀 품질이나 수상 가능성을 보장하지 않습니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '신뢰'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: AppColors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '신뢰 표시 기준',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...trustRules.map((rule) => _BulletLine(text: rule)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '신고 사유',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: reportReasons
                          .map(
                            (reason) => Chip(
                              backgroundColor: AppColors.lightBlue,
                              label: Text(
                                reason,
                                style: const TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '운영 한계',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    _BulletLine(text: '앱은 팀원을 연결할 수 있지만 팀 갈등을 모두 해결할 수는 없습니다.'),
                    _BulletLine(text: '학생 모집글은 공식 공고가 아니며 별도 확인이 필요합니다.'),
                    _BulletLine(text: '실제 서비스에서는 관리자 검토와 신고 처리 절차가 필요합니다.'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.blue,
                    side: const BorderSide(color: AppColors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('신고 접수는 mock입니다. 실제 운영 기능은 이후 구현 예정입니다.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.report_gmailerrorred_outlined),
                  label: const Text(
                    '모집글 신고 mock',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _TeamLinkStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _TeamLinkStatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Icon(icon, color: AppColors.blue),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.sub,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}


class DepartmentIntroScreen extends StatefulWidget {
  const DepartmentIntroScreen({super.key});

  @override
  State<DepartmentIntroScreen> createState() => _DepartmentIntroScreenState();
}

class _DepartmentIntroScreenState extends State<DepartmentIntroScreen> {
  static const List<Map<String, dynamic>> departments = [
    {
      'name': '자율전공학부',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'FREE',
      'keywords': ['자율전공', '탐색', '진로설계'],
      'intro': '여러 전공을 탐색하며 진로 방향을 설계하는 학부입니다.',
      'learn': ['기초교양', '진로탐색', '전공탐색'],
      'career': ['전공 선택 후 관련 진로'],
      'transfer': '전공 선택 전 다양한 학과 정보를 비교해보는 것이 중요합니다.'
      ,'nasumi': '자율전공학부 나섬이',
      'mission': 'FREE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '유아교육과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'ECE',
      'keywords': ['유아교육', '교직', '아동'],
      'intro': '유아 교육과 아동 발달을 배우는 학과입니다.',
      'learn': ['유아교육론', '아동발달', '교육실습'],
      'career': ['유치원 교사', '아동교육 분야', '교육기관 종사자'],
      'transfer': '교직 적성과 아이들과 소통하는 태도가 중요합니다.'
      ,'nasumi': '유아교육과 나섬이',
      'mission': 'ECE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '국어국문한국어교육학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'KOR',
      'keywords': ['국어', '문학', '한국어교육'],
      'intro': '국어국문학과 한국어 교육을 함께 탐구하는 학과입니다.',
      'learn': ['국어학', '문학', '한국어교육'],
      'career': ['한국어 교원', '교육 분야', '콘텐츠 분야'],
      'transfer': '글쓰기와 언어에 대한 관심이 있으면 도움이 됩니다.'
      ,'nasumi': '국어국문한국어교육학과 나섬이',
      'mission': 'KOR-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '일본학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'JPN',
      'keywords': ['일본어', '일본문화', '국제'],
      'intro': '일본어와 일본 사회·문화를 배우는 학과입니다.',
      'learn': ['일본어', '일본문화', '지역학'],
      'career': ['통번역', '무역', '관광', '해외업무'],
      'transfer': '언어 학습을 꾸준히 할 수 있는지가 중요합니다.'
      ,'nasumi': '일본학과 나섬이',
      'mission': 'JPN-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '경찰법학부',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'LAW',
      'keywords': ['경찰', '법학', '행정'],
      'intro': '경찰·법·공공질서 분야를 배우는 학부입니다.',
      'learn': ['법학기초', '경찰학', '형사법'],
      'career': ['경찰', '공공기관', '법무 관련 직무'],
      'transfer': '공직 진로를 생각한다면 기초 법학과 시험 준비 흐름을 확인해야 합니다.'
      ,'nasumi': '경찰법학부 나섬이',
      'mission': 'LAW-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '행정학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'ADMIN',
      'keywords': ['행정', '정책', '공공'],
      'intro': '공공정책과 행정 운영을 배우는 학과입니다.',
      'learn': ['행정학', '정책학', '조직론'],
      'career': ['공무원', '공공기관', '행정직'],
      'transfer': '공공 문제에 관심이 있고 문서화 능력이 있으면 도움이 됩니다.'
      ,'nasumi': '행정학과 나섬이',
      'mission': 'ADMIN-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '심리상담학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'PSY',
      'keywords': ['심리', '상담', '사람'],
      'intro': '사람의 마음과 상담 과정을 배우는 학과입니다.',
      'learn': ['심리학개론', '상담이론', '발달심리'],
      'career': ['상담 분야', '복지기관', '심리 관련 직무'],
      'transfer': '사람을 이해하려는 태도와 꾸준한 학습이 중요합니다.'
      ,'nasumi': '심리상담학과 나섬이',
      'mission': 'PSY-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '경영학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'BUSINESS',
      'keywords': ['경영', '마케팅', '창업'],
      'intro': '조직, 마케팅, 회계, 전략 등 비즈니스 운영을 배우는 학과입니다.',
      'learn': ['경영학원론', '마케팅', '회계'],
      'career': ['기획자', '마케터', '운영 담당자', '창업'],
      'transfer': '발표력, 문서화, 데이터 기반 사고가 도움이 됩니다.'
      ,'nasumi': '경영학과 나섬이',
      'mission': 'BUSINESS-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': 'IT경영정보학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'ITM',
      'keywords': ['IT', '경영', '데이터'],
      'intro': 'IT와 경영 정보를 함께 다루는 학과입니다.',
      'learn': ['경영정보', '데이터분석', 'IT기획'],
      'career': ['IT기획자', '데이터 담당자', '서비스 운영'],
      'transfer': 'IT와 비즈니스를 함께 이해하려는 태도가 중요합니다.'
      ,'nasumi': 'IT경영정보학과 나섬이',
      'mission': 'ITM-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '글로벌비즈니스학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'GBIZ',
      'keywords': ['글로벌', '무역', '비즈니스'],
      'intro': '국제 비즈니스와 글로벌 시장을 배우는 학과입니다.',
      'learn': ['무역', '국제경영', '외국어'],
      'career': ['무역', '해외영업', '국제업무'],
      'transfer': '외국어와 시장 흐름에 대한 관심이 있으면 좋습니다.'
      ,'nasumi': '글로벌비즈니스학과 나섬이',
      'mission': 'GBIZ-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '관광경영학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'TOUR',
      'keywords': ['관광', '서비스', '경영'],
      'intro': '관광 산업과 서비스 운영을 배우는 학과입니다.',
      'learn': ['관광학', '서비스경영', '관광마케팅'],
      'career': ['관광업', '서비스 기획', '호텔·여행 분야'],
      'transfer': '서비스 마인드와 현장 경험이 중요합니다.'
      ,'nasumi': '관광경영학과 나섬이',
      'mission': 'TOUR-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '호텔항공경영학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'HOTEL',
      'keywords': ['호텔', '항공', '서비스'],
      'intro': '호텔과 항공 서비스 산업의 운영을 배우는 학과입니다.',
      'learn': ['호텔경영', '항공서비스', '서비스실무'],
      'career': ['호텔', '항공사', '서비스 운영'],
      'transfer': '서비스 태도와 외국어 준비가 도움이 됩니다.'
      ,'nasumi': '호텔항공경영학과 나섬이',
      'mission': 'HOTEL-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '항공서비스학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'AIR',
      'keywords': ['항공', '서비스', '승무원'],
      'intro': '항공 서비스와 고객 응대 역량을 배우는 학과입니다.',
      'learn': ['항공서비스', '이미지메이킹', '서비스실무'],
      'career': ['승무원', '항공서비스', '고객응대 직무'],
      'transfer': '자기관리와 커뮤니케이션 능력이 중요합니다.'
      ,'nasumi': '항공서비스학과 나섬이',
      'mission': 'AIR-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '미디어콘텐츠학과',
      'college': '인문사회계열',
      'building': '확인 필요',
      'code': 'MEDIA_CONTENT',
      'keywords': ['미디어', '콘텐츠', '기획'],
      'intro': '미디어 콘텐츠 기획과 제작을 배우는 학과입니다.',
      'learn': ['콘텐츠기획', '미디어제작', '영상편집'],
      'career': ['콘텐츠 기획자', '영상 제작자', '미디어 운영자'],
      'transfer': '기획력과 결과물 포트폴리오가 중요합니다.'
      ,'nasumi': '미디어콘텐츠학과 나섬이',
      'mission': 'MEDIA_CONTENT-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '간호학과',
      'college': '자연과학계열',
      'building': '확인 필요',
      'code': 'NURSING',
      'keywords': ['간호', '보건', '의료'],
      'intro': '전문성과 책임감을 바탕으로 간호 역량을 기르는 학과입니다.',
      'learn': ['기초간호', '성인간호', '임상실습'],
      'career': ['간호사', '보건의료기관', '공공보건'],
      'transfer': '학업량과 실습이 있는 만큼 책임감과 체력이 중요합니다.'
      ,'nasumi': '간호학과 나섬이',
      'mission': 'NURSING-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '의류패션학과',
      'college': '자연과학계열',
      'building': '확인 필요',
      'code': 'FASHION',
      'keywords': ['패션', '의류', '디자인'],
      'intro': '의류와 패션 산업을 배우는 학과입니다.',
      'learn': ['패션디자인', '의복구성', '소재'],
      'career': ['패션 디자이너', 'MD', '브랜드 운영'],
      'transfer': '감각과 포트폴리오 관리가 중요합니다.'
      ,'nasumi': '의류패션학과 나섬이',
      'mission': 'FASHION-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '식품영양학과',
      'college': '자연과학계열',
      'building': '확인 필요',
      'code': 'FOOD_NUTRITION',
      'keywords': ['식품', '영양', '건강'],
      'intro': '식품과 영양, 건강 관리 지식을 배우는 학과입니다.',
      'learn': ['영양학', '식품학', '급식관리'],
      'career': ['영양사', '식품회사', '보건 관련 직무'],
      'transfer': '과학 기초와 식품 안전에 대한 관심이 필요합니다.'
      ,'nasumi': '식품영양학과 나섬이',
      'mission': 'FOOD_NUTRITION-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '외식조리학과',
      'college': '자연과학계열',
      'building': '확인 필요',
      'code': 'CULINARY',
      'keywords': ['외식', '조리', '식품'],
      'intro': '조리 실무와 외식 산업 운영을 배우는 학과입니다.',
      'learn': ['조리실습', '외식경영', '메뉴개발'],
      'career': ['조리사', '외식 창업', '식품 개발'],
      'transfer': '실습 태도와 현장 경험이 중요합니다.'
      ,'nasumi': '외식조리학과 나섬이',
      'mission': 'CULINARY-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '원예산림학과',
      'college': '자연과학계열',
      'building': '확인 필요',
      'code': 'HORT',
      'keywords': ['원예', '산림', '환경'],
      'intro': '식물, 원예, 산림 자원과 환경을 배우는 학과입니다.',
      'learn': ['원예학', '산림자원', '환경관리'],
      'career': ['원예 분야', '산림 관련 직무', '환경 분야'],
      'transfer': '자연과 현장 활동에 대한 관심이 있으면 좋습니다.'
      ,'nasumi': '원예산림학과 나섬이',
      'mission': 'HORT-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '보건의료복지학과',
      'college': '자연과학계열',
      'building': '확인 필요',
      'code': 'HEALTH_WELFARE',
      'keywords': ['보건', '의료', '복지'],
      'intro': '보건의료와 복지 서비스를 함께 이해하는 학과입니다.',
      'learn': ['보건학', '복지론', '의료서비스'],
      'career': ['보건복지기관', '의료행정', '복지 서비스'],
      'transfer': '사람을 돕는 일에 대한 관심이 중요합니다.'
      ,'nasumi': '보건의료복지학과 나섬이',
      'mission': 'HEALTH_WELFARE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '생명공학과',
      'college': '자연과학계열',
      'building': '확인 필요',
      'code': 'BIO',
      'keywords': ['생명', '바이오', '실험'],
      'intro': '생명현상과 바이오 기술을 배우는 학과입니다.',
      'learn': ['생물학', '생명공학', '실험기초'],
      'career': ['바이오 연구', '제약·식품 분야', '연구보조'],
      'transfer': '기초 과학과 실험 태도가 중요합니다.'
      ,'nasumi': '생명공학과 나섬이',
      'mission': 'BIO-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '컴퓨터공학과',
      'college': 'AI·SW창의융합대학',
      'building': '정보과학관',
      'code': 'CS',
      'keywords': ['앱', '서버', 'AI', '임베디드', '보안'],
      'intro': '소프트웨어와 시스템을 설계하고 구현하는 학과입니다.',
      'learn': ['프로그래밍', '자료구조', '운영체제', '네트워크'],
      'career': ['소프트웨어 개발자', '백엔드 개발자', '임베디드 개발자'],
      'transfer': '프로그래밍 기초와 꾸준한 실습 경험이 중요합니다.'
      ,'nasumi': '컴퓨터공학과 나섬이',
      'mission': 'CS-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '소프트웨어학',
      'college': 'AI·SW창의융합대학',
      'building': '정보과학관 / 확인 필요',
      'code': 'SW',
      'keywords': ['소프트웨어', '웹', '앱'],
      'intro': '소프트웨어 서비스와 응용 프로그램 개발 역량을 기르는 전공입니다.',
      'learn': ['프로그래밍', '웹/앱 개발', '데이터베이스'],
      'career': ['웹 개발자', '앱 개발자', '서비스 개발자'],
      'transfer': '간단한 앱/웹 결과물을 만들어보는 것이 좋습니다.'
      ,'nasumi': '소프트웨어학 나섬이',
      'mission': 'SW-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '정보보안학',
      'college': 'AI·SW창의융합대학',
      'building': '정보과학관 / 확인 필요',
      'code': 'SEC',
      'keywords': ['보안', '네트워크', '시스템'],
      'intro': '정보 시스템을 안전하게 보호하기 위한 보안 기술을 배우는 전공입니다.',
      'learn': ['네트워크', '운영체제', '웹보안'],
      'career': ['보안 엔지니어', '관제 분석가', '보안 컨설턴트'],
      'transfer': '리눅스, 네트워크, 프로그래밍 기초가 중요합니다.'
      ,'nasumi': '정보보안학 나섬이',
      'mission': 'SEC-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '게임공학',
      'college': 'AI·SW창의융합대학',
      'building': '확인 필요',
      'code': 'GAME',
      'keywords': ['게임', '그래픽', '콘텐츠'],
      'intro': '게임과 인터랙티브 콘텐츠를 설계하고 구현하는 전공입니다.',
      'learn': ['게임프로그래밍', '그래픽스', '게임기획'],
      'career': ['게임 개발자', '게임 기획자', 'XR 개발자'],
      'transfer': '프로그래밍과 포트폴리오성 결과물이 중요합니다.'
      ,'nasumi': '게임공학 나섬이',
      'mission': 'GAME-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '인공지능',
      'college': 'AI·SW창의융합대학',
      'building': '스마트배재관',
      'code': 'AI',
      'keywords': ['AI', '데이터', '머신러닝'],
      'intro': '데이터와 인공지능 모델을 이해하고 활용하는 전공입니다.',
      'learn': ['Python', '데이터분석', '머신러닝'],
      'career': ['AI 개발자', '데이터 분석가', 'ML 엔지니어'],
      'transfer': 'Python과 수학적 사고를 준비하면 좋습니다.'
      ,'nasumi': '인공지능 나섬이',
      'mission': 'AI-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '드론로봇공학',
      'college': '피지컬AI공학부',
      'building': '확인 필요',
      'code': 'DRONE',
      'keywords': ['드론', '로봇', '제어'],
      'intro': '드론, 로봇, 제어 시스템과 피지컬 AI 기술을 다루는 전공입니다.',
      'learn': ['로봇기초', '제어', '센서'],
      'career': ['로봇 개발자', '드론 개발자', '제어 엔지니어'],
      'transfer': 'C/C++, 수학, 센서/하드웨어 기초가 도움이 됩니다.'
      ,'nasumi': '드론로봇공학 나섬이',
      'mission': 'DRONE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': 'AI융합전자',
      'college': '피지컬AI공학부',
      'building': '확인 필요',
      'code': 'AIE',
      'keywords': ['전자', '회로', 'AIoT'],
      'intro': '전자공학과 AI/IoT 기술을 융합해 하드웨어 기반 시스템을 배우는 전공입니다.',
      'learn': ['전자회로', '센서', '마이크로컨트롤러'],
      'career': ['전자 엔지니어', '임베디드 개발자', 'IoT 개발자'],
      'transfer': '회로 기초와 C언어 이해가 중요합니다.'
      ,'nasumi': 'AI융합전자 나섬이',
      'mission': 'AIE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '전기공학과',
      'college': '공학계열',
      'building': '확인 필요',
      'code': 'ELEC',
      'keywords': ['전기', '전력', '설비'],
      'intro': '전기 에너지와 전력 시스템을 배우는 학과입니다.',
      'learn': ['전기회로', '전력공학', '전기설비'],
      'career': ['전기 엔지니어', '전력 분야', '설비 관리'],
      'transfer': '수학과 회로 기초를 준비하면 좋습니다.'
      ,'nasumi': '전기공학과 나섬이',
      'mission': 'ELEC-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '철도건설공학과',
      'college': '공학계열',
      'building': '확인 필요',
      'code': 'RAIL',
      'keywords': ['철도', '건설', '토목'],
      'intro': '철도와 건설 인프라를 배우는 학과입니다.',
      'learn': ['건설기초', '철도공학', '구조'],
      'career': ['건설 분야', '철도 관련 직무', '토목 엔지니어'],
      'transfer': '공간 이해와 기초 역학 감각이 도움이 됩니다.'
      ,'nasumi': '철도건설공학과 나섬이',
      'mission': 'RAIL-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '스마트배터리학과',
      'college': '공학계열',
      'building': '확인 필요',
      'code': 'BATTERY',
      'keywords': ['배터리', '에너지', '소재'],
      'intro': '배터리와 에너지 저장 기술을 배우는 학과입니다.',
      'learn': ['배터리기초', '에너지소재', '전기화학'],
      'career': ['배터리 산업', '에너지 분야', '소재 관련 직무'],
      'transfer': '화학과 전기 기초를 함께 이해하면 좋습니다.'
      ,'nasumi': '스마트배터리학과 나섬이',
      'mission': 'BATTERY-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '실내건축학과',
      'college': '공학계열',
      'building': '확인 필요',
      'code': 'INTERIOR',
      'keywords': ['실내건축', '공간', '디자인'],
      'intro': '실내 공간과 건축 디자인을 배우는 학과입니다.',
      'learn': ['공간디자인', '제도', '건축기초'],
      'career': ['인테리어 디자이너', '공간 디자이너', '건축 관련 직무'],
      'transfer': '도면과 포트폴리오 준비가 중요합니다.'
      ,'nasumi': '실내건축학과 나섬이',
      'mission': 'INTERIOR-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '조경학과',
      'college': '공학계열',
      'building': '확인 필요',
      'code': 'LANDSCAPE',
      'keywords': ['조경', '환경', '공간'],
      'intro': '도시와 자연 공간의 조경 설계를 배우는 학과입니다.',
      'learn': ['조경설계', '식재', '환경계획'],
      'career': ['조경 설계', '공원·환경 분야', '공공 디자인'],
      'transfer': '자연과 공간 설계에 대한 관심이 필요합니다.'
      ,'nasumi': '조경학과 나섬이',
      'mission': 'LANDSCAPE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '건축학과(5년제)',
      'college': '공학계열',
      'building': '확인 필요',
      'code': 'ARCH',
      'keywords': ['건축', '설계', '공간'],
      'intro': '건축 설계와 공간 구성을 배우는 5년제 학과입니다.',
      'learn': ['건축설계', '구조', '건축사'],
      'career': ['건축가', '건축 설계', '공간 기획'],
      'transfer': '설계 과제와 포트폴리오 관리가 중요합니다.'
      ,'nasumi': '건축학과(5년제) 나섬이',
      'mission': 'ARCH-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '운동재활복지학과',
      'college': '공학계열 / 확인 필요',
      'building': '확인 필요',
      'code': 'REHAB',
      'keywords': ['운동', '재활', '복지'],
      'intro': '운동 재활과 복지 서비스를 배우는 학과입니다.',
      'learn': ['운동처방', '재활기초', '복지론'],
      'career': ['운동재활 분야', '복지기관', '건강관리'],
      'transfer': '사람의 몸과 회복 과정에 대한 관심이 필요합니다.'
      ,'nasumi': '운동재활복지학과 나섬이',
      'mission': 'REHAB-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '아트앤웹툰',
      'college': '아트앤웹툰학부',
      'building': '확인 필요',
      'code': 'WEBTOON',
      'keywords': ['웹툰', '드로잉', '스토리'],
      'intro': '웹툰과 시각 콘텐츠 제작 역량을 기르는 전공입니다.',
      'learn': ['드로잉', '스토리텔링', '디지털 작업'],
      'career': ['웹툰 작가', '일러스트레이터', '캐릭터 디자이너'],
      'transfer': '개인 작업물과 꾸준한 포트폴리오가 중요합니다.'
      ,'nasumi': '아트앤웹툰 나섬이',
      'mission': 'WEBTOON-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '게임애니메이션',
      'college': '아트앤웹툰학부',
      'building': '확인 필요',
      'code': 'ANIMATION',
      'keywords': ['애니메이션', '게임그래픽', '3D'],
      'intro': '게임과 애니메이션 시각 콘텐츠 제작을 배우는 전공입니다.',
      'learn': ['애니메이션', '3D 그래픽', '캐릭터 디자인'],
      'career': ['애니메이터', '게임 그래픽 디자이너', '3D 아티스트'],
      'transfer': '그림/그래픽 작업물과 포트폴리오 관리가 중요합니다.'
      ,'nasumi': '게임애니메이션 나섬이',
      'mission': 'ANIMATION-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '커뮤니케이션디자인',
      'college': '디자인학부',
      'building': '확인 필요',
      'code': 'COMM_DESIGN',
      'keywords': ['디자인', '브랜딩', '시각'],
      'intro': '시각 커뮤니케이션과 디자인 문제 해결을 배우는 전공입니다.',
      'learn': ['시각디자인', '브랜딩', '편집디자인'],
      'career': ['그래픽 디자이너', '브랜드 디자이너', '콘텐츠 디자이너'],
      'transfer': '디자인 포트폴리오와 툴 활용이 중요합니다.'
      ,'nasumi': '커뮤니케이션디자인 나섬이',
      'mission': 'COMM_DESIGN-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '산업디자인',
      'college': '디자인학부',
      'building': '확인 필요',
      'code': 'IND_DESIGN',
      'keywords': ['제품', '디자인', 'UX'],
      'intro': '제품과 사용 경험 중심의 디자인을 배우는 전공입니다.',
      'learn': ['제품디자인', 'UX기초', '모델링'],
      'career': ['제품 디자이너', 'UX 디자이너', '산업디자인 분야'],
      'transfer': '관찰력과 조형 감각이 중요합니다.'
      ,'nasumi': '산업디자인 나섬이',
      'mission': 'IND_DESIGN-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '광고사진영상학과',
      'college': '예체능계열',
      'building': '확인 필요',
      'code': 'PHOTO_VIDEO',
      'keywords': ['광고', '사진', '영상'],
      'intro': '광고, 사진, 영상 콘텐츠 제작과 시각 커뮤니케이션을 배우는 학과입니다.',
      'learn': ['사진', '영상 제작', '광고 기획'],
      'career': ['영상 제작자', '광고 기획자', '콘텐츠 디자이너'],
      'transfer': '촬영/편집 결과물과 시각 표현 포트폴리오가 중요합니다.'
      ,'nasumi': '광고사진영상학과 나섬이',
      'mission': 'PHOTO_VIDEO-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '뷰티케어학과',
      'college': '예체능계열',
      'building': '확인 필요',
      'code': 'BEAUTY',
      'keywords': ['뷰티', '케어', '스타일'],
      'intro': '뷰티 산업과 실무 케어 기술을 배우는 학과입니다.',
      'learn': ['뷰티케어', '스타일링', '실무실습'],
      'career': ['뷰티 전문가', '스타일리스트', '뷰티 창업'],
      'transfer': '실습 태도와 서비스 감각이 중요합니다.'
      ,'nasumi': '뷰티케어학과 나섬이',
      'mission': 'BEAUTY-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '실용음악',
      'college': '공연예술학부',
      'building': '확인 필요',
      'code': 'MUSIC',
      'keywords': ['음악', '보컬', '악기'],
      'intro': '실용음악과 공연 역량을 기르는 전공입니다.',
      'learn': ['보컬', '악기', '작곡'],
      'career': ['뮤지션', '공연예술가', '음악 콘텐츠 분야'],
      'transfer': '꾸준한 연습과 무대 경험이 중요합니다.'
      ,'nasumi': '실용음악 나섬이',
      'mission': 'MUSIC-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '영화영상학-연출 및 스탭',
      'college': '공연예술학부',
      'building': '확인 필요',
      'code': 'FILM_STAFF',
      'keywords': ['영화', '연출', '스탭'],
      'intro': '영화와 영상 제작의 연출·스탭 역할을 배우는 전공입니다.',
      'learn': ['영상연출', '촬영', '편집'],
      'career': ['영상 감독', '촬영·편집 스태프', '콘텐츠 제작자'],
      'transfer': '팀 작업과 현장 경험이 중요합니다.'
      ,'nasumi': '영화영상학-연출 및 스탭 나섬이',
      'mission': 'FILM_STAFF-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '영화영상학-연기',
      'college': '공연예술학부',
      'building': '확인 필요',
      'code': 'ACTING',
      'keywords': ['연기', '영화', '공연'],
      'intro': '영화와 무대 연기 역량을 기르는 전공입니다.',
      'learn': ['연기', '발성', '무대실습'],
      'career': ['배우', '공연예술가', '영상 콘텐츠 분야'],
      'transfer': '표현력과 꾸준한 훈련이 중요합니다.'
      ,'nasumi': '영화영상학-연기 나섬이',
      'mission': 'ACTING-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '스포츠지도·건강재활',
      'college': '레저스포츠학부',
      'building': '확인 필요',
      'code': 'SPORT_REHAB',
      'keywords': ['스포츠', '지도', '재활'],
      'intro': '스포츠 지도와 건강 재활을 배우는 전공입니다.',
      'learn': ['스포츠지도', '건강관리', '재활기초'],
      'career': ['스포츠 지도자', '건강관리 분야', '재활 관련 직무'],
      'transfer': '운동 실기와 사람을 지도하는 태도가 중요합니다.'
      ,'nasumi': '스포츠지도·건강재활 나섬이',
      'mission': 'SPORT_REHAB-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '스포츠마케팅',
      'college': '레저스포츠학부',
      'building': '확인 필요',
      'code': 'SPORT_MARKETING',
      'keywords': ['스포츠', '마케팅', '운영'],
      'intro': '스포츠 산업과 마케팅 운영을 배우는 전공입니다.',
      'learn': ['스포츠산업', '마케팅', '이벤트운영'],
      'career': ['스포츠마케터', '구단 운영', '이벤트 기획'],
      'transfer': '스포츠 산업 이해와 기획력이 중요합니다.'
      ,'nasumi': '스포츠마케팅 나섬이',
      'mission': 'SPORT_MARKETING-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '라이프스타일링',
      'college': '평생교육융합학부',
      'building': '확인 필요',
      'code': 'LIFE_STYLE',
      'keywords': ['라이프', '스타일', '융합'],
      'intro': '생활과 스타일 분야를 융합적으로 배우는 전공입니다.',
      'learn': ['라이프스타일', '디자인기초', '생활문화'],
      'career': ['라이프스타일 기획', '문화 서비스', '창업'],
      'transfer': '생활 문제를 관찰하고 기획하는 감각이 중요합니다.'
      ,'nasumi': '라이프스타일링 나섬이',
      'mission': 'LIFE_STYLE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '사회복지상담',
      'college': '평생교육융합학부',
      'building': '확인 필요',
      'code': 'WELFARE_COUNSEL',
      'keywords': ['사회복지', '상담', '돌봄'],
      'intro': '사회복지와 상담 기초를 배우는 전공입니다.',
      'learn': ['사회복지론', '상담기초', '복지실무'],
      'career': ['복지기관', '상담 분야', '돌봄 서비스'],
      'transfer': '사람을 이해하고 돕는 태도가 중요합니다.'
      ,'nasumi': '사회복지상담 나섬이',
      'mission': 'WELFARE_COUNSEL-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '혼산업비즈니스',
      'college': '평생교육융합학부',
      'building': '확인 필요',
      'code': 'PET_BIZ',
      'keywords': ['반려', '산업', '비즈니스'],
      'intro': '반려동물 및 관련 산업 비즈니스를 배우는 전공입니다.',
      'learn': ['산업기초', '비즈니스', '서비스운영'],
      'career': ['반려산업', '서비스 창업', '운영 관리'],
      'transfer': '산업 흐름과 고객 이해가 중요합니다.'
      ,'nasumi': '혼산업비즈니스 나섬이',
      'mission': 'PET_BIZ-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '부동산재테크',
      'college': '평생교육융합학부',
      'building': '확인 필요',
      'code': 'REAL_ESTATE',
      'keywords': ['부동산', '재테크', '자산'],
      'intro': '부동산과 자산관리 기초를 배우는 전공입니다.',
      'learn': ['부동산기초', '자산관리', '재테크'],
      'career': ['부동산 분야', '자산관리', '상담 직무'],
      'transfer': '시장 변화와 법·제도 이해가 필요합니다.'
      ,'nasumi': '부동산재테크 나섬이',
      'mission': 'REAL_ESTATE-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '시니어운동처방·파크골프',
      'college': '평생교육융합학부',
      'building': '확인 필요',
      'code': 'SENIOR_SPORT',
      'keywords': ['시니어', '운동처방', '파크골프'],
      'intro': '시니어 건강과 운동 처방, 파크골프를 배우는 전공입니다.',
      'learn': ['운동처방', '건강관리', '파크골프'],
      'career': ['시니어 운동지도', '건강관리', '생활체육'],
      'transfer': '건강관리와 지도 역량이 중요합니다.'
      ,'nasumi': '시니어운동처방·파크골프 나섬이',
      'mission': 'SENIOR_SPORT-NASUMI',
      'status': '확인 필요',
    },
    {
      'name': '인문예술학',
      'college': '평생교육융합학부',
      'building': '확인 필요',
      'code': 'HUMAN_ART',
      'keywords': ['인문', '예술', '교양'],
      'intro': '인문과 예술을 융합적으로 탐구하는 전공입니다.',
      'learn': ['인문학', '예술기초', '문화이해'],
      'career': ['문화기획', '교육·교양 분야', '창작 활동'],
      'transfer': '읽기, 표현, 문화 이해에 관심이 있으면 좋습니다.'
      ,'nasumi': '인문예술학 나섬이',
      'mission': 'HUMAN_ART-NASUMI',
      'status': '확인 필요',
    },
  ];

  String _query = '';
  String _selectedGroup = '전체';

  static const List<String> groups = [
    '전체',
    '인문사회',
    '자연과학',
    '공학',
    '예체능',
    '평생교육',
  ];

  List<Map<String, dynamic>> get filteredDepartments {
    final q = _query.trim().toLowerCase();

    return departments.where((department) {
      final name = (department['name'] as String).toLowerCase();
      final college = (department['college'] as String).toLowerCase();
      final building = (department['building'] as String).toLowerCase();
      final code = (department['code'] as String).toLowerCase();
      final keywords = (department['keywords'] as List<String>).join(' ').toLowerCase();
      final career = (department['career'] as List<String>).join(' ').toLowerCase();

      final matchesQuery = q.isEmpty ||
          name.contains(q) ||
          college.contains(q) ||
          building.contains(q) ||
          code.contains(q) ||
          keywords.contains(q) ||
          career.contains(q);

      final matchesGroup = _selectedGroup == '전체' ||
          college.contains(_selectedGroup.toLowerCase()) ||
          _groupOf(college) == _selectedGroup;

      return matchesQuery && matchesGroup;
    }).toList();
  }

  static String _groupOf(String college) {
    if (college.contains('인문사회') ||
        college.contains('경영') ||
        college.contains('관광') ||
        college.contains('항공')) {
      return '인문사회';
    }
    if (college.contains('자연과학') ||
        college.contains('간호') ||
        college.contains('보건') ||
        college.contains('생명') ||
        college.contains('식품')) {
      return '자연과학';
    }
    if (college.contains('공학') ||
        college.contains('AI') ||
        college.contains('SW') ||
        college.contains('피지컬')) {
      return '공학';
    }
    if (college.contains('예체능') ||
        college.contains('디자인') ||
        college.contains('아트') ||
        college.contains('공연') ||
        college.contains('스포츠')) {
      return '예체능';
    }
    if (college.contains('평생교육')) {
      return '평생교육';
    }
    return '전체';
  }

  @override
  Widget build(BuildContext context) {
    final visibleDepartments = filteredDepartments;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '학과백과',
                subtitle: '학과 소개, 전과 탐색, 건물 위치, 나섬이 미션을 한 번에 확인합니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Department Guide',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '학과를 알고,\n건물을 찾고,\n나섬이를 수집',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '공식 입학 페이지가 아니라 학생 친화형 캠퍼스 탐색 가이드입니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: '학과'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() => _query = value);
                },
                decoration: InputDecoration(
                  hintText: '학과명, 키워드, 진로, 건물 검색',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: groups.map((group) {
                    final selected = _selectedGroup == group;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(
                          group,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: selected ? Colors.white : AppColors.darkBlue,
                          ),
                        ),
                        selected: selected,
                        selectedColor: AppColors.blue,
                        backgroundColor: Colors.white,
                        onSelected: (_) {
                          setState(() => _selectedGroup = group);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    '검색 결과 ${visibleDepartments.length}개',
                    style: const TextStyle(
                      color: AppColors.sub,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DepartmentFilterGuideScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                    label: const Text(
                      '필터 안내',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (visibleDepartments.isEmpty)
                AppCard(
                  color: AppColors.lightBlue,
                  child: const Text(
                    '조건에 맞는 학과가 없습니다. 검색어를 줄이거나 전체 필터로 다시 확인해보세요.',
                    style: TextStyle(
                      color: AppColors.darkBlue,
                      fontWeight: FontWeight.w800,
                      height: 1.5,
                    ),
                  ),
                )
              else
                ...visibleDepartments.map((department) {
                  final keywords = department['keywords'] as List<String>;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  department['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Chip(
                                label: Text(
                                  department['status'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w800),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            department['intro'] as String,
                            style: const TextStyle(
                              color: AppColors.sub,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 7,
                            runSpacing: 7,
                            children: keywords
                                .map((keyword) => Chip(label: Text(keyword)))
                                .toList(),
                          ),
                          const SizedBox(height: 12),
                          ProfileRow(label: '계열/학부', value: department['college'] as String),
                          ProfileRow(label: '주요 건물', value: department['building'] as String),
                          ProfileRow(label: '건물 코드', value: department['code'] as String),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: FilledButton.icon(
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => DepartmentDetailScreen(
                                      department: department,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.school_outlined),
                              label: const Text(
                                '학과 자세히 보기',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}

class DepartmentDetailScreen extends StatelessWidget {
  final Map<String, dynamic> department;

  const DepartmentDetailScreen({
    super.key,
    required this.department,
  });

  @override
  Widget build(BuildContext context) {
    final learn = department['learn'] as List<String>;
    final career = department['career'] as List<String>;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              Header(
                title: department['name'] as String,
                subtitle: '${department['building']} · ${department['status']}',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Department Dictionary',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            department['intro'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '나섬이 미션: ${department['nasumi']}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 86, label: department['code'] as String),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: AppColors.lightBlue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '이런 학생에게 추천',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _BulletLine(text: '이 학과의 키워드와 진로 방향에 관심이 있는 학생'),
                    _BulletLine(text: '관련 건물과 학과 분위기를 직접 탐색해보고 싶은 학생'),
                    _BulletLine(text: '전과, 복수전공, 진로 탐색을 고민하는 학생'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '배우는 내용',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    ...learn.map((item) => _BulletLine(text: item)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '진로 방향',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    ...career.map((item) => _BulletLine(text: item)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '입학/전과 참고 메모',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      department['transfer'] as String,
                      style: const TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                color: AppColors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '학과 나섬이 / QR 미션',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${department['nasumi']} · 미션 코드 ${department['mission']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '실제 출시 전에는 학과/학생회/교수님 확인을 받은 정보만 공식처럼 표시합니다.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  final String text;

  const _BulletLine({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.w900)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.sub,
                fontWeight: FontWeight.w700,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class AppStatusRoadmapScreen extends StatelessWidget {
  const AppStatusRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final done = [
      'Splash / Login mock',
      '홈 / 오늘의 Pick',
      '학생식당 상세 / 혼잡도 mock',
      '메뉴 카드 획득',
      'QR 스캔 mock',
      '코드 기반 미션',
      '캠퍼스 도감',
      '학과 나섬이 투어',
      '동아리 공고관',
      '관심 동아리 저장',
      '개인정보 안내',
      '로컬 데이터 초기화',
      '테스터 피드백 허브',
      '스마트 이동 허브',
      '3D 실내지도 검색 / 길안내 mock',
      '자율주행 픽업 예약 simulation',
      '자율배송 요청 / 추적 simulation',
    ];

    final notYet = [
      '실제 학교 이메일 인증',
      '실제 QR 카메라 스캔',
      '공식 건물·호실·교수연구실 데이터 연동',
      '실제 순환차량 위치 / 픽업 예약 API',
      'NEXUS ROS2 자율배송로봇 운행 API',
      '차량 안전·운영·개인정보 정책',
      '실제 학생식당 데이터 연동',
      '실제 동아리 공고 등록',
      '관리자 콘솔',
      '공식 학교 승인',
      '나섬이 캐릭터 사용 허가 확인',
      'Play Store 정식 배포 signing',
    ];

    final roadmap = [
      {
        'title': '1단계: 내부 테스트',
        'desc': 'APK를 소수 재학생에게 전달해 설치 이유와 재방문 이유를 검증합니다.',
      },
      {
        'title': '2단계: 학생식당 데이터 실험',
        'desc': '메뉴, 혼잡도, 만족도 흐름이 실제 사용 이유가 되는지 확인합니다.',
      },
      {
        'title': '3단계: 나섬이/도감 루프 강화',
        'desc': '학과별 나섬이, 건물 미션, 칭호, 랭킹 등 재방문 요소를 보강합니다.',
      },
      {
        'title': '4단계: 학교/이동 데이터 협의',
        'desc': '공식 호실 정보, 교수연구실 공개 범위, 차량 운영 주체와 개인정보 정책을 정리합니다.',
      },
      {
        'title': '5단계: ROS2 로봇 / 차량 API 연동',
        'desc': '배재Pick은 호출·예약·관제 UI를, NEXUS 11번 프로젝트는 실제 로봇·자율주행 스택을 담당합니다.',
      },
      {
        'title': '6단계: Play Store 내부 테스트',
        'desc': 'AAB, 개인정보처리방침 URL, 앱 아이콘, 스크린샷을 준비해 내부 테스트를 진행합니다.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '앱 상태 / 로드맵',
                subtitle: '현재 되는 것과 아직 안 되는 것을 명확히 보여줍니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '현재 단계',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '내부 테스트 가능한\nFlutter MVP',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '공식 학교 앱이 아니라 사용성 검증용 MVP입니다.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 84, label: 'MVP'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '현재 구현된 것',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    ...done.map((item) => _StatusLine(icon: Icons.check_circle, text: item)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '아직 구현되지 않은 것',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '아래 기능은 실제 출시 전에 별도 구현, 권한 검토, 학교 협의가 필요합니다.',
                      style: TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...notYet.map((item) => _StatusLine(icon: Icons.pending_outlined, text: item)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...roadmap.map((step) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          step['desc']!,
                          style: const TextStyle(
                            color: AppColors.sub,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 19, color: AppColors.blue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.sub,
                fontWeight: FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class TesterFeedbackScreen extends StatelessWidget {
  const TesterFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sections = [
      {
        'title': '1. 설치 이유',
        'items': [
          '학생식당 정보 때문에 앱을 열 이유가 있는가?',
          '오늘 메뉴, 혼잡도, 추천 방문 시간이 실제로 필요해 보이는가?',
          '학생식당이 첫 진입점으로 충분한가?',
        ],
      },
      {
        'title': '2. 재방문 이유',
        'items': [
          '나섬이 도감 수집이 다시 들어오게 만드는가?',
          '미션 코드 입력 흐름이 이해하기 쉬운가?',
          'QR 스캔 mock이 실제 기능으로 바뀌면 쓸 것 같은가?',
        ],
      },
      {
        'title': '3. 캠퍼스 탐험',
        'items': [
          '학과 나섬이 투어가 학교 구조를 익히는 데 도움이 되는가?',
          '신입생, 통학생, 기숙사생에게 실제 가치가 있는가?',
          '교수님 연구실/학과 사무실 안내까지 확장할 필요가 있는가?',
        ],
      },
      {
        'title': '4. 동아리 공고관',
        'items': [
          '동아리 모집 정보가 게시판보다 정리되어 보이는가?',
          '익명 댓글 없이 공고형 구조만 있는 것이 더 나은가?',
          '동아리 운영진이 직접 올릴 만한 구조인가?',
        ],
      },
      {
        'title': '5. 신뢰 / 개인정보',
        'items': [
          '서버 없이 로컬 저장 중심이라는 설명이 안심되는가?',
          '학교 이메일 인증은 꼭 필요해 보이는가?',
          '공식 앱이 아니라 MVP라는 점이 명확한가?',
        ],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '테스트 피드백',
                subtitle: '내부 테스터가 봐야 할 핵심 질문입니다.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'v1.7 Internal Test Hub',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '완성도보다 중요한 건\n계속 쓸 이유가 있는지입니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 82, label: 'QA'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '테스트 기준',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '이 앱은 아직 공식 학교 앱이 아닙니다. 실제 학교 데이터와 연동된 완성품도 아닙니다. 지금 확인할 것은 기능의 완성도가 아니라, 배재대 학생이 설치하고 다시 열 이유가 있는지입니다.',
                      style: TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...sections.map((section) {
                final items = section['items'] as List<String>;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section['title'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...items.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(fontWeight: FontWeight.w900)),
                                Expanded(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      color: AppColors.sub,
                                      fontWeight: FontWeight.w700,
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 6),
              AppCard(
                color: AppColors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '최종 질문',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '이 앱을 실제로 설치해서 계속 쓸 이유가 있는가?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PrivacyGuideScreen extends StatelessWidget {
  const PrivacyGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '개인정보 안내',
                subtitle: 'v1.0은 서버 저장 없이 로컬 중심으로 동작합니다.',
              ),
              const SizedBox(height: 20),
              AppCard(
                color: AppColors.darkBlue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '최소 수집 원칙',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '먼저 유용성을 증명하고,\n민감한 정보는 나중에 필요한 만큼만.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 88, label: '보안'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const PrivacySection(
                title: 'v1.0에서 저장하는 것',
                items: [
                  '이 기기 안의 도감 수집 상태',
                  '이 기기 안의 관심 동아리 상태',
                  '코드 기반 미션 완료 상태',
                  '메뉴 카드 획득 상태',
                ],
              ),
              const SizedBox(height: 14),
              const PrivacySection(
                title: 'v1.0에서 저장하지 않는 것',
                items: [
                  '실명',
                  '정확한 학번',
                  '전화번호',
                  '실시간 위치',
                  '개인별 식당 방문 기록 서버 저장',
                  '시설 신고자 신원',
                  '교수님 개인 연구실 방문 기록',
                ],
              ),
              const SizedBox(height: 14),
              const PrivacySection(
                title: '향후 인증 계획',
                items: [
                  'Firebase 또는 Supabase 인증 검토',
                  '학교 이메일 인증 검토',
                  '닉네임 / 학과 / 학년 중심의 최소 프로필',
                  '서버 동기화는 사용자 반응 확인 후 도입',
                ],
              ),
              const SizedBox(height: 14),
              AppCard(
                color: const Color(0xFFFFFBEB),
                child: Row(
                  children: const [
                    Icon(Icons.warning_amber_rounded, color: AppColors.orange),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '배재대학교 명칭과 나섬이 캐릭터 사용은 공식 출시 전 학교 측 확인이 필요합니다.',
                        style: TextStyle(
                          color: AppColors.text,
                          fontWeight: FontWeight.w800,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PrivacySection extends StatelessWidget {
  final String title;
  final List<String> items;

  const PrivacySection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          ...items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w900)),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final String subtitle;

  const Header({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Nasumi(size: 52, label: 'P'),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(color: AppColors.sub, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String? action;

  const SectionTitle({super.key, required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        if (action != null) Text(action!, style: const TextStyle(fontSize: 13, color: AppColors.blue, fontWeight: FontWeight.w800)),
      ],
    );
  }
}

class ClubCard extends StatelessWidget {
  final String title;
  final String category;
  final String deadline;
  final String place;
  final Map<String, String>? club;

  const ClubCard({
    super.key,
    required this.title,
    required this.category,
    required this.deadline,
    required this.place,
    this.club,
  });

  @override
  Widget build(BuildContext context) {
    final card = AppCard(
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(color: AppColors.blue.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.flight_takeoff, color: AppColors.blue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                const SizedBox(height: 4),
                Text(category, style: const TextStyle(color: AppColors.sub, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text('활동 장소: $place', style: const TextStyle(fontSize: 12, color: AppColors.sub)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: AppColors.red.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(999)),
            child: Text(deadline, style: const TextStyle(color: AppColors.red, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );

    if (club == null) {
      return card;
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ClubDetailScreen(club: club!),
          ),
        );
      },
      child: card,
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.sub, fontWeight: FontWeight.w700)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }
}



class QRMockScreen extends StatelessWidget {
  const QRMockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: 'QR 스캔',
                subtitle: 'v1.3에서는 실제 카메라 대신 mock 화면으로 제공합니다.',
              ),
              const SizedBox(height: 20),
              AppCard(
                color: AppColors.darkBlue,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 260,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.white24, width: 2),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 4),
                              borderRadius: BorderRadius.circular(22),
                            ),
                          ),
                          const Icon(Icons.qr_code_scanner, color: Colors.white, size: 84),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      '실제 QR 스캐너는 v1.4 이후 연동 예정',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '현재는 내부 테스트를 위해 코드 입력 방식으로 미션을 완료합니다.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '왜 아직 mock인가요?',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '실제 QR 스캔은 카메라 권한, 기기 테스트, 개인정보/위치 오해 가능성, 악용 방지 로직이 필요합니다. 내부 테스트 단계에서는 코드 입력으로 사용성을 먼저 검증합니다.',
                      style: TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MissionCodeScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.keyboard),
                        label: const Text(
                          '코드 입력으로 미션 완료',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MissionCodeScreen extends StatefulWidget {
  const MissionCodeScreen({super.key});

  @override
  State<MissionCodeScreen> createState() => _MissionCodeScreenState();
}

class _MissionCodeScreenState extends State<MissionCodeScreen> {
  final TextEditingController controller = TextEditingController();
  String? errorMessage;

  final Map<String, Map<String, String>> missionRewards = const {
    'BAEJAE-FOOD': {
      'title': '학생식당 나섬이',
      'rarity': 'Common',
      'desc': '학생식당 방문 미션을 완료해서 획득한 나섬이입니다.',
      'titleReward': '오늘의 식객',
    },
    'LIBRARY-NIGHT': {
      'title': '도서관 나섬이',
      'rarity': 'Rare',
      'desc': '시험기간 도서관 미션을 완료해서 획득한 나섬이입니다.',
      'titleReward': '밤샘 탐험가',
    },
    'IT-CODE': {
      'title': 'IT관 개발자 나섬이',
      'rarity': 'Rare',
      'desc': '정보과학관 개발자 미션을 완료해서 획득한 나섬이입니다.',
      'titleReward': '캠퍼스 빌더',
    },
    'CLUB-HUB': {
      'title': '동아리 헌터 배지',
      'rarity': 'Badge',
      'desc': '동아리 공고관 탐색 미션을 완료해서 획득한 배지입니다.',
      'titleReward': '동아리 탐색자',
    },
    'CLEAN-CAMPUS': {
      'title': '클린캠퍼스 배지',
      'rarity': 'Badge',
      'desc': '캠퍼스 경보와 흡연구역 안내 미션을 완료해서 획득한 배지입니다.',
      'titleReward': '클린캠퍼스 참여자',
    },
    'CS-NASUMI': {
      'title': '컴퓨터공학과 나섬이',
      'rarity': 'Department',
      'desc': '정보과학관에서 만날 수 있는 컴퓨터공학과 나섬이입니다.',
      'titleReward': '코드 빌더',
    },
    'AI-NASUMI': {
      'title': '인공지능학과 나섬이',
      'rarity': 'Department',
      'desc': 'AI와 데이터에 관심 있는 학생을 위한 인공지능학과 나섬이입니다.',
      'titleReward': 'AI 탐험가',
    },
    'GAME-NASUMI': {
      'title': '게임공학과 나섬이',
      'rarity': 'Department',
      'desc': '게임과 인터랙티브 콘텐츠를 좋아하는 학생을 위한 게임공학과 나섬이입니다.',
      'titleReward': '캠퍼스 플레이어',
    },
    'BUSINESS-NASUMI': {
      'title': '경영학과 나섬이',
      'rarity': 'Department',
      'desc': '비즈니스와 기획 감각을 가진 학생을 위한 경영학과 나섬이입니다.',
      'titleReward': '비즈니스 탐험가',
    },
    'TOURISM-NASUMI': {
      'title': '관광축제한류대학 나섬이',
      'rarity': 'Department',
      'desc': '축제, 관광, 한류 콘텐츠를 좋아하는 학생을 위한 학과 나섬이입니다.',
      'titleReward': '캠퍼스 가이드',
    },
  };

  Future<void> submitCode() async {
    final code = controller.text.trim().toUpperCase();

    if (!missionRewards.containsKey(code)) {
      setState(() {
        errorMessage = '등록되지 않은 미션 코드입니다. 테스트 코드 목록을 확인하세요.';
      });
      return;
    }

    final reward = missionRewards[code]!;
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList('collected_cards') ?? [];
    final title = reward['title']!;

    if (!current.contains(title)) {
      current.add(title);
      await prefs.setStringList('collected_cards', current);
    }

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MissionCompleteScreen(
          code: code,
          title: title,
          rarity: reward['rarity']!,
          desc: reward['desc']!,
          titleReward: reward['titleReward']!,
        ),
      ),
    );
  }

  void setQuickCode(String code) {
    setState(() {
      controller.text = code;
      errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final codes = missionRewards.keys.toList();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(height: 8),
              const Header(
                title: '미션 코드',
                subtitle: '건물·식당·동아리 미션 코드를 입력하세요.',
              ),
              const SizedBox(height: 18),
              AppCard(
                color: AppColors.blue,
                child: Row(
                  children: const [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '코드 기반 미션',
                            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'QR 없이도 내부 테스트가\n가능한 미션 구조입니다.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Nasumi(size: 86, label: '미션'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('미션 코드 입력', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 12),
                    TextField(
                      controller: controller,
                      textCapitalization: TextCapitalization.characters,
                      decoration: InputDecoration(
                        hintText: '예: BAEJAE-FOOD',
                        errorText: errorMessage,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: submitCode,
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text(
                          '미션 완료하기',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.darkBlue,
                          side: const BorderSide(color: AppColors.darkBlue, width: 1.4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const QRMockScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text(
                          'QR 스캔 mock 보기',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('빠른 테스트 코드', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 10),
                    const Text(
                      '내부 테스트에서는 아래 코드를 눌러 바로 입력할 수 있습니다.',
                      style: TextStyle(
                        color: AppColors.sub,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: codes.map((code) {
                        return ActionChip(
                          label: Text(
                            code,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                          onPressed: () => setQuickCode(code),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MissionCompleteScreen extends StatelessWidget {
  final String code;
  final String title;
  final String rarity;
  final String desc;
  final String titleReward;

  const MissionCompleteScreen({
    super.key,
    required this.code,
    required this.title,
    required this.rarity,
    required this.desc,
    required this.titleReward,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 30, 22, 30),
          child: Column(
            children: [
              const SizedBox(height: 24),
              const Nasumi(size: 148, label: '획득'),
              const SizedBox(height: 24),
              const Text(
                '미션 완료!',
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              Text(
                code,
                style: const TextStyle(
                  color: AppColors.blue,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 24),
              AppCard(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.yellow.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        rarity,
                        style: const TextStyle(
                          color: AppColors.orange,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.sub,
                        height: 1.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        '칭호 진행도: $titleReward +1',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MainShell()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    '도감으로 돌아가기',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
