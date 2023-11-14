import "package:flutter/material.dart";

class PageNavWidget extends StatelessWidget {
  final VoidCallback? next;
  final VoidCallback? prev;
  final String? nextLabel;

  const PageNavWidget({
    super.key,
    this.next,
    this.prev,
    this.nextLabel = "next",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: prev,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 0.75,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    bottomLeft: Radius.circular(24.0),
                  ),
                ),
                foregroundColor:
                    Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              icon: const RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.arrow_right_alt_rounded,
                  size: 26.0,
                ),
              ),
              label: const Text("prev"),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: OutlinedButton.icon(
                onPressed: next,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.75,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0),
                    ),
                  ),
                  disabledForegroundColor: Colors.grey,
                  foregroundColor:
                      Theme.of(context).colorScheme.onSecondaryContainer,
                ),
                icon: const Icon(
                  Icons.arrow_right_alt_rounded,
                  size: 26.0,
                ),
                label: Text(nextLabel!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
