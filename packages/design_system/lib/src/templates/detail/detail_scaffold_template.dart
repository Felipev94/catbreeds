import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';

class DetailScaffoldTemplate extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;
  final Widget? staticHeader;
  final Widget content;
  final bool scrollable;

  const DetailScaffoldTemplate({
    required this.content,
    this.title,
    this.onBack,
    this.staticHeader,
    this.scrollable = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: AppBar(
        title: title != null
            ? Text(
                title!,
                style: context.typography.titleMedium?.copyWith(
                  color: context.colors.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              )
            : null,
        centerTitle: false,
        backgroundColor: context.colors.surface,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            size: context.dimensions.dimensionLg,
            color: context.colors.textPrimary,
          ),
          onPressed: onBack ?? () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ?staticHeader,
          Expanded(
            child: scrollable
                ? RawScrollbar(
                    thumbColor: context.colors.borderFocus,
                    radius: Radius.circular(context.dimensions.dimensionXs),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: content,
                    ),
                  )
                : content,
          ),
        ],
      ),
    );
  }
}
