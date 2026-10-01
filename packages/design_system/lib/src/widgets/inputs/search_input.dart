import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

class SearchInput extends StatefulWidget {
  static const double _SEARCH_ICON_SIZE = AppSpacing.MD + AppSpacing.XS;
  static const double _CLEAR_ICON_SIZE = AppSpacing.MD + AppSpacing.XXS;
  static const double _FOCUSED_BORDER_WIDTH = AppSpacing.XXS;

  final String? hint;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final bool enabled;
  final bool showClearButton;
  final bool readOnly;

  const SearchInput({
    super.key,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.onTap,
    this.focusNode,
    this.enabled = true,
    this.showClearButton = true,
    this.readOnly = false,
  });

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  bool _ownsController = false;
  bool _ownsFocusNode = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = TextEditingController();
      _ownsController = true;
    } else {
      _controller = widget.controller!;
    }

    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _ownsFocusNode = true;
    } else {
      _focusNode = widget.focusNode!;
    }

    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    if (_ownsController) _controller.dispose();
    if (_ownsFocusNode) _focusNode.dispose();
    super.dispose();
  }

  void _onControllerChanged() {
    final bool hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final typography = context.typography;

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      onTap: widget.onTap,
      textInputAction: TextInputAction.search,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      style: typography.bodyMedium?.copyWith(color: colors.textPrimary),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: typography.bodyMedium?.copyWith(color: colors.textMuted),
        filled: true,
        fillColor: widget.enabled ? colors.surface : colors.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.MD,
          vertical: AppSpacing.SM,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: colors.textMuted,
          size: SearchInput._SEARCH_ICON_SIZE,
        ),
        suffixIcon: widget.showClearButton && _hasText
            ? IconButton(
                onPressed: _clearText,
                icon: Icon(
                  Icons.close_rounded,
                  color: colors.textMuted,
                  size: SearchInput._CLEAR_ICON_SIZE,
                ),
                splashRadius: AppSpacing.MD,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_FULL,
          borderSide: BorderSide(color: colors.borderSubtle),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_FULL,
          borderSide: BorderSide(color: colors.borderSubtle),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_FULL,
          borderSide: BorderSide(
            color: colors.borderFocus,
            width: SearchInput._FOCUSED_BORDER_WIDTH,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.RADIUS_FULL,
          borderSide: BorderSide(color: colors.borderSubtle),
        ),
      ),
    );
  }
}
