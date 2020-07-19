import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/bloc/timer_bloc.dart';
import 'package:flutter_app/presentation/event/timer_event.dart';
import 'package:flutter_app/presentation/state/timer_state.dart';
import 'package:flutter_app/ui/localization/keys.dart';
import 'package:flutter_app/ui/model/time_stage.dart';
import 'package:flutter_app/ui/screen/base_screen.dart';
import 'package:flutter_app/ui/widget/action_button.dart';
import 'package:flutter_app/utils/formatting_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/global.dart';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<TimerBloc, TimerState>(
          listener: (context, state) {
            if (state is TimerFinish) {
              Navigator.pop(context);
            }
          },
          child: BaseScreen(child:
              BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
            if (state is TimerInitial) {
              return Container(
                color: state.timeStage == TimeStage.WORK
                    ? Colors.blueGrey
                    : Colors.black,
                child: Column(
                  children: <Widget>[
                    Expanded(flex: 2, child: topBlock(state.round)),
                    Expanded(
                        flex: 8,
                        child: clockBlock(state.tikSeconds, state.timeStage)),
                    Expanded(flex: 3, child: navigationBlock()),
                    Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          state.bottomInfo ?? "",
                          style: TextStyle(color: Colors.grey),
                        ))
                  ],
                ),
              );
            }
            return Text("Some happend");
          })),
        ),
      ),
    );
  }


  @override
  void dispose() {
    BlocProvider.of<TimerBloc>(context)
        .add(DisposeAction());
    super.dispose();
  }

  Widget topBlock(int number) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Container(
          color: Colors.yellow,
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 42.0),
          child: Text(
            "${translate(Keys.Round, args: {"number": number})}",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }

  Widget clockBlock(int round, TimeStage timeStage) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            FormattingUtils.printDuration(round),
            style: TextStyle(color: Colors.red, fontSize: 140.0),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(16.0),
            child: Text(
              timeStage == TimeStage.WORK
                  ? translate(Keys.Work)
                  : translate(Keys.Rest),
              style: TextStyle(fontSize: 24.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget navigationBlock() {
    return Row(
      children: <Widget>[
        Expanded(
            child: ActionButton(
          icon: Icons.play_arrow,
          callback: () {
            BlocProvider.of<TimerBloc>(context)
                .add(ResumeAction());
          },
        )),
        Expanded(
            child: ActionButton(
          icon: Icons.stop,
          callback: () {
            BlocProvider.of<TimerBloc>(context)
                .add(PauseAction());
          },
        )),
      ],
    );
  }
}
