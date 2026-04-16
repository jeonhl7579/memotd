import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memotd/domain/models/note_model.dart';
import 'package:memotd/presentation/notes/screens/note_detail_screen.dart';
import 'package:memotd/presentation/notes/screens/note_write_screen.dart';
import '../../presentation/notes/screens/note_list_screen.dart';
import '../../presentation/todos/screens/todo_screen.dart';
import '../../presentation/mypage/screens/mypage_screen.dart';
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
    GoRoute(
      path: '/notes/write',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: NoteWriteScreen()),
    ),
    GoRoute(
      path: '/notes/detail/:id',
      pageBuilder: (context, state) => NoTransitionPage(
        child: NoteDetailScreen(note: state.extra as NoteModel),
      ),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('페이지를 찾을 수 없어요\n${state.error}', textAlign: TextAlign.center),
    ),
  ),
);
