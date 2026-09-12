import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_responsive.dart';

/// A unified image widget that handles every source type in one place:
///
/// • [icon]   — a Flutter [IconData] (tinted with [iconColor], sized by [width])
/// • Asset    — `assets/img.png`, `assets/icon.svg`
/// • Network  — `https://…/img.png`, `https://…/icon.svg`
/// • Inline SVG — raw `<svg …>` markup string
/// • Data URI — `data:image/svg+xml;base64,…`, `data:image/png;base64,…`, etc.
///
/// [width] and [height] are **design-px values** (same numbers you'd use in
/// Figma / the design spec). They are automatically scaled via [AppResponsive]
/// so the image is proportionally sized on every screen.
///
/// Default size: 100 × 100 design-px.
///
/// Example usage:
/// ```dart
/// SmartImage(source: 'assets/logo.svg')
/// SmartImage(source: 'https://example.com/photo.jpg', width: 200, height: 150)
/// SmartImage(icon: Icons.person, iconColor: Colors.grey, width: 24)
/// ```
class SmartImage extends StatelessWidget {
  const SmartImage({
    super.key,
    this.source,
    this.icon,
    this.iconColor,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.contain,
    this.onTap,
  });

  /// Image source — asset path, http(s) URL, inline SVG markup, or data URI.
  final String? source;

  /// When set, renders a Flutter [Icon] instead of an image.
  final IconData? icon;

  /// Tint colour for [icon].
  final Color? iconColor;

  /// Design-px width. Defaults to `100`. Scaled via [AppResponsive.w].
  final double width;

  /// Design-px height. Defaults to `100`. Scaled via [AppResponsive.h].
  final double height;

  /// Defaults to [BoxFit.contain].
  final BoxFit fit;

  /// Optional tap callback.
  final VoidCallback? onTap;

  // Responsive scaled values used internally.
  double get _w => AppResponsive.w(width);

  double get _h => AppResponsive.h(height);

  @override
  Widget build(BuildContext context) {
    final child = _resolve();
    return onTap != null ? GestureDetector(onTap: onTap, child: child) : child;
  }

  Widget _resolve() {
    // ── Icon ─────────────────────────────────────────────────────
    if (icon != null) {
      return Icon(icon, size: _w, color: iconColor);
    }

    final src = source?.trim() ?? '';
    if (src.isEmpty) return _broken();

    final lower = src.toLowerCase();

    // ── Data URIs ─────────────────────────────────────────────────
    if (lower.startsWith('data:image/')) {
      final comma = src.indexOf(',');
      if (comma == -1) return _broken();
      final header = lower.substring(0, comma);
      final payload = src.substring(comma + 1);

      if (header.contains('svg+xml')) {
        final svg = header.contains('base64') ? utf8.decode(base64Decode(payload)) : Uri.decodeFull(payload);
        return SvgPicture.string(svg, width: _w, height: _h, fit: fit);
      }

      try {
        final bytes = Uint8List.fromList(base64Decode(payload));
        return Image.memory(bytes, width: _w, height: _h, fit: fit, errorBuilder: (_, __, ___) => _broken());
      } catch (_) {
        return _broken();
      }
    }

    // ── Inline SVG markup ─────────────────────────────────────────
    if (src.startsWith('<svg') || src.startsWith('<SVG')) {
      return SvgPicture.string(src, width: _w, height: _h, fit: fit);
    }

    final isSvg = lower.endsWith('.svg');

    // ── Network ───────────────────────────────────────────────────
    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return isSvg
          ? SvgPicture.network(src, width: _w, height: _h, fit: fit, placeholderBuilder: (_) => _loading())
          : Image.network(
              src,
              width: _w,
              height: _h,
              fit: fit,
              loadingBuilder: (_, child, progress) => progress == null ? child : _loading(),
              errorBuilder: (_, __, ___) => _broken(),
            );
    }

    // ── Asset ─────────────────────────────────────────────────────
    return isSvg
        ? SvgPicture.asset(src, width: _w, height: _h, fit: fit, placeholderBuilder: (_) => _loading())
        : Image.asset(src, width: _w, height: _h, fit: fit, errorBuilder: (_, __, ___) => _broken());
  }

  Widget _loading() => SizedBox(
    width: _w,
    height: _h,
    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
  );

  Widget _broken() => SizedBox(
    width: _w,
    height: _h,
    child: const Center(child: Icon(Icons.broken_image_outlined, color: Colors.grey)),
  );
}
