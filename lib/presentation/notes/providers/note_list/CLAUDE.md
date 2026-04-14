# NoteListScreenProvider 생성

## 제약사항
presentation/notes/providers/note_list/note_list_provider.dart 위치에 생성
riverpod_annotation이 아닌 수동으로 생성

## 요구사항
- StreamProvider
- - Stream<List<NoteModel>>
- - noteListRepositoryProvider 사용
- NotifierProvider
- - 같은 디렉토리에 있는 NoteListState 상태 사용
- 2개의 provider를 조합하여 filteredNoteListProvider 
- - AsyncValue<List<Model>>
- - StreamProvider watch - notesAsync
- - NotifierProvider watch
- - - notesAsync.whenData 를 통해 상태 변경



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
