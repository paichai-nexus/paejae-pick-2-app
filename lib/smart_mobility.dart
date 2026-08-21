import 'dart:async';

import 'package:flutter/material.dart';

/// Boundary between the UI and future school/vehicle APIs.
///
/// The MVP uses [MockMobilityDataSource]. A production implementation can
/// replace it without rewriting the screens.
abstract class MobilityDataSource {
  List<IndoorLocation> get indoorLocations;
  List<CampusStop> get campusStops;
  List<String> get deliveryDestinations;
}

class MockMobilityDataSource implements MobilityDataSource {
  const MockMobilityDataSource();

  @override
  List<IndoorLocation> get indoorLocations => const [
        IndoorLocation(
          building: '정보과학관',
          floor: '4F',
          room: 'C410',
          name: '컴퓨터공학과 안내공간 (샘플)',
          type: IndoorLocationType.departmentOffice,
          x: 0.76,
          y: 0.28,
        ),
        IndoorLocation(
          building: '정보과학관',
          floor: '4F',
          room: 'C413',
          name: '김OO 교수연구실 (샘플)',
          type: IndoorLocationType.professorOffice,
          x: 0.78,
          y: 0.67,
        ),
        IndoorLocation(
          building: '정보과학관',
          floor: '4F',
          room: 'C401',
          name: '컴퓨터공학 강의실 (샘플)',
          type: IndoorLocationType.classroom,
          x: 0.25,
          y: 0.31,
        ),
        IndoorLocation(
          building: '자연과학관',
          floor: '4F',
          room: 'J408',
          name: '원예산림 연구공간 (샘플)',
          type: IndoorLocationType.lab,
          x: 0.72,
          y: 0.48,
        ),
        IndoorLocation(
          building: '배재21세기관',
          floor: '5F',
          room: 'P512',
          name: '공용 강의실 (샘플)',
          type: IndoorLocationType.classroom,
          x: 0.32,
          y: 0.65,
        ),
      ];

  @override
  List<CampusStop> get campusStops => const [
        CampusStop(
          name: '학생회관 앞',
          detail: '학생식당 정문 옆',
          etaMinutes: 4,
          walkMinutes: 2,
          distanceMeters: 120,
        ),
        CampusStop(
          name: '배재21세기관',
          detail: '정문 순환차량 승강장',
          etaMinutes: 7,
          walkMinutes: 5,
          distanceMeters: 310,
        ),
        CampusStop(
          name: '국제교류관',
          detail: '상부 캠퍼스 승강장',
          etaMinutes: 11,
          walkMinutes: 7,
          distanceMeters: 460,
        ),
      ];

  @override
  List<String> get deliveryDestinations => const [
        '정보과학관 1층 로비',
        '자연과학관 1층 수령존',
        '도서관 정문 수령존',
        '배재21세기관 1층 로비',
      ];
}

enum IndoorLocationType { classroom, departmentOffice, professorOffice, lab }

class IndoorLocation {
  const IndoorLocation({
    required this.building,
    required this.floor,
    required this.room,
    required this.name,
    required this.type,
    required this.x,
    required this.y,
  });

  final String building;
  final String floor;
  final String room;
  final String name;
  final IndoorLocationType type;
  final double x;
  final double y;

  String get searchableText => '$building $floor $room $name'.toLowerCase();

  String get typeLabel => switch (type) {
        IndoorLocationType.classroom => '강의실',
        IndoorLocationType.departmentOffice => '학과사무실',
        IndoorLocationType.professorOffice => '교수연구실',
        IndoorLocationType.lab => '연구실',
      };
}

class CampusStop {
  const CampusStop({
    required this.name,
    required this.detail,
    required this.etaMinutes,
    required this.walkMinutes,
    required this.distanceMeters,
  });

  final String name;
  final String detail;
  final int etaMinutes;
  final int walkMinutes;
  final int distanceMeters;
}

class SmartMobilityPreviewCard extends StatelessWidget {
  const SmartMobilityPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _PickCard(
      color: _PickColors.darkBlue,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: _PickColors.bg,
            body: const SafeArea(
              child: SmartMobilityHubScreen(showBackButton: true),
            ),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statusPill('NEW · SMART MOBILITY'),
                const SizedBox(height: 12),
                const Text(
                  '3D 길찾기부터\n자율주행 픽업까지',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '스마트 캠퍼스 이동 기능을 미리 체험해보세요.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const _MobilityMascot(size: 78),
        ],
      ),
    );
  }
}

class SmartMobilityHubScreen extends StatelessWidget {
  const SmartMobilityHubScreen({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BrandHeader(showBackButton: showBackButton),
          const SizedBox(height: 24),
          const _FeatureHeader(
            title: '스마트 이동',
            subtitle: '길찾기·픽업·배송을 배재Pick 하나로 연결해요.',
          ),
          const SizedBox(height: 18),
          _PickCard(
            color: _PickColors.blue,
            padding: EdgeInsets.zero,
            child: const _MobilityHero(),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _MobilityFeatureCard(
                  icon: Icons.view_in_ar_outlined,
                  color: _PickColors.blue,
                  title: '3D 실내지도',
                  subtitle: '건물·호실·교수명 검색',
                  badge: 'MVP',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const IndoorMapScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MobilityFeatureCard(
                  icon: Icons.airport_shuttle_outlined,
                  color: _PickColors.green,
                  title: '자율주행 픽업',
                  subtitle: '도착시간·좌석·예약',
                  badge: '시뮬레이션',
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ShuttlePickupScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _MobilityWideCard(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DeliveryRobotScreen()),
            ),
          ),
          const SizedBox(height: 18),
          _PickCard(
            color: _PickColors.lightBlue,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: _PickColors.blue),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '현재는 사용성 검증용 MVP입니다. 실제 호실·차량·예약·배송 데이터는 학교 및 운영기관 협의 후 연동합니다.',
                    style: TextStyle(
                      color: _PickColors.sub,
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
    );
  }
}

class IndoorMapScreen extends StatefulWidget {
  const IndoorMapScreen({super.key, this.dataSource = const MockMobilityDataSource()});

  final MobilityDataSource dataSource;

  @override
  State<IndoorMapScreen> createState() => _IndoorMapScreenState();
}

class _IndoorMapScreenState extends State<IndoorMapScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _building = '정보과학관';
  String _floor = '4F';
  IndoorLocation? _selected;

  List<String> get _buildings => widget.dataSource.indoorLocations
      .map((location) => location.building)
      .toSet()
      .toList();

  List<IndoorLocation> get _results {
    final normalized = _query.trim().toLowerCase();
    final locations = widget.dataSource.indoorLocations;
    if (normalized.isEmpty) {
      return locations
          .where(
            (location) =>
                location.building == _building && location.floor == _floor,
          )
          .toList();
    }
    return locations
        .where((location) => location.searchableText.contains(normalized))
        .toList();
  }

  List<IndoorLocation> get _visibleMapLocations => _results
      .where(
        (location) =>
            location.building == _building && location.floor == _floor,
      )
      .toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _PickColors.bg,
      appBar: _appBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '캠퍼스맵',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              const Text(
                '건물·호실·교수명을 검색하고 3D 실내경로를 확인해요.',
                style: TextStyle(
                  color: _PickColors.sub,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                decoration: _inputDecoration(
                  hint: '예: C413, 컴퓨터공학, 김OO 교수',
                  icon: Icons.search,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buildings
                      .map(
                        (building) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(building),
                            selected: _building == building,
                            selectedColor: _PickColors.blue,
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: _PickColors.line),
                            labelStyle: TextStyle(
                              color: _building == building
                                  ? Colors.white
                                  : _PickColors.sub,
                              fontWeight: FontWeight.w800,
                            ),
                            onSelected: (_) => setState(() {
                              _building = building;
                              _selected = null;
                              _query = '';
                              _searchController.clear();
                            }),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ['B1', '1F', '2F', '3F', '4F', '5F']
                      .map(
                        (floor) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(floor),
                            selected: _floor == floor,
                            selectedColor: _PickColors.blue,
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: _PickColors.line),
                            labelStyle: TextStyle(
                              color: _floor == floor
                                  ? Colors.white
                                  : _PickColors.sub,
                              fontWeight: FontWeight.w800,
                            ),
                            onSelected: (_) => setState(() {
                              _floor = floor;
                              _selected = null;
                              _query = '';
                              _searchController.clear();
                            }),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 14),
              _PickCard(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 390,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final visible = _visibleMapLocations;
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CustomPaint(
                                painter: _FloorPlanPainter(
                                  selected: _selected,
                                  locations: visible,
                                ),
                              ),
                            ),
                          ),
                          for (final location in visible)
                            Positioned(
                              left: (constraints.maxWidth - 38) * location.x,
                              top: (constraints.maxHeight - 44) * location.y,
                              child: Tooltip(
                                message: '${location.room} ${location.name}',
                                child: InkWell(
                                  onTap: () => setState(() => _selected = location),
                                  borderRadius: BorderRadius.circular(999),
                                  child: Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: _selected == location
                                          ? _PickColors.orange
                                          : _PickColors.blue,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x33000000),
                                          blurRadius: 8,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 21,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Positioned(
                            left: 12,
                            top: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x160F2F6E),
                                    blurRadius: 12,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Text(
                                '$_building · $_floor',
                                style: const TextStyle(
                                  color: _PickColors.darkBlue,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            right: 12,
                            bottom: 12,
                            child: _MapControlRail(),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),
              if (_selected != null)
                _RouteResultCard(
                  location: _selected!,
                  onClear: () => setState(() => _selected = null),
                )
              else ...[
                const Text(
                  '검색 결과',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                if (_results.isEmpty)
                  const _EmptyResult()
                else
                  ..._results.map(
                    (location) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _LocationResultTile(
                        location: location,
                        onTap: () => setState(() {
                          _selected = location;
                          _building = location.building;
                          _floor = location.floor;
                        }),
                      ),
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

class ShuttlePickupScreen extends StatefulWidget {
  const ShuttlePickupScreen({super.key, this.dataSource = const MockMobilityDataSource()});

  final MobilityDataSource dataSource;

  @override
  State<ShuttlePickupScreen> createState() => _ShuttlePickupScreenState();
}

class _ShuttlePickupScreenState extends State<ShuttlePickupScreen> {
  int _selectedStop = 0;
  bool _reserved = false;

  @override
  Widget build(BuildContext context) {
    final stop = widget.dataSource.campusStops[_selectedStop];
    return Scaffold(
      backgroundColor: _PickColors.bg,
      appBar: _appBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '자율주행 픽업',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              Text(
                '가장 가까운 정류장은 ${stop.name}, 도보 ${stop.walkMinutes}분이에요.',
                style: const TextStyle(
                  color: _PickColors.sub,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              _PickCard(
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 280,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CustomPaint(
                      painter: const _CampusRoutePainter(),
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 28,
                            bottom: 34,
                            child: _MapMarker(label: '현재 위치', color: _PickColors.blue),
                          ),
                          Positioned(
                            right: 28,
                            top: 34,
                            child: _MapMarker(label: stop.name, color: _PickColors.green),
                          ),
                          const Positioned(
                            left: 150,
                            top: 104,
                            child: _VehiclePod(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _PickCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const _VehiclePod(size: 72),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '도착 예정 ${stop.etaMinutes}분',
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '탑승 가능 좌석 6 / 8',
                                style: TextStyle(
                                  color: _PickColors.sub,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    LinearProgressIndicator(
                      value: 0.68,
                      minHeight: 9,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                '정류장 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              ...widget.dataSource.campusStops.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 9),
                      child: RadioListTile<int>(
                        value: entry.key,
                        groupValue: _selectedStop,
                        onChanged: _reserved
                            ? null
                            : (value) => setState(() => _selectedStop = value ?? 0),
                        title: Text(
                          entry.value.name,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                        subtitle: Text(
                          '${entry.value.detail} · ${entry.value.distanceMeters}m',
                        ),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(color: _PickColors.line),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: () {
                    setState(() => _reserved = !_reserved);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _reserved
                              ? '${stop.name} 픽업을 예약했습니다.'
                              : '픽업 예약을 취소했습니다.',
                        ),
                      ),
                    );
                  },
                  icon: Icon(_reserved ? Icons.close : Icons.event_seat),
                  label: Text(
                    _reserved ? '예약 취소' : '픽업 예약',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const _SimulationNotice(),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryRobotScreen extends StatefulWidget {
  const DeliveryRobotScreen({super.key, this.dataSource = const MockMobilityDataSource()});

  final MobilityDataSource dataSource;

  @override
  State<DeliveryRobotScreen> createState() => _DeliveryRobotScreenState();
}

class _DeliveryRobotScreenState extends State<DeliveryRobotScreen> {
  static const _parcelTypes = [
    ('일반 택배', Icons.inventory_2_outlined),
    ('도서', Icons.menu_book_outlined),
    ('서류 / 문서', Icons.description_outlined),
    ('기타 물품', Icons.widgets_outlined),
  ];
  static const _trackingSteps = [
    '배송 접수 완료',
    '로봇 출발',
    '배송 중',
    '도착 예정',
    '배송 완료',
  ];

  int _parcelIndex = 0;
  int _trackingIndex = 0;
  String? _destination;
  Timer? _timer;

  bool get _tracking => _destination != null && _trackingIndex > 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startDelivery() {
    if (_destination == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('배송지를 먼저 선택해주세요.')),
      );
      return;
    }
    _timer?.cancel();
    setState(() => _trackingIndex = 1);
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted || _trackingIndex >= _trackingSteps.length - 1) {
        timer.cancel();
        return;
      }
      setState(() => _trackingIndex += 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _PickColors.bg,
      appBar: _appBar(),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '자율배송',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 6),
              const Text(
                '배송지와 물품을 선택하고 로봇의 운행상태를 확인해요.',
                style: TextStyle(
                  color: _PickColors.sub,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _destination,
                decoration: _inputDecoration(
                  hint: '배송지 선택',
                  icon: Icons.location_on_outlined,
                ),
                items: widget.dataSource.deliveryDestinations
                    .map(
                      (destination) => DropdownMenuItem(
                        value: destination,
                        child: Text(destination),
                      ),
                    )
                    .toList(),
                onChanged: _tracking
                    ? null
                    : (value) => setState(() => _destination = value),
              ),
              const SizedBox(height: 18),
              const Text(
                '배송 물품 선택',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _parcelTypes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.65,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final selected = index == _parcelIndex;
                  return InkWell(
                    onTap: _tracking ? null : () => setState(() => _parcelIndex = index),
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: selected ? _PickColors.lightBlue : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected ? _PickColors.blue : _PickColors.line,
                          width: selected ? 1.6 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(_parcelTypes[index].$2, color: _PickColors.blue),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              _parcelTypes[index].$1,
                              style: const TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              _PickCard(
                child: Row(
                  children: [
                    const _DeliveryBot(size: 94),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _tracking ? '로봇 운행 중' : '로봇 대기 중',
                            style: TextStyle(
                              color: _tracking ? _PickColors.green : _PickColors.sub,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _tracking ? '도착 예정 8분' : '배송 요청을 대기하고 있어요.',
                            style: const TextStyle(
                              color: _PickColors.sub,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              if (_tracking) ...[
                const Text(
                  '배송 추적',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 10),
                _PickCard(
                  child: Column(
                    children: List.generate(_trackingSteps.length, (index) {
                      final completed = index <= _trackingIndex;
                      final active = index == _trackingIndex;
                      return _TrackingStep(
                        label: _trackingSteps[index],
                        completed: completed,
                        active: active,
                        isLast: index == _trackingSteps.length - 1,
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 14),
              ],
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: _tracking ? null : _startDelivery,
                  icon: const Icon(Icons.local_shipping_outlined),
                  label: Text(
                    _tracking ? '배송 진행 중' : '자율배송 요청',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const _SimulationNotice(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader({this.showBackButton = false});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBackButton) ...[
          IconButton.filledTonal(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.2,
              ),
              children: [
                TextSpan(
                  text: '배재Pick ',
                  style: TextStyle(color: _PickColors.darkBlue),
                ),
                TextSpan(
                  text: '2.0',
                  style: TextStyle(color: _PickColors.blue),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('새로운 알림이 없어요.')),
          ),
          icon: const Icon(Icons.notifications_none_rounded, size: 29),
        ),
        const SizedBox(width: 6),
        const _MobilityMascot(size: 46),
      ],
    );
  }
}

class _MobilityHero extends StatelessWidget {
  const _MobilityHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 224,
      padding: const EdgeInsets.fromLTRB(22, 22, 14, 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3488F4), Color(0xFF1164E8)],
        ),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -18,
            bottom: -36,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.10),
              ),
            ),
          ),
          const Positioned(
            right: 18,
            top: 30,
            child: _MobilityMascot(size: 112),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '오늘의 Smart Pick',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '캠퍼스를\n더 가깝게!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  height: 1.24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.route_rounded, color: Colors.white, size: 18),
                    SizedBox(width: 7),
                    Text(
                      '스마트맵 · 픽업 · 배송',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MobilityFeatureCard extends StatelessWidget {
  const _MobilityFeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _PickCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.11),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, color: color, size: 27),
                ),
                const Spacer(),
                _smallBadge(badge, color),
              ],
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                color: _PickColors.text,
                fontSize: 17,
                fontWeight: FontWeight.w900,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              maxLines: 2,
              style: const TextStyle(
                color: _PickColors.sub,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobilityWideCard extends StatelessWidget {
  const _MobilityWideCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _PickCard(
      onTap: onTap,
      child: const Row(
        children: [
          _DeliveryBot(size: 86),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '자율배송',
                        style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Icon(Icons.chevron_right, color: _PickColors.blue),
                  ],
                ),
                SizedBox(height: 7),
                Text(
                  '배송지를 선택하고 로봇 운행상태를 확인해요.',
                  style: TextStyle(
                    color: _PickColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.45,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'ROS2 연동 예정',
                  style: TextStyle(
                    color: _PickColors.purple,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureEntry extends StatelessWidget {
  const _FeatureEntry({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _PickCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                      ),
                    ),
                    _smallBadge(badge, color),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: _PickColors.sub,
                    fontWeight: FontWeight.w700,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, color: _PickColors.sub),
        ],
      ),
    );
  }
}

class _LocationResultTile extends StatelessWidget {
  const _LocationResultTile({required this.location, required this.onTap});

  final IndoorLocation location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _PickCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: _PickColors.lightBlue,
            child: Icon(Icons.location_on_outlined, color: _PickColors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${location.room} · ${location.name}',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  '${location.building} ${location.floor} · ${location.typeLabel}',
                  style: const TextStyle(
                    color: _PickColors.sub,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.directions, color: _PickColors.blue),
        ],
      ),
    );
  }
}

class _RouteResultCard extends StatelessWidget {
  const _RouteResultCard({required this.location, required this.onClear});

  final IndoorLocation location;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return _PickCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: _PickColors.lightBlue,
                child: Icon(Icons.directions_walk, color: _PickColors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${location.room} · ${location.name}',
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${location.building} ${location.floor} · 120m · 약 2분',
                      style: const TextStyle(
                        color: _PickColors.sub,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: onClear, icon: const Icon(Icons.close)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${location.name}까지 실내 길안내를 시작합니다.')),
                );
              },
              icon: const Icon(Icons.navigation),
              label: const Text('길찾기', style: TextStyle(fontWeight: FontWeight.w900)),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackingStep extends StatelessWidget {
  const _TrackingStep({
    required this.label,
    required this.completed,
    required this.active,
    required this.isLast,
  });

  final String label;
  final bool completed;
  final bool active;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = completed ? _PickColors.green : _PickColors.line;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 28,
          child: Column(
            children: [
              Icon(
                active ? Icons.radio_button_checked : Icons.check_circle,
                color: color,
                size: 20,
              ),
              if (!isLast) Container(width: 2, height: 34, color: color),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1, bottom: 24),
            child: Text(
              label,
              style: TextStyle(
                color: active ? _PickColors.blue : _PickColors.text,
                fontWeight: active ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ),
        ),
        if (active)
          const Text(
            '현재',
            style: TextStyle(color: _PickColors.blue, fontWeight: FontWeight.w900),
          ),
      ],
    );
  }
}

class _PickCard extends StatelessWidget {
  const _PickCard({
    required this.child,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(18),
    this.onTap,
  });

  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color == Colors.white ? _PickColors.line : color),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120F2F6E),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
    if (onTap == null) return card;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: card,
    );
  }
}

class _FeatureHeader extends StatelessWidget {
  const _FeatureHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: const TextStyle(
            color: _PickColors.sub,
            fontWeight: FontWeight.w700,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}

class _MobilityMascot extends StatelessWidget {
  const _MobilityMascot({this.size = 72});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: const _TigerMascotPainter(),
      ),
    );
  }
}

class _VehiclePod extends StatelessWidget {
  const _VehiclePod({this.size = 62});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 0.72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.25),
        border: Border.all(color: _PickColors.blue, width: 4),
        boxShadow: const [
          BoxShadow(color: Color(0x22000000), blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: size * 0.14,
            right: size * 0.14,
            top: size * 0.12,
            child: Container(
              height: size * 0.25,
              decoration: BoxDecoration(
                color: _PickColors.darkBlue,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Positioned(
            left: size * 0.12,
            bottom: -2,
            child: _wheel(size),
          ),
          Positioned(
            right: size * 0.12,
            bottom: -2,
            child: _wheel(size),
          ),
        ],
      ),
    );
  }

  Widget _wheel(double size) => Container(
        width: size * 0.16,
        height: size * 0.16,
        decoration: const BoxDecoration(color: _PickColors.text, shape: BoxShape.circle),
      );
}

class _DeliveryBot extends StatelessWidget {
  const _DeliveryBot({this.size = 88});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _PickColors.lightBlue,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.58,
            height: size * 0.66,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: _PickColors.blue, width: 3),
            ),
          ),
          Positioned(
            top: size * 0.30,
            child: Container(
              width: size * 0.38,
              height: size * 0.22,
              decoration: BoxDecoration(
                color: _PickColors.darkBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text('• •', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
            ),
          ),
          Positioned(
            top: size * 0.08,
            child: Container(
              width: 6,
              height: size * 0.18,
              color: _PickColors.darkBlue,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapMarker extends StatelessWidget {
  const _MapMarker({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Color(0x22000000), blurRadius: 8, offset: Offset(0, 4)),
            ],
          ),
          child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900)),
        ),
        Icon(Icons.location_on, color: color, size: 34),
      ],
    );
  }
}

class _MapControlRail extends StatelessWidget {
  const _MapControlRail();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A0F2F6E),
                blurRadius: 12,
                offset: Offset(0, 5),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            '3D',
            style: TextStyle(
              color: _PickColors.blue,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A0F2F6E),
                blurRadius: 12,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: const Column(
            children: [
              SizedBox(
                width: 46,
                height: 42,
                child: Icon(Icons.add, color: _PickColors.darkBlue),
              ),
              Divider(height: 1, color: _PickColors.line),
              SizedBox(
                width: 46,
                height: 42,
                child: Icon(Icons.remove, color: _PickColors.darkBlue),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SimulationNotice extends StatelessWidget {
  const _SimulationNotice();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _PickColors.lightBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.science_outlined, color: _PickColors.blue, size: 20),
          SizedBox(width: 9),
          Expanded(
            child: Text(
              '현재 화면은 데모 데이터로 작동하는 시뮬레이션입니다. 실제 예약·운행을 수행하지 않습니다.',
              style: TextStyle(
                color: _PickColors.sub,
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

class _EmptyResult extends StatelessWidget {
  const _EmptyResult();

  @override
  Widget build(BuildContext context) {
    return _PickCard(
      child: Column(
        children: const [
          Icon(Icons.search_off, color: _PickColors.sub, size: 36),
          SizedBox(height: 10),
          Text('검색 결과가 없습니다.', style: TextStyle(fontWeight: FontWeight.w900)),
          SizedBox(height: 5),
          Text(
            '호실, 학과, 교수명을 다른 표현으로 검색해보세요.',
            style: TextStyle(color: _PickColors.sub, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _FloorPlanPainter extends CustomPainter {
  const _FloorPlanPainter({required this.selected, required this.locations});

  final IndoorLocation? selected;
  final List<IndoorLocation> locations;

  @override
  void paint(Canvas canvas, Size size) {
    final background = Paint()..color = const Color(0xFFEAF4FF);
    canvas.drawRect(Offset.zero & size, background);

    final roomPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = const Color(0xFFBFD7F5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final corridorPaint = Paint()
      ..color = const Color(0xFFD6E8FB)
      ..strokeWidth = 34
      ..strokeCap = StrokeCap.round;

    final corridor = Path()
      ..moveTo(size.width * 0.12, size.height * 0.82)
      ..lineTo(size.width * 0.12, size.height * 0.52)
      ..lineTo(size.width * 0.52, size.height * 0.52)
      ..lineTo(size.width * 0.52, size.height * 0.20)
      ..lineTo(size.width * 0.86, size.height * 0.20);
    canvas.drawPath(corridor, corridorPaint);

    final rooms = <Rect>[
      Rect.fromLTWH(size.width * 0.08, size.height * 0.10, size.width * 0.24, size.height * 0.22),
      Rect.fromLTWH(size.width * 0.37, size.height * 0.10, size.width * 0.22, size.height * 0.25),
      Rect.fromLTWH(size.width * 0.65, size.height * 0.10, size.width * 0.25, size.height * 0.25),
      Rect.fromLTWH(size.width * 0.12, size.height * 0.62, size.width * 0.25, size.height * 0.23),
      Rect.fromLTWH(size.width * 0.45, size.height * 0.62, size.width * 0.20, size.height * 0.23),
      Rect.fromLTWH(size.width * 0.70, size.height * 0.60, size.width * 0.22, size.height * 0.25),
    ];
    for (final room in rooms) {
      final rounded = RRect.fromRectAndRadius(room, const Radius.circular(10));
      canvas.drawRRect(rounded, roomPaint);
      canvas.drawRRect(rounded, borderPaint);
    }

    if (selected != null) {
      final routePaint = Paint()
        ..color = _PickColors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;
      final route = Path()
        ..moveTo(size.width * 0.10, size.height * 0.92)
        ..lineTo(size.width * 0.10, size.height * 0.52)
        ..lineTo(size.width * selected!.x, size.height * 0.52)
        ..lineTo(size.width * selected!.x, size.height * selected!.y);
      canvas.drawPath(route, routePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _FloorPlanPainter oldDelegate) {
    return oldDelegate.selected != selected || oldDelegate.locations != locations;
  }
}

class _CampusRoutePainter extends CustomPainter {
  const _CampusRoutePainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFFE8F3FF));
    final buildingPaint = Paint()..color = Colors.white;
    for (final rect in [
      Rect.fromLTWH(size.width * 0.08, size.height * 0.10, 86, 58),
      Rect.fromLTWH(size.width * 0.64, size.height * 0.12, 96, 72),
      Rect.fromLTWH(size.width * 0.12, size.height * 0.68, 110, 64),
      Rect.fromLTWH(size.width * 0.66, size.height * 0.66, 92, 56),
    ]) {
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(12)), buildingPaint);
    }
    final roadPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 26
      ..strokeCap = StrokeCap.round;
    final route = Path()
      ..moveTo(size.width * 0.18, size.height * 0.78)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.50,
        size.width * 0.58,
        size.height * 0.56,
        size.width * 0.78,
        size.height * 0.24,
      );
    canvas.drawPath(route, roadPaint);
    final blueRoute = Paint()
      ..color = _PickColors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(route, blueRoute);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TigerMascotPainter extends CustomPainter {
  const _TigerMascotPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.shortestSide;
    final orange = Paint()..color = const Color(0xFFFFA51F);
    final dark = Paint()..color = const Color(0xFF3A2418);
    final white = Paint()..color = Colors.white;
    final navy = Paint()..color = _PickColors.darkBlue;
    final blue = Paint()..color = _PickColors.blue;

    canvas.drawCircle(
      Offset(scale * 0.27, scale * 0.24),
      scale * 0.15,
      orange,
    );
    canvas.drawCircle(
      Offset(scale * 0.73, scale * 0.24),
      scale * 0.15,
      orange,
    );
    canvas.drawCircle(
      Offset(scale * 0.27, scale * 0.24),
      scale * 0.07,
      white,
    );
    canvas.drawCircle(
      Offset(scale * 0.73, scale * 0.24),
      scale * 0.07,
      white,
    );

    final faceRect = Rect.fromCenter(
      center: Offset(scale * 0.5, scale * 0.47),
      width: scale * 0.72,
      height: scale * 0.68,
    );
    canvas.drawOval(faceRect, orange);

    final jacketRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(scale * 0.19, scale * 0.68, scale * 0.62, scale * 0.28),
      Radius.circular(scale * 0.14),
    );
    canvas.drawRRect(jacketRect, navy);

    canvas.drawCircle(
      Offset(scale * 0.37, scale * 0.44),
      scale * 0.045,
      dark,
    );
    canvas.drawCircle(
      Offset(scale * 0.63, scale * 0.44),
      scale * 0.045,
      dark,
    );
    canvas.drawCircle(
      Offset(scale * 0.5, scale * 0.56),
      scale * 0.16,
      white,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(scale * 0.5, scale * 0.52),
        width: scale * 0.13,
        height: scale * 0.09,
      ),
      dark,
    );

    final smile = Path()
      ..moveTo(scale * 0.5, scale * 0.57)
      ..quadraticBezierTo(
        scale * 0.44,
        scale * 0.63,
        scale * 0.39,
        scale * 0.58,
      )
      ..moveTo(scale * 0.5, scale * 0.57)
      ..quadraticBezierTo(
        scale * 0.56,
        scale * 0.63,
        scale * 0.61,
        scale * 0.58,
      );
    canvas.drawPath(
      smile,
      Paint()
        ..color = const Color(0xFF3A2418)
        ..style = PaintingStyle.stroke
        ..strokeWidth = scale * 0.025
        ..strokeCap = StrokeCap.round,
    );

    for (final x in [0.38, 0.50, 0.62]) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            scale * x - scale * 0.025,
            scale * 0.16,
            scale * 0.05,
            scale * 0.15,
          ),
          Radius.circular(scale * 0.02),
        ),
        dark,
      );
    }

    final stripePaint = Paint()
      ..color = const Color(0xFF3A2418)
      ..style = PaintingStyle.stroke
      ..strokeWidth = scale * 0.035
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(scale * 0.18, scale * 0.42),
      Offset(scale * 0.29, scale * 0.46),
      stripePaint,
    );
    canvas.drawLine(
      Offset(scale * 0.82, scale * 0.42),
      Offset(scale * 0.71, scale * 0.46),
      stripePaint,
    );

    canvas.drawCircle(
      Offset(scale * 0.5, scale * 0.82),
      scale * 0.095,
      white,
    );
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'P',
        style: TextStyle(
          color: _PickColors.blue,
          fontSize: scale * 0.13,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(
      canvas,
      Offset(
        scale * 0.5 - textPainter.width / 2,
        scale * 0.82 - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PickColors {
  static const blue = Color(0xFF2563EB);
  static const lightBlue = Color(0xFFEAF4FF);
  static const darkBlue = Color(0xFF0F2F6E);
  static const green = Color(0xFF10B981);
  static const orange = Color(0xFFF59E0B);
  static const purple = Color(0xFF7C3AED);
  static const bg = Color(0xFFF8FAFC);
  static const text = Color(0xFF111827);
  static const sub = Color(0xFF6B7280);
  static const line = Color(0xFFE5E7EB);
}

PreferredSizeWidget _appBar() {
  return AppBar(
    backgroundColor: _PickColors.bg,
    toolbarHeight: 76,
    titleSpacing: 4,
    title: RichText(
      text: const TextSpan(
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
        children: [
          TextSpan(
            text: '배재Pick ',
            style: TextStyle(color: _PickColors.darkBlue),
          ),
          TextSpan(
            text: '2.0',
            style: TextStyle(color: _PickColors.blue),
          ),
        ],
      ),
    ),
    actions: const [
      Icon(Icons.notifications_none_rounded, size: 28),
      SizedBox(width: 10),
      Center(child: _MobilityMascot(size: 44)),
      SizedBox(width: 18),
    ],
    centerTitle: false,
    surfaceTintColor: Colors.transparent,
  );
}

InputDecoration _inputDecoration({required String hint, required IconData icon}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: _PickColors.line),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: _PickColors.line),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: _PickColors.blue, width: 1.6),
    ),
  );
}

Widget _statusPill(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.18),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

Widget _smallBadge(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color.withOpacity(0.10),
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900),
    ),
  );
}
