import "package:crowdy/src/core/enums/interests_enum.dart";
import "package:crowdy/src/core/extensions/extensions.dart";
import "package:flutter/material.dart";

class InterestsPickerWidget extends StatefulWidget {
  final Interests interest;
  final bool isSelected;
  final void Function(bool picked) onSelect;

  const InterestsPickerWidget({
    super.key,
    required this.interest,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  State<InterestsPickerWidget> createState() => _InterestsPickerWidgetState();
}

class _InterestsPickerWidgetState extends State<InterestsPickerWidget> {
  bool hasSelect = false;

  @override
  void initState() {
    super.initState();
    hasSelect = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          hasSelect = !hasSelect;
        });
        return widget.onSelect(hasSelect);
      },
      child: Opacity(
        opacity: hasSelect ? 1.0 : 0.3,
        child: Chip(
          label: Text(widget.interest.name.capital),
          labelPadding: const EdgeInsets.all(4.0),
          padding: const EdgeInsets.all(8.0),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          shape: const StadiumBorder(
            side: BorderSide.none,
          ),
          side: BorderSide.none,
          labelStyle: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          // avatar: hasSelect
          //     ? const Icon(
          //         Icons.done_rounded,
          //         size: 24.0,
          //         color: Colors.white,
          //       )
          //     : null,
        ),
      ),
    );
  }
}
