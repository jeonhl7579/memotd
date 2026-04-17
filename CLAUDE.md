# 개발 워크플로우 규칙

## 모든 기능 구현 전 반드시 아래 순서를 따를 것

### 1단계: 탐색 (Exploration)
- 관련 파일, 코드, 의존성을 먼저 파악
- 기존 패턴과 컨벤션 확인
- `[탐색 완료]` 라고 명시한 후 다음 단계로

### 2단계: 계획 (Planning)
- 구체적인 구현 계획을 작성
- 변경될 파일 목록과 이유 설명
- 사용자 승인 후 구현 시작
- `[계획 완료 - 구현을 시작할까요?]` 라고 물어볼 것

### 3단계: 구현 (Implementation)
- 승인된 계획대로만 구현
- 계획에 없던 변경은 반드시 먼저 알릴 것

## 코딩 규칙
- 자세한 내용은 `CONVENTIONS.md` 참고
- 모든 구현 전 해당 문서의 관련 규칙 확인 필수

# 메모앱 기획 문서

> 안드로이드 우선 출시 → 데스크톱 → iOS 순차 배포

---

## 목차

1. [탭 구조](#탭-구조)
2. [Note 탭](#note-탭)
3. [My Page 탭](#my-page-탭)
4. [폴더 구조](#폴더-구조)
5. [기술 스택 및 설계 원칙](#기술-스택-및-설계-원칙)

---

## 탭 구조

```
Note  |  My Page
```

---

## Note 탭

### 메모 리스트 페이지

- 메모 카드 목록 (제목, 내용 미리보기, 날짜, 태그)
- 검색바
- 정렬 옵션 (최신순 / 수정순 / 즐겨찾기)
- 태그 필터
- FAB → 메모 작성 / 웹 클리핑 선택
- 카드 롱프레스 → 삭제, 즐겨찾기, 태그 편집
- 웹 클리핑된 메모는 카드에 🔗 아이콘 표시

---

### 메모 작성 페이지

- Quill 에디터
- 제목 입력
- 태그 추가
- **자동 저장** (Debounce 3초, 상단에 "저장됨" 표시)
- 상단 액션 → 완료, 취소

---

### 메모 상세 페이지

- 본문 렌더링 (읽기 모드)
- 제목, 태그, 날짜 표시
- 웹 클리핑 메모일 경우 → 원본 URL 버튼 표시
- 하단 액션바 → 수정, 삭제, 즐겨찾기, 공유

---

### 메모 수정 페이지

- 작성 페이지와 동일 구성
- **자동 저장** 동일하게 적용

---

### 웹 클리핑 (신규)

**진입 방법**

- 앱 내 FAB에서 "웹 클리핑" 선택 → URL 직접 입력
- 외부 브라우저 공유 버튼 → 앱으로 공유 (Android Intent)

**클리핑 시 저장되는 항목**

| 항목 | 설명 |
|------|------|
| 제목 | 페이지 타이틀 |
| 본문 텍스트 | 주요 본문 내용 |
| 대표 이미지 | OG 이미지 등 |
| 원본 URL | 클리핑 출처 |
| 클리핑 날짜 | 저장 시각 |

**저장 후 동작** → 메모 작성 페이지로 이동하여 내용 편집 가능

---

## My Page 탭

### 통계

- 총 메모 수, 이번 달 작성 수
- 작성 캘린더 (잔디 or 달력 형태)
- 메모 유형 비율 (웹 클리핑 / 일반 메모)

---

### 동기화

- 로그인 상태 표시 (Supabase Auth)
- **업로드 버튼** → 로컬 DB → 클라우드
- **다운로드 버튼** → 클라우드 → 로컬 DB
- 마지막 동기화 시간 표시
- 비로그인 시 → 로그인 유도 배너

> **설계 메모**: 1차는 수동 동기화, 이후 자동 동기화로 확장 예정.  
> Merge 기준은 `updated_at` 필드 활용. `synced_at` 필드 추가 검토.

---

### 설정

- 테마 선택
- 태그 관리
- 폰트 크기
- 앱 버전 표시

---

## 폴더 구조

```
lib/
├── main.dart
├── core/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── app_database.g.dart
│   │   ├── connection/
│   │   │   └── connection.dart
│   │   └── tables/
│   │       ├── notes_table.dart
│   │       ├── tags_table.dart
│   │       └── note_tags_table.dart
│   ├── router/
│   │   └── app_router.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── theme_provider.dart
│   └── constants/
│       └── app_constants.dart
│
├── domain/
│   ├── models/
│   │   ├── note.dart
│   │   ├── note.freezed.dart
│   │   ├── tag.dart
│   │   ├── tag.freezed.dart
│   │   ├── web_clip.dart              # 웹 클리핑 메타데이터 모델 (신규)
│   │   └── web_clip.freezed.dart
│   └── repositories/
│       ├── note_repository.dart
│       └── tag_repository.dart
│
├── data/
│   ├── mappers/
│   │   ├── note_mapper.dart
│   │   └── tag_mapper.dart
│   ├── repositories/
│   │   ├── note_repository_impl.dart
│   │   └── tag_repository_impl.dart
│   └── services/
│       ├── web_clip_service.dart      # URL 파싱, 메타데이터 추출 (신규)
│       └── sync_service.dart         # 업로드 / 다운로드 로직 (신규)
│
├── presentation/
│   ├── notes/
│   │   ├── providers/
│   │   │   └── note_provider.dart
│   │   ├── screens/
│   │   │   ├── note_list_screen.dart
│   │   │   ├── note_edit_screen.dart
│   │   │   ├── note_detail_screen.dart
│   │   │   ├── tag_manage_screen.dart
│   │   │   └── web_clip_screen.dart   # URL 입력 + 클리핑 미리보기 (신규)
│   │   └── widgets/
│   │       ├── note_card.dart
│   │       ├── quill_editor.dart
│   │       ├── sort_bottom_sheet.dart
│   │       └── clip_type_badge.dart   # 🔗 아이콘 배지 (신규)
│   ├── todos/
│   │   ├── providers/
│   │   │   └── todo_provider.dart
│   │   ├── screens/
│   │   │   └── todo_screen.dart
│   │   └── widgets/
│   │       ├── todo_item.dart
│   │       ├── todo_section.dart
│   │       └── todo_add_sheet.dart
│   └── mypage/
│       ├── providers/
│       │   ├── stats_provider.dart
│       │   └── theme_unlock_provider.dart
│       ├── screens/
│       │   └── mypage_screen.dart
│       └── widgets/
│           ├── calendar_widget.dart
│           ├── stats_card.dart
│           └── theme_selector.dart
│
└── shared/
    └── widgets/
        ├── tag_chip.dart
        └── ad_helper.dart
```

---

## 기술 스택 및 설계 원칙

### 기술 스택

| 항목 | 선택 |
|------|------|
| 프레임워크 | Flutter |
| 로컬 DB | Drift |
| 상태관리 | Riverpod |
| 도메인 모델 | Freezed |
| 클라우드 | Supabase (Auth + Storage/DB) |
| 에디터 | Flutter Quill |

### 설계 원칙

- **자동 저장**: Debounce 3초, 작성 및 수정 페이지 공통 적용
- **동기화**: 1차 수동(업로드/다운로드 버튼), 2차 자동 동기화로 확장
- **DB 스키마**: `created_at`, `updated_at` 기본 포함 / `synced_at` 추가 검토
- **웹 클리핑**: Android Intent 공유 + 앱 내 URL 입력 두 가지 진입점
- **플랫폼 배포 순서**: Android → Desktop (심사 기간 활용) → iOS

---

## 출시 스코프 (1차)

| 기능 | 상태 |
|------|------|
| 메모 CRUD | ✅ 기존 |
| 태그 관리 | ✅ 기존 |
| 자동 저장 | 🆕 신규 |
| 웹 클리핑 | 🆕 신규 |
| 수동 동기화 | 🆕 신규 |
| 자동 동기화 | ⏳ 2차 |
| 영상 클리핑 | ⏳ 2차 |