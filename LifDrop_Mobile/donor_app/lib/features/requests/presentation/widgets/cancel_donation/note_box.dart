import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class NoteBox extends StatelessWidget {
  const NoteBox({super.key, required this.noteController});
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          context.localizations.optional_note_label,
          style: context.textStyles.font12SecondaryBold.copyWith(
            letterSpacing: 0.5,
          ),
        ),
        verticalSpace(6),
        TextField(
          controller: noteController,
          keyboardType: TextInputType.multiline,
          maxLines: 7,
          minLines: 5,
          cursorColor: context.colors.textPrimary,
          style: context.isDarkMode
              ? context.textStyles.font14WhiteRegular
              : context.textStyles.font14BlackRegular,
        ),
      ],
    );
  }
}
