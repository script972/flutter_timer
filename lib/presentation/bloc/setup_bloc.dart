import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/presentation/event/setup_event.dart';
import 'package:flutter_app/presentation/state/setup_state.dart';
import 'package:flutter_app/ui/model/rounde_model.dart';

class SetupBloc extends Bloc<SetupEvent, SetupState> {
  int numberOfForms = 0;
  List<RoundModel> items = [];
  int round = 0;

  @override
  SetupState get initialState => InitialSetupState(0);

  @override
  Stream<SetupState> mapEventToState(SetupEvent event) async* {
    if (event is InputRoundeFormesEvent) {
      numberOfForms = event.numberOfFields ?? 0;
    }
    if (event is InputItemRoundWorkFormesEvent) {
      RoundModel temp;
      if (items.length > event.item) {
        temp = items[event.item];
        temp.work = int.parse(event.value);
        items[event.item] = temp;
      } else {
        temp = RoundModel(work: int.parse(event.value));
        items.add(temp);
      }
      yield InitialSetupState(numberOfForms, items: items);
    }

    if (event is InputItemRoundRestFormesEvent) {
      RoundModel temp;
      if (items.length > event.item) {
        temp = items[event.item];
        temp.rest = int.parse(event.value);
        items[event.item] = temp;
      } else {
        temp = RoundModel(rest: int.parse(event.value));
        items.add(temp);
      }
      yield InitialSetupState(numberOfForms, items: items);
    }


    if (event is BuildFormesEvent) {
      yield InitialSetupState(numberOfForms);
    }
  }
}
