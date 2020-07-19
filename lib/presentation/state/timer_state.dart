import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/model/time_stage.dart';

@immutable
abstract class TimerState extends Equatable {
  const TimerState();
}

class TimerInitial extends TimerState {
  final int round;
  final int tikSeconds;
  final TimeStage timeStage;
  String bottomInfo;

  TimerInitial(this.round, this.tikSeconds, this.timeStage, {this.bottomInfo});

  @override
  List<Object> get props => [round, tikSeconds];
}

class TimerLoaded extends TimerState {
  final String bottomString;

  const TimerLoaded(this.bottomString);

  @override
  List<Object> get props => [bottomString];
}

class TimerError extends TimerState {
  final String error;

  const TimerError(this.error);

  @override
  List<Object> get props => [error];
}

class TimerFinish extends TimerState {

  @override
  List<Object> get props =>[];

}