## Riverpod
- AutoDispose 와 Family 사용시 provider.autoDispose.family 방식으로 선언
- StateNotifier 금지 → 'Notifier' 또는 'AsyncNotifier' 사용
- **[v3 Family 패턴]** Family arg는 Notifier 생성자로 수신, build()는 인자 없음
  - ✅ `MyNotifier(this._arg)` + `build() => State(arg: _arg)`
  - ❌ `build(Arg arg)` — Riverpod 2.x 방식, v3에서 컴파일 에러
  - ❌ `AutoDisposeFamilyNotifier` / `AutoDisposeNotifierProviderFamily` — v3에서 제거된 클래스
- **[섀도잉 주의]** 생성자 필드명과 메서드 내 로컬 변수명 충돌 방지를 위해 생성자 필드는 `_` 접두사 사용