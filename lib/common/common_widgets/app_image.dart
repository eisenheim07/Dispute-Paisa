import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A unified image widget that handles every source type in one place:
///
/// • [icon]   — a Flutter [IconData] (tinted with [iconColor], sized by [width])
/// • Asset    — `assets/img.png`, `assets/icon.svg`
/// • Network  — `https://…/img.png`, `https://…/icon.svg`
/// • Inline SVG — raw `<svg …>` markup string
/// • Data URI — `data:image/svg+xml;base64,…`, `data:image/png;base64,…`, etc.
///
/// Falls back to a [broken_image] icon on any error.
class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.source,
    this.icon,
    this.iconColor,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.onTap,
  });

  final String? source;
  final IconData? icon;
  final Color? iconColor;
  final double? width;
  final double? height;
  final BoxFit fit;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = _resolve();
    return onTap != null ? GestureDetector(onTap: onTap, child: child) : child;
  }

  Widget _resolve() {
    // ── Icon ────────────────────────────────────────────────────
    if (icon != null) {
      return Icon(icon, size: width, color: iconColor);
    }

    final src = source?.trim() ?? '';
    if (src.isEmpty) return _broken();

    final lower = src.toLowerCase();

    // ── Data URIs ────────────────────────────────────────────────
    if (lower.startsWith('data:image/')) {
      final comma = src.indexOf(',');
      if (comma == -1) return _broken();
      final header = lower.substring(0, comma);
      final payload = src.substring(comma + 1);

      if (header.contains('svg+xml')) {
        final svg = header.contains('base64')
            ? utf8.decode(base64Decode(payload))
            : Uri.decodeFull(payload);
        return SvgPicture.string(svg, width: width, height: height, fit: fit);
      }

      try {
        final bytes = Uint8List.fromList(base64Decode(payload));
        return Image.memory(bytes, width: width, height: height, fit: fit,
            errorBuilder: (_, __, ___) => _broken());
      } catch (_) {
        return _broken();
      }
    }

    // ── Inline SVG markup ────────────────────────────────────────
    if (src.startsWith('<svg') || src.startsWith('<SVG')) {
      return SvgPicture.string(src, width: width, height: height, fit: fit);
    }

    final isSvg = lower.endsWith('.svg');

    // ── Network ──────────────────────────────────────────────────
    if (lower.startsWith('http://') || lower.startsWith('https://')) {
      return isSvg
          ? SvgPicture.network(src, width: width, height: height, fit: fit,
              placeholderBuilder: (_) => _loading())
          : Image.network(src, width: width, height: height, fit: fit,
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : _loading(),
              errorBuilder: (_, __, ___) => _broken());
    }

    // ── Asset ────────────────────────────────────────────────────
    return isSvg
        ? SvgPicture.asset(src, width: width, height: height, fit: fit,
            placeholderBuilder: (_) => _loading())
        : Image.asset(src, width: width, height: height, fit: fit,
            errorBuilder: (_, __, ___) => _broken());
  }

  Widget _loading() => SizedBox(
        width: width,
        height: height,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );

  Widget _broken() => SizedBox(
        width: width,
        height: height,
        child: const Center(child: Icon(Icons.broken_image_outlined)),
      );
}
