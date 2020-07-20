import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/custom_route.dart';
import 'package:flutter_app/presentation/bloc/setup_bloc.dart';
import 'package:flutter_app/presentation/bloc/timer_bloc.dart';
import 'package:flutter_app/presentation/event/setup_event.dart';
import 'package:flutter_app/presentation/event/timer_event.dart';
import 'package:flutter_app/presentation/state/setup_state.dart';
import 'package:flutter_app/ui/localization/keys.dart';
import 'package:flutter_app/ui/screen/base_screen.dart';
import 'package:flutter_app/ui/widget/red_material_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.black,
        body: WillPopScope(
          onWillPop: () {},
          child: SafeArea(
              child: BaseScreen(child: BlocBuilder<SetupBloc, SetupState>(
            builder: (context, state) {
              if (state is InitialSetupState) {
                return Center(
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      formContent(state.numberField ?? 0, state),
                    ],
                  )),
                );
              }
            },
          ))),
        ),
      );

  Widget formContent(int numberField, InitialSetupState state) => Center(
        child: Form(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: TextFormField(
                  validator: (val) =>
                      val.isEmpty ? translate(Keys.Round) : null,
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    BlocProvider.of<SetupBloc>(context)
                        .add(InputRoundeFormesEvent(int.tryParse(value)));
                  },
                  decoration: _inputDecoration.copyWith(
                      labelText: translate(Keys.Txt_Input_Round)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: RedMaterialButton(
                  title: translate(Keys.Btn_Generate_Timer_Field),
                  onPressed: () async {
                    BlocProvider.of<SetupBloc>(context).add(BuildFormesEvent());
                  },
                ),
              ),
              Container(
                color: Colors.lightBlue,
                child: ListView(
                  shrinkWrap: true,
                  children: List.generate(numberField, (index) {
                    return fieldItem(index);
                  }),
                ),
              ),
              numberField != 0
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, left: 16.0, right: 16.0, bottom: 16.0),
                      child: RedMaterialButton(
                        title: translate(Keys.Btn_Start),
                        onPressed: () async {
                          BlocProvider.of<TimerBloc>(context)
                              .add(LoadTimer(state.items));
                          Navigator.pushNamed(
                              context, CustomRoute.TIMER_SCREEN);
                        },
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      );

  // Building each field in the loop by parameter numberField
  Widget fieldItem(int numberField) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${translate(Keys.Round_Description, args: {
                "number": numberField + 1
              })}",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: TextFormField(
                    validator: (val) =>
                        val.isEmpty ? translate(Keys.Round) : null,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      BlocProvider.of<SetupBloc>(context).add(
                          InputItemRoundWorkFormesEvent(numberField, value));
                    },
                    decoration: _inputDecoration.copyWith(
                        labelText: translate(
                            Keys.Txt_Input_Duration_Of_Round_Work,
                            args: {"number": numberField + 1})),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: TextFormField(
                    validator: (val) =>
                        val.isEmpty ? translate(Keys.Round) : null,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    onChanged: (value) {
                      BlocProvider.of<SetupBloc>(context).add(
                          InputItemRoundRestFormesEvent(numberField, value));
                    },
                    decoration: _inputDecoration.copyWith(
                        labelText: translate(
                            Keys.Txt_Input_Duration_Of_Round_Rest,
                            args: {"number": numberField + 1})),
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  // Styling for text field decoration
  InputDecoration get _inputDecoration => InputDecoration(
        fillColor: Color(0xFFFFFFFF),
        filled: true,
        labelStyle: TextStyle(color: Color(0xFFFF473D), fontSize: 14),
        contentPadding: EdgeInsets.all(12.0),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFFFFFF),
            width: 2.0,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.14),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black.withOpacity(0.14), width: 1.0),
        ),
      );
}
