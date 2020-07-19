import 'package:equatable/equatable.dart';

abstract class SetupEvent extends Equatable {
  const SetupEvent();
}

class InputRoundeFormesEvent extends SetupEvent {
  final int numberOfFields;

  const InputRoundeFormesEvent(this.numberOfFields);

  @override
  List<Object> get props => [numberOfFields];
}

class BuildFormesEvent extends SetupEvent {
  @override
  List<Object> get props => [];
}

class InputItemRoundWorkFormesEvent extends SetupEvent {
  final int item;
  final String value;

  const InputItemRoundWorkFormesEvent(this.item, this.value);

  @override
  List<Object> get props => [item, value];
}


class InputItemRoundRestFormesEvent extends SetupEvent {
  final int item;
  final String value;

  const InputItemRoundRestFormesEvent(this.item, this.value);

  @override
  List<Object> get props => [item, value];
}
