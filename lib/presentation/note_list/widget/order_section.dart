import 'package:flutter/material.dart';
import 'package:noteapp_flutter/domain/utils/note_order.dart';
import 'package:noteapp_flutter/domain/utils/order_type.dart';
import 'package:noteapp_flutter/presentation/note_list/widget/default_radio_button.dart';

class OrderSection extends StatelessWidget {
  final NoteOrder noteOrder;
  final Function(NoteOrder) onOrderChange;

  const OrderSection({
    super.key,
    required this.noteOrder,
    required this.onOrderChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Row: Title, Date, Color Radio Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DefaultRadioButton(
              text: "Title",
              selected: noteOrder is NoteOrderTitle,
              onSelect: () => onOrderChange(NoteOrderTitle(noteOrder.orderType)),
            ),
            DefaultRadioButton(
              text: "Date",
              selected: noteOrder is NoteOrderDate,
              onSelect: () => onOrderChange(NoteOrderDate(noteOrder.orderType)),
            ),
            DefaultRadioButton(
              text: "Color",
              selected: noteOrder is NoteOrderColor,
              onSelect: () => onOrderChange(NoteOrderColor(noteOrder.orderType)),
            ),
          ],
        ),
        const SizedBox(height: 8.0),

        // Second Row: Ascending, Descending Radio Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DefaultRadioButton(
              text: "Ascending",
              selected: noteOrder.orderType == OrderType.ascending,
              onSelect: () => onOrderChange(noteOrder.copyWith(orderType: OrderType.ascending)),
            ),
            DefaultRadioButton(
              text: "Descending",
              selected: noteOrder.orderType == OrderType.descending,
              onSelect: () => onOrderChange(noteOrder.copyWith(orderType: OrderType.descending)),
            ),
          ],
        ),
      ],
    );
  }
}