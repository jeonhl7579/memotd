import 'package:flutter/material.dart';

/// 4px 그리드 기반 고정 크기 상수 모음.
///
/// 네이밍 규칙: s + 숫자(px)
/// 디자인 시스템 토큰과 매핑되는 의미 별칭도 함께 제공한다.
abstract class Sizes {
  // ── Base grid ─────────────────────────────────────────────────────────────
  static const double s4 = 4;
  static const double s8 = 8;
  static const double s12 = 12;
  static const double s16 = 16;
  static const double s20 = 20;
  static const double s24 = 24;
  static const double s28 = 28;
  static const double s32 = 32;
  static const double s40 = 40;
  static const double s48 = 48;
  static const double s56 = 56;
  static const double s64 = 64;
  static const double s80 = 80;
  static const double s96 = 96;

  // ── Border radius ─────────────────────────────────────────────────────────
  static const double radiusXs = s4;
  static const double radiusSm = s8;
  static const double radiusMd = s12;
  static const double radiusLg = s16;
  static const double radiusXl = s24; // Chip pill, Tag: xl(1.5rem)
  static const double radiusFull = 999;

  // ── Spacing tokens (design.md 기준) ───────────────────────────────────────
  /// 아이템 간 간격 — "2 (0.5rem)"
  static const double itemSpacing = s8;

  /// 논리 그룹 간 간격 — "12 (3rem)"
  static const double groupSpacing = s48;

  /// 주요 섹션 간 간격 — "24 (6rem)"
  static const double sectionSpacing = s96;

  // ── Component sizes ───────────────────────────────────────────────────────
  /// 바텀 네비게이션 바 콘텐츠 높이
  static const double navBarHeight = s64;

  /// FAB 크기 (width / height)
  static const double fabSize = s56;

  /// FAB 하단 여백 — "20 (5rem)"
  static const double fabBottomPadding = s80;
}

/// [Sizes] 값을 기반으로 한 [SizedBox] 단축 위젯 모음.
///
/// 수직 간격: Gaps.v*  /  수평 간격: Gaps.h*
abstract class Gaps {
  // ── Vertical ──────────────────────────────────────────────────────────────
  static const SizedBox v4 = SizedBox(height: Sizes.s4);
  static const SizedBox v8 = SizedBox(height: Sizes.s8);
  static const SizedBox v12 = SizedBox(height: Sizes.s12);
  static const SizedBox v16 = SizedBox(height: Sizes.s16);
  static const SizedBox v20 = SizedBox(height: Sizes.s20);
  static const SizedBox v24 = SizedBox(height: Sizes.s24);
  static const SizedBox v32 = SizedBox(height: Sizes.s32);
  static const SizedBox v40 = SizedBox(height: Sizes.s40);
  static const SizedBox v48 = SizedBox(height: Sizes.s48);
  static const SizedBox v64 = SizedBox(height: Sizes.s64);
  static const SizedBox v80 = SizedBox(height: Sizes.s80);
  static const SizedBox v96 = SizedBox(height: Sizes.s96);

  // ── Horizontal ────────────────────────────────────────────────────────────
  static const SizedBox h4 = SizedBox(width: Sizes.s4);
  static const SizedBox h8 = SizedBox(width: Sizes.s8);
  static const SizedBox h12 = SizedBox(width: Sizes.s12);
  static const SizedBox h16 = SizedBox(width: Sizes.s16);
  static const SizedBox h20 = SizedBox(width: Sizes.s20);
  static const SizedBox h24 = SizedBox(width: Sizes.s24);
  static const SizedBox h32 = SizedBox(width: Sizes.s32);
  static const SizedBox h40 = SizedBox(width: Sizes.s40);
  static const SizedBox h48 = SizedBox(width: Sizes.s48);
  static const SizedBox h64 = SizedBox(width: Sizes.s64);
}
