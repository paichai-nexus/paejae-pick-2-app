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
          name: '컴퓨터공학과 사무실',
          type: IndoorLocationType.departmentOffice,
          x: 0.22,
          y: 0.68,
        ),
        IndoorLocation(
          building: '정보과학관',
          floor: '4F',
          room: 'C413',
          name: '김OO 교수연구실',
          type: IndoorLocationType.professorOffice,
          x: 0.74,
          y: 0.72,
        ),
        IndoorLocation(
          building: '정보과학관',
          floor: '4F',
          room: 'C401',
          name: '컴퓨터공학 강의실',
          type: IndoorLocationType.classroom,
          x: 0.76,
          y: 0.27,
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
          name: '정문',
          detail: '정문 자율주행 승강장',
          etaMinutes: 4,
          walkMinutes: 1,
          distanceMeters: 40,
        ),
        CampusStop(
          name: '배재21세기관',
          detail: '정문 앞 승강장',
          etaMinutes: 7,
          walkMinutes: 5,
          distanceMeters: 310,
        ),
        CampusStop(
          name: '중앙도서관',
          detail: '도서관 정문 앞',
          etaMinutes: 9,
          walkMinutes: 4,
          distanceMeters: 380,
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
        '중앙도서관 정문 수령존',
        '배재21세기관 1층 로비',
        '국제교류관 1층',
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
                  title: '3D 실내 길찾기',
                  subtitle: '강의실·학과사무실·교수연구실',
                  badge: '개발 중',
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
                  title: '교내 순환차량',
                  subtitle: '위치 확인·픽업 예약',
                  badge: '개발 예정',
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
  String _searchMode = '건물';
  String _building = '정보과학관';
  String _floor = '4F';
  IndoorLocation? _selected;

  @override
  void initState() {
    super.initState();
    final defaults = widget.dataSource.indoorLocations.where(
      (location) =>
          location.building == '정보과학관' &&
          location.floor == '4F' &&
          location.room == 'C401',
    );
    if (defaults.isNotEmpty) {
      _selected = defaults.first;
    }
  }

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
                '3D 실내 길찾기',
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
                onChanged: (value) => setState(() {
                  _query = value;
                  if (value.trim().isNotEmpty) {
                    _selected = null;
                  }
                }),
                decoration: _inputDecoration(
                  hint: '건물·호실·교수명을 검색하세요',
                  icon: Icons.search,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['건물', '호실', '교수']
                    .map(
                      (mode) => ChoiceChip(
                        avatar: Icon(
                          switch (mode) {
                            '건물' => Icons.apartment_rounded,
                            '호실' => Icons.meeting_room_rounded,
                            _ => Icons.person_search_rounded,
                          },
                          size: 17,
                          color: _searchMode == mode
                              ? Colors.white
                              : _PickColors.sub,
                        ),
                        label: Text(mode),
                        selected: _searchMode == mode,
                        selectedColor: _PickColors.blue,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: _PickColors.line),
                        labelStyle: TextStyle(
                          color: _searchMode == mode
                              ? Colors.white
                              : _PickColors.sub,
                          fontWeight: FontWeight.w800,
                        ),
                        onSelected: (_) => setState(() => _searchMode = mode),
                      ),
                    )
                    .toList(),
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
                  height: 430,
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
  int _pickupStop = 0;
  int _destinationStop = 3;
  int _passengers = 1;
  bool _reserved = false;

  @override
  Widget build(BuildContext context) {
    final pickup = widget.dataSource.campusStops[_pickupStop];
    final destination = widget.dataSource.campusStops[_destinationStop];
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
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      '교내 순환차량',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ),
                  _smallBadge('개발 예정', _PickColors.blue),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                '캠퍼스 안을 순환하는 자율주행 차량을 예약해요.',
                style: TextStyle(
                  color: _PickColors.sub,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
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
                            left: 18,
                            bottom: 26,
                            child: _MapMarker(label: '정문', color: _PickColors.blue),
                          ),
                          const Positioned(
                            left: 91,
                            bottom: 102,
                            child: _MapMarker(
                              label: '21세기관',
                              color: _PickColors.purple,
                            ),
                          ),
                          const Positioned(
                            right: 92,
                            top: 94,
                            child: _MapMarker(
                              label: '중앙도서관',
                              color: _PickColors.orange,
                            ),
                          ),
                          const Positioned(
                            right: 18,
                            top: 25,
                            child: _MapMarker(
                              label: '국제교류관',
                              color: _PickColors.green,
                            ),
                          ),
                          const Positioned(
                            left: 150,
                            top: 110,
                            child: _VehiclePod(size: 64),
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
                    const Text(
                      '이동 경로',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    _StopDropdown(
                      label: '탑승 정류장',
                      icon: Icons.my_location_rounded,
                      color: _PickColors.blue,
                      selectedIndex: _pickupStop,
                      stops: widget.dataSource.campusStops,
                      enabled: !_reserved,
                      onChanged: (value) => setState(() {
                        _pickupStop = value;
                        if (_destinationStop == value) {
                          _destinationStop =
                              (value + 1) % widget.dataSource.campusStops.length;
                        }
                      }),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 22,
                        child: VerticalDivider(
                          width: 2,
                          thickness: 2,
                          color: _PickColors.line,
                        ),
                      ),
                    ),
                    _StopDropdown(
                      label: '도착 정류장',
                      icon: Icons.flag_rounded,
                      color: _PickColors.green,
                      selectedIndex: _destinationStop,
                      stops: widget.dataSource.campusStops,
                      enabled: !_reserved,
                      onChanged: (value) {
                        if (value == _pickupStop) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('도착지는 탑승지와 달라야 해요.')),
                          );
                          return;
                        }
                        setState(() => _destinationStop = value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _PickCard(
                child: Row(
                  children: [
                    const _VehiclePod(size: 70),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '다음 차량 ${pickup.etaMinutes}분 후 도착',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${pickup.name} → ${destination.name} · 빈자리 6',
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
              const SizedBox(height: 14),
              _PickCard(
                child: Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '탑승 인원',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '최대 4명까지 예약할 수 있어요.',
                            style: TextStyle(
                              color: _PickColors.sub,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: !_reserved && _passengers > 1
                          ? () => setState(() => _passengers -= 1)
                          : null,
                      icon: const Icon(Icons.remove),
                    ),
                    SizedBox(
                      width: 42,
                      child: Text(
                        '$_passengers',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                      ),
                    ),
                    IconButton.filled(
                      onPressed: !_reserved && _passengers < 4
                          ? () => setState(() => _passengers += 1)
                          : null,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
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
                              ? '${pickup.name}에서 ${destination.name}까지 $_passengers명 픽업을 예약했습니다.'
                              : '픽업 예약을 취소했습니다.',
                        ),
                      ),
                    );
                  },
                  icon: Icon(_reserved ? Icons.close : Icons.event_seat),
                  label: Text(
                    _reserved ? '예약 취소' : '픽업 예약하기',
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  '예약 후 3분 이내에 승강장에 도착해주세요.',
                  style: TextStyle(
                    color: _PickColors.sub,
                    fontWeight: FontWeight.w700,
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

class _StopDropdown extends StatelessWidget {
  const _StopDropdown({
    required this.label,
    required this.icon,
    required this.color,
    required this.selectedIndex,
    required this.stops,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final Color color;
  final int selectedIndex;
  final List<CampusStop> stops;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _PickColors.sub,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedIndex,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: stops
                      .asMap()
                      .entries
                      .map(
                        (entry) => DropdownMenuItem<int>(
                          value: entry.key,
                          child: Text(
                            entry.value.name,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: enabled
                      ? (value) {
                          if (value != null) onChanged(value);
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
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
  static const _trackingSteps = [
    '호출 접수',
    '로봇 배정',
    '배송 중',
    '도착',
  ];

  int _trackingIndex = 2;
  String _pickup = '정보과학관 1층 로비';
  String _destination = '국제교류관 1층';
  Timer? _timer;

  bool get _tracking => _trackingIndex > 0 && _trackingIndex < 3;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startDelivery() {
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

  void _handlePrimaryAction() {
    if (_trackingIndex == 0) {
      _startDelivery();
      return;
    }
    if (_trackingIndex == _trackingSteps.length - 1) {
      _timer?.cancel();
      setState(() => _trackingIndex = 0);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'NEXUS-01이 $_pickup에서 $_destination(으)로 이동 중입니다.',
        ),
      ),
    );
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
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      '자율배송',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ),
                  _smallBadge('ROS2 연동 예정', _PickColors.purple),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                '로봇을 호출하고 배송지와 실시간 운행상태를 확인해요.',
                style: TextStyle(
                  color: _PickColors.sub,
                  fontWeight: FontWeight.w700,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),
              _PickCard(
                color: _PickColors.lightBlue,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const _DeliveryBot(size: 112),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '배송로봇 NEXUS-01',
                                style: TextStyle(
                                  color: _PickColors.darkBlue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                _trackingSteps[_trackingIndex],
                                style: const TextStyle(
                                  color: _PickColors.green,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.schedule_rounded,
                                    size: 17,
                                    color: _PickColors.sub,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '도착 예정 8분',
                                    style: TextStyle(
                                      color: _PickColors.sub,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.battery_5_bar_rounded,
                                    size: 17,
                                    color: _PickColors.green,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    '배터리 82%',
                                    style: TextStyle(
                                      color: _PickColors.sub,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _DeliveryProgress(
                      steps: _trackingSteps,
                      currentIndex: _trackingIndex,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _PickCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '배송 경로',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    _DeliveryRouteDropdown(
                      label: '보낼 곳',
                      icon: Icons.inventory_2_rounded,
                      color: _PickColors.blue,
                      value: _pickup,
                      places: widget.dataSource.deliveryDestinations,
                      enabled: !_tracking,
                      onChanged: (value) => setState(() => _pickup = value),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          width: 2,
                          thickness: 2,
                          color: _PickColors.line,
                        ),
                      ),
                    ),
                    _DeliveryRouteDropdown(
                      label: '받을 곳',
                      icon: Icons.location_on_rounded,
                      color: _PickColors.green,
                      value: _destination,
                      places: widget.dataSource.deliveryDestinations,
                      enabled: !_tracking,
                      onChanged: (value) {
                        if (value == _pickup) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('보낼 곳과 받을 곳은 달라야 해요.'),
                            ),
                          );
                          return;
                        }
                        setState(() => _destination = value);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _PickCard(
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: CustomPaint(
                      painter: const _CampusRoutePainter(),
                      child: const Stack(
                        children: [
                          Positioned(
                            left: 22,
                            bottom: 27,
                            child: _MapMarker(
                              label: '정보과학관',
                              color: _PickColors.blue,
                            ),
                          ),
                          Positioned(
                            right: 18,
                            top: 26,
                            child: _MapMarker(
                              label: '국제교류관',
                              color: _PickColors.green,
                            ),
                          ),
                          Positioned(
                            left: 145,
                            top: 83,
                            child: _DeliveryBot(size: 64),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: _handlePrimaryAction,
                  icon: const Icon(Icons.local_shipping_outlined),
                  label: Text(
                    switch (_trackingIndex) {
                      0 => '자율배송 호출하기',
                      3 => '새 배송 요청',
                      _ => '배송 상태 확인',
                    },
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _PickCard(
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _PickColors.lightBlue,
                      child: Icon(
                        Icons.support_agent_rounded,
                        color: _PickColors.blue,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '운영센터',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '운행 중 문제가 있으면 안전 관제에 연락해주세요.',
                            style: TextStyle(
                              color: _PickColors.sub,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right_rounded, color: _PickColors.blue),
                  ],
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

class _DeliveryRouteDropdown extends StatelessWidget {
  const _DeliveryRouteDropdown({
    required this.label,
    required this.icon,
    required this.color,
    required this.value,
    required this.places,
    required this.enabled,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final Color color;
  final String value;
  final List<String> places;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: _PickColors.sub,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: places
                      .map(
                        (place) => DropdownMenuItem<String>(
                          value: place,
                          child: Text(
                            place,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: enabled
                      ? (newValue) {
                          if (newValue != null) onChanged(newValue);
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeliveryProgress extends StatelessWidget {
  const _DeliveryProgress({required this.steps, required this.currentIndex});

  final List<String> steps;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length, (index) {
        final active = index <= currentIndex;
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: active ? _PickColors.blue : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: active ? _PickColors.blue : _PickColors.line,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        index < currentIndex ? Icons.check : Icons.circle,
                        color: active ? Colors.white : _PickColors.line,
                        size: index < currentIndex ? 17 : 9,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index == currentIndex
                            ? _PickColors.blue
                            : _PickColors.sub,
                        fontSize: 11,
                        fontWeight: index == currentIndex
                            ? FontWeight.w900
                            : FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              if (index < steps.length - 1)
                Container(
                  width: 12,
                  height: 2,
                  margin: const EdgeInsets.only(top: 13),
                  color: index < currentIndex
                      ? _PickColors.blue
                      : _PickColors.line,
                ),
            ],
          ),
        );
      }),
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
                      '${location.name} ${location.room}',
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${location.building} ${location.floor} · 도보 3분',
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
              label: const Text(
                '길찾기 시작',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
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

    final floorShadow = Path()
      ..moveTo(size.width * 0.06, size.height * 0.24)
      ..lineTo(size.width * 0.84, size.height * 0.08)
      ..lineTo(size.width * 0.96, size.height * 0.72)
      ..lineTo(size.width * 0.16, size.height * 0.92)
      ..close();
    canvas.drawPath(floorShadow, Paint()..color = const Color(0x332563EB));

    final floor = Path()
      ..moveTo(size.width * 0.05, size.height * 0.20)
      ..lineTo(size.width * 0.84, size.height * 0.04)
      ..lineTo(size.width * 0.95, size.height * 0.68)
      ..lineTo(size.width * 0.15, size.height * 0.88)
      ..close();
    canvas.drawPath(floor, Paint()..color = const Color(0xFFF8FBFF));

    final corridor = Path()
      ..moveTo(size.width * 0.13, size.height * 0.50)
      ..lineTo(size.width * 0.86, size.height * 0.34)
      ..lineTo(size.width * 0.89, size.height * 0.52)
      ..lineTo(size.width * 0.17, size.height * 0.70)
      ..close();
    canvas.drawPath(corridor, Paint()..color = const Color(0xFFDCEBFA));

    final roomPaint = Paint()..color = Colors.white;
    final roomSidePaint = Paint()..color = const Color(0xFFBFD7F5);
    final borderPaint = Paint()
      ..color = const Color(0xFF9CC2EE)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    void drawRoom(
      Rect room,
      String label, {
      bool desks = false,
      IconData? icon,
    }) {
      final rounded = RRect.fromRectAndRadius(room, const Radius.circular(9));
      canvas.drawRRect(rounded.shift(const Offset(0, 9)), roomSidePaint);
      canvas.drawRRect(rounded, roomPaint);
      canvas.drawRRect(rounded, borderPaint);

      if (desks) {
        final deskPaint = Paint()..color = const Color(0xFFC9DCF3);
        for (var row = 0; row < 2; row++) {
          for (var column = 0; column < 3; column++) {
            final desk = Rect.fromLTWH(
              room.left + 13 + column * ((room.width - 30) / 3),
              room.top + 28 + row * 21,
              14,
              8,
            );
            canvas.drawRRect(
              RRect.fromRectAndRadius(desk, const Radius.circular(2)),
              deskPaint,
            );
          }
        }
      }

      if (icon != null) {
        _drawIcon(canvas, icon, room.center + const Offset(0, 8));
      }
      _drawLabel(canvas, label, Offset(room.center.dx, room.top + 13));
    }

    drawRoom(
      Rect.fromLTWH(
        size.width * 0.10,
        size.height * 0.19,
        size.width * 0.23,
        size.height * 0.22,
      ),
      'C402',
      desks: true,
    );
    drawRoom(
      Rect.fromLTWH(
        size.width * 0.37,
        size.height * 0.13,
        size.width * 0.22,
        size.height * 0.22,
      ),
      '교수연구실',
      icon: Icons.person_rounded,
    );
    drawRoom(
      Rect.fromLTWH(
        size.width * 0.64,
        size.height * 0.08,
        size.width * 0.23,
        size.height * 0.22,
      ),
      'C401',
      desks: true,
    );
    drawRoom(
      Rect.fromLTWH(
        size.width * 0.17,
        size.height * 0.62,
        size.width * 0.23,
        size.height * 0.18,
      ),
      'C403',
      desks: true,
    );
    drawRoom(
      Rect.fromLTWH(
        size.width * 0.45,
        size.height * 0.56,
        size.width * 0.18,
        size.height * 0.18,
      ),
      '계단·엘리베이터',
      icon: Icons.elevator_rounded,
    );
    drawRoom(
      Rect.fromLTWH(
        size.width * 0.68,
        size.height * 0.50,
        size.width * 0.20,
        size.height * 0.18,
      ),
      '화장실',
      icon: Icons.wc_rounded,
    );

    final start = Offset(size.width * 0.14, size.height * 0.82);
    if (selected != null) {
      final destination = Offset(
        size.width * selected!.x,
        size.height * selected!.y,
      );
      final route = Path()
        ..moveTo(start.dx, start.dy)
        ..lineTo(start.dx, size.height * 0.50)
        ..lineTo(destination.dx, size.height * 0.42)
        ..lineTo(destination.dx, destination.dy);
      canvas.drawPath(
        route,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 11
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
      canvas.drawPath(
        route,
        Paint()
          ..color = _PickColors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 6
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round,
      );
    }

    canvas.drawCircle(start, 10, Paint()..color = Colors.white);
    canvas.drawCircle(start, 7, Paint()..color = _PickColors.blue);
    _drawBadge(canvas, '현재 위치', start + const Offset(32, 0));
  }

  void _drawLabel(Canvas canvas, String label, Offset center) {
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: _PickColors.darkBlue,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(maxWidth: 82);
    painter.paint(canvas, center - Offset(painter.width / 2, painter.height / 2));
  }

  void _drawBadge(Canvas canvas, String label, Offset center) {
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: _PickColors.darkBlue,
          fontSize: 10,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final rect = Rect.fromCenter(
      center: center,
      width: painter.width + 16,
      height: painter.height + 10,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(999)),
      Paint()..color = Colors.white,
    );
    painter.paint(
      canvas,
      Offset(rect.center.dx - painter.width / 2, rect.center.dy - painter.height / 2),
    );
  }

  void _drawIcon(Canvas canvas, IconData icon, Offset center) {
    final painter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: _PickColors.blue,
          fontSize: 20,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, center - Offset(painter.width / 2, painter.height / 2));
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
