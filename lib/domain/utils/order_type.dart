import 'package:noteapp_flutter/domain/utils/note_order.dart';

abstract class NoteOrder {
  final OrderType orderType;
  NoteOrder(this.orderType);

  NoteOrder copyWith({OrderType? orderType});
}

class NoteOrderTitle extends NoteOrder {
  NoteOrderTitle(super.orderType);

  @override
  NoteOrder copyWith({OrderType? orderType}) {
    return NoteOrderTitle(orderType ?? this.orderType);
  }
}

class NoteOrderDate extends NoteOrder {
  NoteOrderDate(super.orderType);

  @override
  NoteOrder copyWith({OrderType? orderType}) {
    return NoteOrderDate(orderType ?? this.orderType);
  }
}

class NoteOrderColor extends NoteOrder {
  NoteOrderColor(super.orderType);

  @override
  NoteOrder copyWith({OrderType? orderType}) {
    return NoteOrderColor(orderType ?? this.orderType);
  }
}