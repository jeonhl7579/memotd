# 상세 페이지 설계 가이드

> Flutter + Riverpod 기반 앱에서 상세(Detail) 화면을 설계할 때 놓치기 쉬운 요소와 데이터 흐름 정책 정리.

---

## 1. 상세 페이지 설계 체크리스트

상세 페이지를 설계할 때 아래 항목을 반드시 명시한다.

### 1-1. 화면 전환 계약 (Screen Transition Contract)

| 항목 | 질문 | 예시 |
|------|------|------|
| **진입 데이터** | 이 화면에 무엇이 전달되는가? | `NoteModel` via `GoRouter.extra` |
| **내부 상태** | 어떤 Provider가 화면 상태를 관리하는가? | `noteDetailProvider(note)` |
| **복귀 반환** | 이 화면을 pop할 때 무언가를 돌려보내는가? | `context.pop(updatedNote)` |
| **복귀 수신** | 이 화면을 push한 쪽이 결과를 어떻게 수신하는가? | `await context.push<NoteModel>(...)` |
| **연동 UI** | 반환값으로 갱신해야 하는 UI 요소는 무엇인가? | title, tags, date, QuillController |

### 1-2. 설계 템플릿

새 상세 페이지를 설계할 때 아래 형식을 채운다.

```
## [XxxDetailScreen]
- 진입: XxxModel (GoRouter extra)
- Provider: xxxDetailProvider(model)
- 복귀 반환: context.pop(updatedModel?) — 변경 없으면 null
- 복귀 수신처: XxxListScreen / XxxParentScreen
  └ await context.push<XxxModel>('/xxx/detail/:id', extra: model)
  └ 결과 처리: notifier.updateItem(updatedModel)
- 갱신 대상 UI:
  - 텍스트 필드 → state.item.xxx (Provider 자동 갱신)
  - 에디터/컨트롤러 → ref.listen으로 직접 교체 필요
```

### 1-3. 컨트롤러 리프레시 주의

Provider 상태가 바뀌어도 **자동으로 갱신되지 않는 UI**가 있다.

- `TextEditingController`, `QuillController`, `ScrollController` 등 `initState`에서 초기화된 컨트롤러
- 이런 컨트롤러는 `ref.listen`으로 상태 변화를 감지해 수동 교체해야 한다

```dart
ref.listen(xxxDetailProvider(model), (prev, next) {
  if (prev?.item.content != next.item.content) {
    final old = _controller;
    setState(() => _controller = _buildController(next.item.content));
    old.dispose(); // 이전 컨트롤러 반드시 dispose
  }
});
```

---

## 2. 상태 관리: Local DB vs 서버 통신

### 2-1. Local DB (현재: Drift)

Drift는 SQLite 위에서 **reactive stream**을 기본 제공한다.

```dart
// Repository
Stream<NoteModel?> watchNoteById(int id) {
  return (_db.select(_db.notes)..where((t) => t.id.equals(id)))
      .watchSingleOrNull()
      .map((row) => row?.toModel());
}

// Provider
final noteDetailStreamProvider = StreamProvider.autoDispose
    .family<NoteModel?, int>((ref, id) {
  return ref.watch(noteRepositoryProvider).watchNoteById(id);
});
```

**장점**: DB 변경 시 모든 구독 화면 자동 갱신, `context.pop` 결과 전달 불필요  
**단점**: 서버 동기화 시점에 stream이 끊기거나 중복 이벤트 발생 가능

---

### 2-2. 서버 API 통신 시 Stream 정책

서버와 통신할 때는 DB처럼 자동 stream을 쓰기 어렵다. 아래 3가지 정책 중 선택한다.

#### 정책 A: Optimistic Update + Cache Invalidation (권장 기본값)

수정 요청을 보내기 전에 UI를 먼저 갱신하고, 실패 시 롤백한다.

```
[흐름]
1. 수정 요청 전 → Provider 상태를 낙관적으로 업데이트
2. API 호출 (PATCH /notes/:id)
3. 성공 → 서버 응답으로 상태 확정
4. 실패 → 이전 상태로 롤백 + 에러 표시
```

```dart
Future<void> updateNote(NoteModel updated) async {
  final previous = state.note;
  state = state.copyWith(note: updated); // 낙관적 업데이트
  try {
    final confirmed = await _api.updateNote(updated);
    state = state.copyWith(note: confirmed); // 서버 응답으로 확정
  } catch (_) {
    state = state.copyWith(note: previous); // 롤백
  }
}
```

**적합한 상황**: REST API, 단순 CRUD, 네트워크 지연이 짧은 경우

---

#### 정책 B: Local Cache + Background Sync

로컬 DB(Hive, Isar 등)를 중간 캐시로 사용하고, 서버 동기화는 백그라운드에서 처리한다.

```
[읽기]  로컬 캐시 → UI 즉시 표시 → 백그라운드 서버 fetch → 캐시 갱신 → UI 자동 갱신 (stream)
[쓰기]  로컬 캐시 즉시 저장 (stream 갱신) → 백그라운드 서버 sync → 실패 시 재시도 큐
```

**적합한 상황**: 오프라인 지원 필요, 현재 memotd의 수동 동기화 구조와 유사  
**주의**: 충돌 해소 정책 필요 (`updated_at` 기준 last-write-wins 등)

---

#### 정책 C: WebSocket / SSE (실시간 stream)

서버가 변경 이벤트를 push하면 클라이언트가 구독하는 방식. Local DB stream과 가장 유사한 UX.

```
서버 → SSE/WebSocket → StreamProvider → UI 자동 갱신
```

```dart
final noteStreamProvider = StreamProvider.autoDispose
    .family<NoteModel, int>((ref, id) {
  return ref.watch(webSocketServiceProvider).watchNote(id);
});
```

**적합한 상황**: 협업, 다기기 실시간 동기화  
**단점**: 서버 구현 복잡도 높음, 연결 관리 필요 (reconnect, heartbeat)

---

### 2-3. memotd 적용 권장 정책

| 단계 | 정책 |
|------|------|
| 현재 (Local DB) | Drift stream + `context.pop` 결과 전달 병행 |
| 수동 동기화 추가 시 | **정책 B** — 로컬 stream 유지, 서버 sync는 백그라운드 |
| 자동 동기화 추가 시 | **정책 B → A** 혼합 — 쓰기는 Optimistic, 읽기는 캐시 우선 |
| 협업 기능 추가 시 | **정책 C** — SSE or WebSocket 도입 |

---

## 3. 체크리스트 요약

상세 페이지 설계 시 아래를 빠뜨리지 않는다.

- [ ] 진입 데이터 타입과 전달 방식 명시
- [ ] 이 화면이 pop 시 값을 반환하는지 여부 결정
- [ ] 반환값을 수신하는 화면에서 어떤 Provider/상태를 갱신하는지 명시
- [ ] `initState`에서 생성된 컨트롤러가 있다면 `ref.listen` 리프레시 계획 포함
- [ ] 현재 데이터 소스(Local DB / 서버)에 맞는 stream 정책 선택
