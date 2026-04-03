import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/notes/screens/note_list_screen.dart';
import '../../features/todos/screens/todo_screen.dart';
import '../../features/mypage/screens/mypage_screen.dart';
import '../../shared/widgets/main_shell.dart';

/// 앱 전체 라우팅 정의.
///
/// StatefulShellRoute.indexedStack 을 사용해 각 탭의 스크롤 위치 / 상태를
/// 탭 전환 시에도 유지한다.
final GoRouter appRouter = GoRouter(
  initialLocation: '/notes',
  debugLogDiagnostics: false,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        // ── 메모 탭 ───────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/notes',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: NoteListScreen()),
            ),
          ],
        ),

        // ── ToDo 탭 ───────────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/todos',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: TodoScreen()),
            ),
          ],
        ),

        // ── 마이페이지 탭 ─────────────────────────────────────────────────
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/mypage',
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: MypageScreen()),
            ),
          ],
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('페이지를 찾을 수 없어요\n${state.error}', textAlign: TextAlign.center),
    ),
  ),
);
