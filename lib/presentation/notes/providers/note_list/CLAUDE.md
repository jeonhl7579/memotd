# NoteListScreenState 생성

## NoteListScreenState
presentation/note/screens/note_list_screen.dart 파일의 NoteListScreen의 상태 클래스
freezed로 생성 > 코드 작성 후 직접 'dart run build_runner build" 예정

### NoteListScreen에서 관리할 상태들
- 검색어(type : String, null 가능)
- - 본문, 내용, 태그 포함 검색
- 필터
- - 전체, 즐겨찾기에 따라 필터
- 노트리스트(type : List<NoteModel>)
- - GridView에 보여줄 노트리스트