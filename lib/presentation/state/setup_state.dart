import 'package:equatable/equatable.dart';
import 'package:flutter_app/ui/model/round_model.dart';

abstract class SetupState extends Equatable {
  const SetupState();
}

class InitialSetupState extends SetupState {
  final int numberField;
  List<RoundModel> items;

  InitialSetupState(this.numberField, {this.items});

  @override
  List<Object> get props => [numberField, items];
}

