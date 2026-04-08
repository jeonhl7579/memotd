
## 폴더 구조

```
lib/
├── main.dart                          # 앱 진입점, ProviderScope, AppDatabase 초기화
├── core/
│   ├── database/
│   │   ├── app_database.dart          # @DriftDatabase, 싱글톤 관리
│   │   ├── app_database.g.dart        # build_runner 자동 생성
│   │   ├── connection/
│   │   │   └── connection.dart        # openConnection(), QueryExecutor 설정
│   │   └── tables/
│   │       ├── notes_table.dart       # Notes extends Table
│   │       ├── tags_table.dart        # Tags extends Table
│   │       └── note_tags_table.dart   # NoteTags extends Table (중간 테이블)
│   ├── router/
│   │   └── app_router.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── theme_provider.dart
│   └── constants/
│       └── app_constants.dart
│
├── domain/                            # 앱 로직 레이어 (Freezed 도메인 모델 + Repository 인터페이스)
│   ├── models/
│   │   ├── note.dart                  # Freezed - 메모 도메인 모델
│   │   ├── note.freezed.dart          # build_runner 자동 생성
│   │   ├── tag.dart                   # Freezed - 태그 도메인 모델
│   │   └── tag.freezed.dart           # build_runner 자동 생성
│   └── repositories/
│       ├── note_repository.dart       # NoteRepository 추상 클래스
│       └── tag_repository.dart        # TagRepository 추상 클래스
│
├── data/                              # 데이터 접근 레이어 (Mapper + Repository 구현체)
│   ├── mappers/
│   │   ├── note_mapper.dart           # NoteEntity ↔ Note 변환
│   │   └── tag_mapper.dart            # TagEntity ↔ Tag 변환
│   └── repositories/
│       ├── note_repository_impl.dart  # NoteRepository 구현체
│       └── tag_repository_impl.dart   # TagRepository 구현체
│
├── features/
│   ├── notes/
│   │   ├── providers/
│   │   │   └── note_provider.dart     # 메모 CRUD, 정렬, 즐겨찾기
│   │   ├── screens/
│   │   │   ├── note_list_screen.dart
│   │   │   ├── note_edit_screen.dart
│   │   │   └── tag_manage_screen.dart
│   │   └── widgets/
│   │       ├── note_card.dart
│   │       ├── quill_editor.dart
│   │       └── sort_bottom_sheet.dart
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