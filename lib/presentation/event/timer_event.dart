import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/model/rounde_model.dart';

@immutable
abstract class TimerEvent extends Equatable {
  const TimerEvent();
}

class LoadTimer extends TimerEvent {
  final List<RoundModel> items;

  LoadTimer(this.items);

  @override
  List<Object> get props => [items];
}

class TimerTick extends TimerEvent {
  int value;
  int rounde;

  TimerTick(this.value, this.rounde);

  @override
  List<Object> get props => [value, rounde];
}

class StartTimerEvent extends TimerEvent {
  StartTimerEvent();

  @override
  List<Object> get props => [];
}

class ResumeAction extends TimerEvent {
  @override
  List<Object> get props => [];
}

class PauseAction extends TimerEvent {
  @override
  List<Object> get props => [];
}

class DisposeAction extends TimerEvent {
  @override
  List<Object> get props => [];
}


