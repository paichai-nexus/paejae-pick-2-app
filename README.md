# Paejae Pick 2.0

<!-- NEXUS_PROJECT_META_START -->

## Project Management

| Field | Value |
| --- | --- |
| Status | 🟢 Active |
| Project Lead | 이영준 |
| Team / Support | 유지보수: 이서율 |
| Next Milestone | 실제 학교 데이터·API 연동 조건 및 다음 기능 우선순위 정리 |
| Registry | [NEXUS Project Registry](https://github.com/paichai-nexus/nexus-project-registry) |

<!-- NEXUS_PROJECT_META_END -->


Paejae Pick 2.0 is a Flutter-based smart campus MVP app concept for Paichai University students.

It connects cafeteria information, campus exploration, Nasumi collection, code-based missions, department tours, club notices, and future CityBrain operation data.

## Current Version

`v5.2-future-mobility-screens`

## Project Organization

Paejae Pick 2.0 is developed and maintained by the PAICHAI NEXUS
university student convenience app team.

| Role | Name | Responsibility |
| --- | --- | --- |
| 개발팀장 (Development Team Lead) | 이영준 (Lee Young Jun) | Product direction, architecture, core development, smart-mobility integration, and development-team coordination |
| 유지보수 (Maintenance) | 이서율 (Lee Seo Yul) | QA, bug fixes, release checks, documentation updates, and ongoing operational maintenance |

### Ownership Structure

```text
PAICHAI NEXUS
└── Paejae Pick 2.0
    ├── 개발팀장: 이영준
    └── 유지보수: 이서율
```

Project decisions and core development are led by 이영준. Stable releases,
quality checks, documentation, and post-release maintenance are managed with
이서율.

## Core Strategy

The first reason to install Paejae Pick is cafeteria information.

The reason to return is Nasumi collection, campus missions, department tours, and club notices.

## Implemented Features

### v5.2 Future Mobility Screens

- Adds building, room, department-office, and professor-office search to the
  3D indoor navigation experience
- Opens with an Information Science Building C401 walking route and provides
  building/floor filters plus an isometric floor-plan preview
- Adds a campus autonomous shuttle route across the main gate, Paichai 21st
  Century Building, Central Library, and International Exchange Building
- Uses a Paichai campus-map reference asset so the shuttle and delivery overlays
  follow the real campus building axis instead of arbitrary mock coordinates
- Adds pickup/destination selection, passenger count, arrival time, and a
  reversible reservation state
- Adds the NEXUS-01 ROS2 delivery-robot status experience with route selection,
  four-stage tracking, ETA, battery, route map, and operations-center guidance
- Keeps the app layer separated from live vehicle control; all locations,
  reservations, and robot statuses remain demonstration data until university
  approval and API integration

### v5.1 Smart Mobility UI v2

- Aligns the Smart Mobility screens with the Paejae Pick 2.0 visual language
- Adds the branded header, mascot treatment, blue accents, rounded cards, and refined shadows
- Redesigns the Smart Mobility hub into a polished student-facing dashboard
- Refines the campus map with search, building/floor filters, markers, and 3D controls
- Unifies the autonomous pickup and delivery experiences with the same design system

### v5.0 Smart Mobility MVP

- Adds a Smart Mobility hub to the main navigation
- Adds building, floor, room, department, and professor-office search mock
- Adds an indoor floor-plan and route-guidance prototype
- Adds an autonomous campus shuttle pickup reservation simulation
- Adds an autonomous delivery request and tracking simulation
- Separates the app layer from the future NEXUS ROS2 robot/vehicle layer
- Uses demo data only; no real reservation, dispatch, location tracking, or delivery occurs

### Smart Mobility Product Boundary

Paejae Pick is the student-facing smart-campus service. It owns search,
indoor guidance, pickup requests, delivery requests, and status presentation.

The NEXUS ROS2 project owns the physical robot/vehicle stack: localization,
path planning, perception, obstacle avoidance, remote control, and emergency
stop. Production integration will happen through approved APIs after safety,
operations, privacy, and university-data agreements are in place.

### v0.1 Flutter MVP Shell

- Flutter project structure
- Bottom navigation
- Home
- Campus map mock
- Collection mock
- Club notice mock
- My page mock

### v0.2 Design Polish

- Splash screen
- Login mock screen
- Nasumi visual concept

### v0.3 Collection Mission

- Mission code input
- Local card acquisition
- Mission complete screen
- SharedPreferences storage

### v0.4 Collection Detail

- Collection progress
- Acquired / locked card state
- Card detail screen
- Acquisition condition display

### v0.5 CityBrain Cafeteria

- Cafeteria detail screen
- Today's menu
- Congestion status mock
- Estimated waiting time
- Recommended visit time
- Menu satisfaction buttons
- Menu card acquisition
- Local collection integration

### v0.6 Release PRD

- Product requirements document
- v1.0 release scope
- Cost and privacy plan
- Android release readiness checklist

### v0.7 Department Nasumi Tour

- Department Nasumi Tour screen
- Department mission codes
- Department building information
- Local collection integration

### v0.8 Club Notice Detail

- Club notice detail screen
- Structured recruitment information
- Favorite club local storage
- My Page favorite count integration

### v0.9 Auth and Privacy Design

- Privacy guide screen
- Local data reset
- Login privacy notice link
- My Page privacy menu

### v1.0 Release Candidate

- Android-first MVP scope
- Release candidate documentation
- Store-readiness direction
- Privacy-light local-first strategy


### v1.3 QR Mission Polish

- QR scan mock screen
- Improved mission code entry
- Quick internal test code buttons
- Better success/failure feedback
- Mission code list for internal testing

### v1.4 UI / Screenshot Prep

- Screenshot target list
- Internal test demo flow
- Release-facing demo scenario
- Build verification for presentation


### v1.5 Internal Test Package

- Internal tester guide
- Android APK installation guide
- Feedback form questions
- Release package notes
- Internal testing preparation
\n
### v1.9 Club Notice Submit Mock

- Club notice submission mock
- Structured recruitment request flow
- Club name / title / category / contact / description fields
- Submit confirmation without backend
- Direction toward admin-approved club notices


### v2.0 Campus Participation Hub

- Reframes club notice hall as campus participation infrastructure
- Adds participation type explanation
- Clarifies that the app does not operate events directly
- Positions the app as a structured notice and recruitment hub
- Prepares expansion to department events, projects, volunteer groups, and contest teams
\n
### v2.1 Participation Notice Types

- Defines Campus Participation Hub notice types
- Club recruitment
- Department / office events
- Project team recruitment
- Volunteer / supporters notices
- Contest team recruitment
- Clarifies host/app responsibility split


### v2.2 Participation Status Labels

- Defines notice status labels
- Host submitted
- Info check needed
- Under review
- Visible
- Closed
- Hidden
- Clarifies that checked does not mean officially approved


### v2.3 Participation Filter / Deadline Sort

- Adds participation hub filter concept
- All / club / event / project / deadline-soon categories
- Deadline-based sorting principle
- Visibility rules for closed, under-review, and hidden notices
- Clarifies that the hub should reduce search cost
\n
### v2.4 Home Internal Test Positioning

- Adds Home screen value proposition
- Cafeteria as install reason
- Nasumi / missions as repeat-use reason
- Campus Participation Hub as campus spread reason
- Clarifies the app as campus infrastructure MVP


### v2.5 MVP Feature Freeze

- Freezes MVP feature scope before internal beta
- Defines install reason / repeat-use reason / campus spread reason
- Locks included and excluded features
- Prevents uncontrolled feature creep before testing
- Prepares the project for v3.0 Internal Beta Candidate
\n
### v2.7 Design Lock / UI Spec

- Locks generated concept images as the UI reference direction
- Defines visual identity, colors, typography, layout, and mascot rules
- Adds full screen inventory
- Adds department intro and campus map design direction
- Prevents UI drift between concept images and Flutter implementation
\n
### v2.8 Department Intro IA / Data Model

- Defines department introduction information architecture
- Adds department data field model
- Connects department intro with campus map, Nasumi collection, QR missions, and transfer exploration
- Adds verification status labels for department information
- Prepares the app for department intro mock screens
\n
### v2.9 Department Intro Mock Screen

- Adds Department Intro list screen
- Adds Department Detail screen
- Adds seed data for Computer Engineering, AI, Game Engineering, and Business
- Connects department intro with transfer exploration, buildings, Nasumi, and QR missions
- Adds My Page entry point


### v3.1 Department Interview Template

- Adds department interview template
- Separates official information from student interview information
- Adds app summary format for department dictionary content
- Defines safe wording for transfer, admissions, and department atmosphere
- Prepares data collection for department dictionary expansion
\n
### v3.2 Department Seed Data Expansion

- Expands Department Intro seed dataset
- Adds AI/SW, physical AI, business, media, webtoon, and animation-related departments
- Keeps all unverified information marked as mock / 확인 필요
- Prepares the Department Dictionary for visual concept generation and UI polish


### v3.3 Department Full Seed Basic

- Expands Department Dictionary to a full basic department seed list
- Keeps all department information marked as 확인 필요
- Defers interview content to a later version
- Prepares the app for department filtering and grouped browsing
\n
### v3.4 Department Filter / Grouped Browsing

- Adds Department Dictionary filter/grouping direction
- Defines category-based browsing for 전체, 인문사회, 자연과학, 공학, 예체능, 평생교육
- Adds a Department Filter Guide screen
- Prepares the Department Dictionary for search and grouped browsing
\n
### v3.5 Department Detail UI Polish

- Polishes Department Detail screen wording
- Adds recommendation section for students exploring departments
- Improves admission/transfer note wording
- Clarifies Department Nasumi and QR mission connection
- Moves Department Dictionary closer to generated UI concept direction
\n
### v3.6 Department Search / Filter UI

- Adds actual search field to Department Dictionary
- Adds category filter chips for 전체, 인문사회, 자연과학, 공학, 예체능, 평생교육
- Adds result count and empty result state
- Makes Department Dictionary easier to browse after full seed expansion
\n
### v3.7 Department Card Visual Polish

- Polishes Department Dictionary card wording
- Clarifies category, location, and mission code fields
- Updates detail CTA to 학과백과 열기
- Improves screenshot readiness for sharing with professors, student councils, and testers
\n
### v3.8 Department Demo / Screenshot Package

- Adds Department Dictionary demo package
- Adds screenshot checklist for sharing and feedback
- Adds short explanation text for professors, student councils, senior students, and testers
- Prepares the Department Dictionary for feedback collection and interview recruitment
\n
### v3.9 Department Screenshot QA / Gap Report

- Adds screenshot QA gap report for Department Dictionary
- Defines comparison points between generated concept images and Flutter implementation
- Adds screenshot capture guide
- Adds v4.0 UI fix plan
- Prepares Department Dictionary for real-device visual correction
\n
### v4.0 Department UI Fix Pass

- Defines the first Department Dictionary UI correction pass
- Keeps verified/unverified department information separated
- Prepares Department Dictionary for real-device screenshots and stakeholder feedback
- Adds TeamLink concept as the next feature direction for contest team matching


### v4.1 PCU TeamLink IA / Data Model

- Defines TeamLink as a contest team matching feature
- Adds contest notice, team recruitment, role tag, profile, and application status data models
- Frames TeamLink as a way to increase contest participation and cross-major collaboration
- Adds contest proposal draft for school submission
- Prepares TeamLink mock screen implementation for v4.2
\n
### v4.2 TeamLink Mock Screen

- Adds first TeamLink mock screen
- Shows contest notices, role tags, and team recruitment cards
- Adds TeamLink entry point from Participation Hub
- Frames TeamLink as a contest participation and cross-major collaboration feature
\n
### v4.3 TeamLink Official Notice Source

- Adds official notice source rule for TeamLink
- Connects TeamLink direction to the university general notice board
- Separates official contest notices from student-created team recruitment posts
- Adds notice collection and verification rules
- Prepares TeamLink recruitment detail / creation flow for v4.4
\n
### v4.4 TeamLink Recruitment Flow

- Adds TeamLink recruitment detail screen
- Adds create recruitment mock screen
- Connects recruitment cards to detail flow
- Adds create recruitment entry button
- Keeps TeamLink as a mock flow without real backend submission
\n
### v4.5 TeamLink Trust / Safety Policy

- Adds TeamLink trust and safety policy screen
- Defines report reasons and privacy boundaries
- Clarifies that TeamLink does not guarantee team quality or contest awards
- Separates official notices, student recruitment posts, and mock data
- Prepares TeamLink for proposal and stakeholder explanation
\n
### v4.6 TeamLink Proposal / Screenshot Package

- Adds TeamLink proposal package
- Adds screenshot checklist for TeamLink screens
- Adds short pitch text for professors, staff, student councils, and students
- Frames TeamLink as official-notice-based contest participation infrastructure
- Prepares TeamLink for real-device screenshot QA and stakeholder explanation
\n## Tech Stack

- Flutter
- Dart
- SharedPreferences
- Android first
- iOS planned later

## v1.0 Scope

Included:

- Splash / Login mock
- Home
- Cafeteria detail
- Code-based mission
- Collection / card detail
- Department Nasumi Tour
- Club notice detail
- My Page
- Privacy guide
- Local data reset

Excluded from v1.0:

- Real school email authentication
- Real QR camera scanner
- Firebase/Supabase sync
- Real-time location tracking
- Admin console
- Official school data integration
- POS/kiosk integration
- YOLO congestion integration

## Release Direction

v1.0 targets Android internal testing first.

The app intentionally avoids heavy backend usage and sensitive personal data storage in the early stage.

## Test Focus

- Does cafeteria information create a reason to install?
- Does Nasumi collection create a reason to return?
- Does department tour help students learn campus structure?
- Does the club notice hall feel more structured than scattered posts?
