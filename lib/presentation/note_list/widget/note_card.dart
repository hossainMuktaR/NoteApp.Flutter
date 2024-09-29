import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:noteapp_flutter/domain/model/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDeleteClick;
  final VoidCallback onClickItem;
  final double cutCornerSize;
  final double cornerRadius;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDeleteClick,
    required this.onClickItem,
    this.cutCornerSize = 20.0,
    this.cornerRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClickItem(),
      child: Stack(
        children: [
          ClipPath(
            clipper: NoteClipper(cutCornerSize: cutCornerSize),
            child: Container(
              decoration: BoxDecoration(
                color: Color(note.color),
                borderRadius: BorderRadius.circular(cornerRadius),
              ),
              child: CustomPaint(
                painter: CornerPainter(
                  color: Color(note.color),
                  cutCornerSize: cutCornerSize,
                  cornerRadius: cornerRadius,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        note.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: onDeleteClick,
            ),
          ),
        ],
      ),
    );
  }
}

class NoteClipper extends CustomClipper<Path> {
  final double cutCornerSize;

  NoteClipper({required this.cutCornerSize});

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width - cutCornerSize, 0.0);
    path.lineTo(size.width, cutCornerSize);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(NoteClipper oldClipper) => false;
}

class CornerPainter extends CustomPainter {
  final Color color;
  final double cutCornerSize;
  final double cornerRadius;

  CornerPainter({
    required this.color,
    required this.cutCornerSize,
    required this.cornerRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ui.Color.lerp(color, Colors.black, 0.2)!
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(
      size.width - cutCornerSize,
      -100.0,
      cutCornerSize + 100.0,
      100.0 + cutCornerSize,
    );

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius));

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
