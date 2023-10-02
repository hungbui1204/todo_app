import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:todo_app/blocs/switch_bloc/switch_event.dart';
import 'package:todo_app/blocs/switch_bloc/switch_state.dart';

class SwitchBloc extends HydratedBloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState(switchValue: false)) {
    on<SwitchOnEvent>(_onEvent);
    on<SwitchOffEvent>(_offEvent);
  }
  void _onEvent(SwitchOnEvent event, Emitter<SwitchState> emit) {
    emit(SwitchState(switchValue: true));
  }

  void _offEvent(SwitchOffEvent event, Emitter<SwitchState> emit) {
    emit(SwitchState(switchValue: false));
  }

  @override
  SwitchState? fromJson(Map<String, dynamic> json) {
    return SwitchState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(SwitchState state) {
    return state.toMap();
  }
}
