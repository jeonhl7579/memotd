# NoteListRepository, NoteListRepositoryImpl 수정

## 기존 요구사항
- getTopTags : db에서 많이 사용되는 인기태그 3개 불러오기

## 요구사항 수정
- 아래 적혀져 있는 파일 위치만 확인
- getTopTags 제거
- db에 저장되어 있는 즐겨찾기 되어있는 노트들만 불러오는 함수로 수정
- 참고해야할 파일 위치
- - core/database/tables/notes_table.dart
- 수정해야할 파일 위치
- - domain/repositories/note_list_repository.dart
- - data/repositories/note_list_repository_impl.dart

