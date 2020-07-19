import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/domain/repository/impl/info_repository_impl.dart';
import 'package:flutter_app/domain/repository/info_repository.dart';
import 'package:flutter_app/presentation/event/timer_event.dart';
import 'package:flutter_app/presentation/state/timer_state.dart';
import 'package:flutter_app/ui/model/rounde_model.dart';
import 'package:flutter_app/ui/model/time_stage.dart';
import 'package:flutter_app/utils/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  InfoRepository infoRepository = InfoRepositoryImpl();
  Ticker _ticker = Ticker();
  int round = 0;
  TimeStage timeStage = TimeStage.WORK;

  List<RoundModel> _intervals;

  int timerInitial = 0;
  StreamSubscription<int> _tickerSubscription;
  String motivationalWord;

  TimerBloc() {
    assert(infoRepository != null);
  }

  @override
  TimerState get initialState =>
      TimerInitial(0, 0, TimeStage.WORK, bottomInfo: motivationalWord);

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is LoadTimer) {
      yield* _mapInitiateTimerToState(event);
    }
    if (event is TimerTick) {
      yield* _mapTimerTickToState(event);
    }

    if (event is ResumeAction) {
      _tickerSubscription.resume();
    }

    if (event is PauseAction) {
      _tickerSubscription.pause();
    }
    if (event is DisposeAction) {
      _tickerSubscription?.cancel();
    }
  }

  Stream<TimerState> _mapInitiateTimerToState(LoadTimer event) async* {
    timeStage= TimeStage.WORK;
    yield TimerInitial(1, event.items[0].work, timeStage, bottomInfo: motivationalWord);
    motivationalWord = await infoRepository.fetchInfoString();
    round = 1;
    _intervals = event.items;
    _tickerSubscription?.cancel();
    RoundModel roundModel = _intervals[round - 1];
    roundModel.timestage = TimeStage.WORK;
    _tickerSubscription = _ticker
        .tick(ticks: _intervals[round - 1].work)
        .listen((duration) => add(TimerTick(duration, round)));
  }

  Stream<TimerState> _mapTimerTickToState(TimerTick event) async* {
    debugPrint("inLoop${event.rounde} ${event.value}");
    yield TimerInitial(event.rounde, event.value, timeStage,
        bottomInfo: motivationalWord);
    if (event.value == 0) {
      if (_intervals[event.rounde - 1].timestage == TimeStage.WORK) {
        yield* startRest(_intervals[event.rounde - 1]);
      } else if (event.rounde < _intervals.length) {
        yield* nextRound(_intervals[event.rounde]);
      } else {
        yield* closeRound();
      }
    }
  }

  Stream<TimerState> startRest(RoundModel interval) {
    timeStage = TimeStage.REST;
    interval.timestage = timeStage;
    _tickerSubscription.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: interval.rest)
        .listen((duration) => add(TimerTick(duration, round)));
  }

  Stream<TimerState> nextRound(RoundModel interval) {
    round++;
    _tickerSubscription?.cancel();
    timeStage = TimeStage.WORK;
    interval.timestage = timeStage;
    _tickerSubscription = _ticker
        .tick(ticks: interval.work)
        .listen((duration) => add(TimerTick(duration, round)));
  }

  Stream<TimerState> closeRound() async* {
    yield TimerFinish();
  }
}
