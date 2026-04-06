## 프로젝트 한 줄 소개
> 메모 작성, 할일 관리, 통계 대시보드를 하나로 묶은 Flutter 앱.

## 핵심 기술 선택 및 이유

| 기술 | 선택 이유 |
|---|---|
| **Flutter** | iOS/Android 단일 코드베이스, 빠른 UI 개발 |
| **Riverpod** | 컴파일 타임 안전성, Generator 기반 보일러플레이트 최소화 |
| **Isar** | Flutter 최적화 로컬 DB, 빠른 읽기/쓰기, 타입 안전 쿼리 |
| **flutter_quill** | Delta 기반 리치 에디터, 이미지 embed 공식 지원 |
| **Supabase** | PostgreSQL 구조적 일관성, 용량 기반 예측 가능한 과금 |
| **go_router** | StatefulShellRoute로 탭 상태 유지, 선언적 라우팅 |

## 주요 기능 요약
- 리치 텍스트 메모 (flutter_quill) + 이미지 삽입
- TODO 날짜별 관리 + 로컬 푸시 알림
- 달력 기반 TODO 달성률 + 연속 달성 스트릭
- 광고 시청 → 테마/디자인 영구 해금 수익화
- 클라우드 동기화 구독 모델 (v2)

# 📋 상세 명세

## 1. 프로젝트 개요

### 배경
별도의 메모 앱과 TODO 앱을 각각 사용하는 불편함에서 출발.
두 기능을 하나로 통합하고, 달성률 시각화로 생산성을 높이는 앱을 기획.

---

## 2. 기술 스택

```yaml
dependencies:
  flutter_riverpod: ^2.5.1       # 상태관리
  riverpod_annotation: ^2.3.5    # Generator 기반 Provider
  isar: ^3.1.0                   # 로컬 DB
  isar_flutter_libs: ^3.1.0
  flutter_quill: ^10.8.0         # 리치 텍스트 에디터
  flutter_quill_extensions: ...  # 이미지 embed
  go_router: ^14.2.0             # 라우팅
  flutter_local_notifications: ^17.2.2  # 푸시 알림
  google_mobile_ads: ^5.1.0      # 광고
  shared_preferences: ^2.2.3     # 테마 저장
  supabase_flutter: ^2.5.0       # 클라우드 동기화 (v2)
  image_picker: ^1.1.2           # 이미지 선택
  uuid: ^4.4.0
  intl: ^0.19.0
```

### 기술 선택 근거

**Riverpod (vs Provider / Bloc / GetX)**
- `riverpod_generator`로 컴파일 타임에 타입 오류 감지
- `AsyncNotifier` 패턴으로 로딩/에러 상태를 선언적으로 처리
- 나중에 Supabase 연동 시 Provider 내부만 교체하면 UI 변경 불필요

**Isar (vs sqflite / Hive)**
- Flutter에 최적화된 임베디드 DB, 별도 ORM 불필요
- 타입 안전 쿼리로 런타임 오류 방지
- Supabase PostgreSQL과 모델 구조가 자연스럽게 매핑됨

**flutter_quill**
- Delta JSON 형식으로 서식 있는 텍스트 저장
- 이미지 embed를 공식 지원 (`flutter_quill_extensions`)
- v2 드로잉 기능 추가 시 별도 이미지 embed로 자연스럽게 확장 가능

**Supabase (vs Firebase)**
- PostgreSQL 기반 → 로컬 Isar 모델과 구조적 일관성
- 용량 기반 과금으로 읽기 횟수 폭증 시에도 비용 예측 가능
- Firebase는 쿼리 1회 실수가 수십만 읽기로 이어져 예상치 못한 과금 위험
- Row Level Security(RLS)로 DB 레벨에서 사용자 데이터 분리

**go_router + StatefulShellRoute.indexedStack (vs Navigator)**
- `StatefulShellRoute.indexedStack`으로 탭 전환 시 스크롤 위치·상태 유지
- 선언적 라우팅으로 딥링크, 인증 리디렉션 처리 용이

---

## 3. 아키텍처

### 폴더 구조 (Feature-based)
```
lib/
├── main.dart
├── core/
│   ├── database/
│   │   └── isar_service.dart       # Isar 초기화 및 싱글톤 관리
│   ├── router/
│   │   └── app_router.dart         # StatefulShellRoute 라우팅
│   ├── theme/
│   │   ├── app_theme.dart          # ThemeData 정의
│   │   └── theme_provider.dart     # 테마 상태 관리
│   └── constants/
│       └── app_constants.dart
├── models/
│   ├── note.dart                   # @Collection - Isar 메모 모델
│   ├── todo.dart                   # @Collection - Isar TODO 모델
│   └── tag.dart                    # @Collection - Isar 태그 모델
├── features/
│   ├── notes/                      # 메모 기능
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   ├── todos/                      # TODO 기능
│   │   ├── providers/
│   │   ├── screens/
│   │   └── widgets/
│   └── mypage/                     # 마이페이지
│       ├── providers/
│       ├── screens/
│       └── widgets/
└── shared/
    └── widgets/
```

### 데이터 흐름
```
UI (ConsumerWidget)
    ↓ ref.watch()
Riverpod Provider (AsyncNotifier)
    ↓ CRUD
Isar (로컬 DB)
    ↓ 동기화 (v2)
Supabase (PostgreSQL + Storage)
```

### 데이터 모델

**Note**
```dart
@Collection()
class Note {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String title;
  late String contentDelta;  // flutter_quill Delta JSON
  late String contentText;   // 검색/미리보기용 순수 텍스트
  List<String> tagIds = [];
  bool isFavorite = false;
  late DateTime createdAt;
  late DateTime updatedAt;
}
```

**Todo**
```dart
@Collection()
class Todo {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String title;
  bool isDone = false;
  String? noteId;
  List<String> tagIds = [];
  DateTime? dueDate;
  bool hasAlarm = false;
  DateTime? alarmTime;
  late DateTime createdAt;
}
```

**Tag**
```dart
@Collection()
class Tag {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String name;
  late int colorValue;  // Color.value 정수로 저장
}
```

---

## 4. 주요 기능 상세

### 4-1. 메모 탭

**목록 화면**
- 검색, 정렬 (최신순 / 오래된순 / 생성일순 / 제목순 / 즐겨찾기 우선)
- 태그 필터 칩 (가로 스크롤)
- 메모 카드: 제목 + 내용 미리보기 2줄 + 태그 칩 + 수정일 + ⭐ 즐겨찾기 토글

**편집 화면 (flutter_quill)**
- 리치 텍스트 서식: 굵기 / 기울임 / 밑줄 / 취소선 / 색상 / 제목 / 리스트
- 이미지 삽입: 갤러리 / 카메라 선택 후 Delta embed
- 테마별 에디터 배경 적용 (배경색 / 텍스처 이미지)
- contentDelta (Delta JSON) + contentText (순수 텍스트) 동시 저장

**태그 관리**: 태그 CRUD + 색상 설정 (메모 탭 내 접근)

### 4-2. TODO 탭

**날짜별 목록**
```
📅 오늘  (3/5 완료)     ← 섹션 헤더에 진행률 표시
  ☑ 완료된 항목         ← 취소선 처리
  ☐ 미완료 항목

📅 내일 / 이번 주 / 날짜 없음
```

**+ 플로팅 버튼 → 바텀시트**
- 할 일 제목 (필수)
- 날짜 퀵버튼 (오늘 / 내일 / 직접입력)
- 태그 선택
- 메모 연결 (선택)
- 🔔 알림 토글 (날짜 지정 시 활성화)

**로컬 푸시 알림**
- `flutter_local_notifications` 사용
- 날짜 지정 TODO에만 선택적 알림
- iOS 권한 요청 / Android 13+ POST_NOTIFICATIONS 처리

### 4-3. 마이페이지 탭

**달력 달성률**
- 날짜별 색상 표시: 🟢 전체 완료 / 🟡 일부 완료 / ⚪ 없음
- 날짜 탭 시 해당일 TODO 목록 표시
- 이번 달 달성률 (완료 수 / 전체 수)
- 🔥 연속 달성 스트릭 (재방문 동기 부여)


---

## 5. 기술적 의사결정 기록

### flutter_quill contentDelta + contentText 분리 저장
Delta JSON에서 검색할 때마다 파싱하면 성능 저하가 발생.
저장 시점에 순수 텍스트(contentText)를 함께 추출해 저장함으로써
검색과 미리보기는 contentText를 사용하고,
에디터 복원 시에만 contentDelta를 파싱하는 구조로 분리.

### StatefulShellRoute.indexedStack 선택
일반 ShellRoute는 탭 전환 시 화면을 새로 빌드해 스크롤 위치가 초기화됨.
StatefulShellRoute.indexedStack은 IndexedStack으로 모든 탭을 메모리에 유지해
탭 전환 시 상태(스크롤 위치, 필터 선택 등)가 그대로 보존됨.

### FAB을 바깥 Scaffold에 선언
StatefulShellRoute 구조에서 각 탭 Scaffold에 FAB을 선언하면
바깥 Scaffold의 BottomNavigationBar 높이를 인식하지 못해 FAB이 가려짐.
FAB을 바깥 Scaffold(MainScreen)에 선언하고
`navigationShell.currentIndex == 1` 조건으로 TODO 탭에서만 표시.

### Supabase 선택 (vs Firebase)
Firebase Firestore는 문서 읽기 횟수 기반 과금으로
비효율적 쿼리 하나가 예상치 못한 비용을 유발할 수 있음.
메모 앱 특성상 동기화 시 전체 문서 조회가 빈번해 읽기 횟수 폭증 위험이 높음.
Supabase는 용량 기반 과금으로 비용 예측이 가능하고,
PostgreSQL 구조가 로컬 Isar 모델과 자연스럽게 매핑되어 채택.

---

## 6. 트러블슈팅 경험

### FAB이 BottomNavigationBar 뒤에 가려지는 문제
StatefulShellRoute 구조에서 각 탭의 Scaffold에 FAB을 선언했을 때 발생.
바깥 Scaffold가 BottomNavigationBar를 갖고 있어 내부 FAB이 높이를 인식 못함.
FAB을 MainScreen Scaffold로 이동하고 currentIndex 조건으로 노출 제어하여 해결.
