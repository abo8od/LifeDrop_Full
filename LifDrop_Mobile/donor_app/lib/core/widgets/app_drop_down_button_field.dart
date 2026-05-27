import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropdownButtonField<V, T> extends StatelessWidget {
  /// A reusable dropdown field.
  ///
  /// [V] → value type (e.g. String id)
  ///
  /// [T] → item type (e.g. Object with id and name)
  ///
  /// Example:
  /// ```dart
  /// AppDropdownField<String, Object>(
  ///   controller: Object.id,
  ///   items: Objects,
  /// )
  /// ```
  ///
  /// Note: Controller can be null, so handle null safely.
  const AppDropdownButtonField({
    super.key,
    required this.isLoading,
    required this.controller,
    required this.items,
    required this.valueBuilder,
    required this.labelBuilder,
    required this.title,
    this.itemStyle,
    this.hintStyle,
    required this.hintText,
    this.onChanged,
    this.isDense = true,
  });
  final ValueNotifier<V?> controller;
  final List<T> items;
  final V Function(T item) valueBuilder;
  final String Function(T item) labelBuilder;
  final void Function(V? value)? onChanged;

  final String hintText;
  final String title;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final bool isDense;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: context.textStyles.font12SecondaryBold.copyWith(
            letterSpacing: 0.5,
          ),
        ),
        verticalSpace(6),
        isLoading
            ? Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 15.h),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    constraints: BoxConstraints(
                      minHeight: 20,
                      minWidth: 20,
                      maxHeight: 20,
                      maxWidth: 20,
                    ),
                  ),
                ),
              )
            : ValueListenableBuilder<V?>(
                valueListenable: controller,
                builder: (context, selectedValue, child) {
                  return DropdownButtonFormField<V?>(
                    isExpanded: true,
                    initialValue: selectedValue,
                    borderRadius: BorderRadius.circular(12),
                    isDense: isDense ? true : selectedValue == null,
                    hint: Text(
                      hintText,
                      style:
                          hintStyle ??
                          context.textStyles.font16TextPlaceHolderMedium50Faded,
                    ),
                    items: items
                        .map(
                          (item) => DropdownMenuItem<V>(
                            value: valueBuilder(item),
                            child: Text(
                              labelBuilder(item),
                              maxLines: null,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.start,
                              style:
                                  itemStyle ??
                                  context.textStyles.font14TextPrimaryBold,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != selectedValue) {
                        controller.value = value;
                        onChanged?.call(value);
                      }
                    },
                  );
                },
              ),
      ],
    );
  }
}
