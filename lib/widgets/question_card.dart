import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  final Function(int) onOptionSelected;
  final int? selectedIndex;
  final bool isAnswered;
  final bool isTimerFinished;

  const QuestionCard({
    super.key,
    required this.question,
    required this.onOptionSelected,
    this.selectedIndex,
    this.isAnswered = false,
    this.isTimerFinished = false,
  });

  // FIX: dynamic letter generation instead of hardcoded 4-item list —
  // won't crash if a question ever has more than 4 options
  String _letterFor(int index) =>
      String.fromCharCode(65 + index); // A, B, C, D, E...

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //   itemCount: question.options.length,
    //   itemBuilder: (context, index) {
    //     return Padding(
    //       padding: const EdgeInsets.only(bottom: 12),
    //       child: _buildOption(
    //         context,
    //         letter: _letterFor(index),
    //         text: question.options[index],
    //         index: index,
    //       ),
    //     );
    //   },
    // );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(question.options.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildOption(
            context,
            letter: _letterFor(index),
            text: question.options[index],
            index: index,
          ),
        );
      }),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String letter,
    required String text,
    required int index,
  }) {
    bool isSelected = selectedIndex == index;
    bool isCorrect = index == question.correctAnswerIndex;
    bool showResult = isAnswered || isTimerFinished;

    Color? backgroundColor;
    Color? borderColor;
    Color textColor = Colors.white;
    Color letterColor = Colors.white;

    if (showResult) {
      if (isCorrect) {
        backgroundColor = Colors.green.withValues(alpha: 0.2);
        borderColor = Colors.green;
        letterColor = Colors.green;
      } else if (isSelected && !isCorrect) {
        backgroundColor = Colors.red.withValues(alpha: 0.2);
        borderColor = Colors.red;
        letterColor = Colors.red;
      } else {
        backgroundColor = Colors.white.withValues(alpha: 0.05);
        borderColor = Colors.white.withValues(alpha: 0.1);
      }
    } else {
      if (isSelected) {
        backgroundColor = Theme.of(context).primaryColor.withValues(alpha: 0.2);
        borderColor = Theme.of(context).primaryColor;
      } else {
        backgroundColor = Colors.white.withValues(alpha: 0.05);
        borderColor = Colors.white.withValues(alpha: 0.1);
      }
    }

    // Disable interaction if answered or timer finished
    bool isEnabled = !isAnswered && !isTimerFinished;

    return GestureDetector(
      onTap: isEnabled ? () => onOptionSelected(index) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isSelected || showResult
                    ? (isCorrect
                          ? Colors.green
                          : isSelected
                          ? Colors.red
                          : Colors.white.withValues(alpha: 0.1))
                    : Colors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  letter,
                  style: TextStyle(
                    color: letterColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ),
            if (showResult && isCorrect)
              const Icon(Icons.check_circle, color: Colors.green, size: 24),
            if (showResult && isSelected && !isCorrect)
              const Icon(Icons.cancel, color: Colors.red, size: 24),
          ],
        ),
      ),
    );
  }
}
