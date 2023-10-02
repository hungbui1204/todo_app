import 'package:equatable/equatable.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();
}

class SwitchOnEvent extends SwitchEvent {
  final bool value;
  const SwitchOnEvent({required this.value});
  @override
  List<Object?> get props => [value];
}

class SwitchOffEvent extends SwitchEvent {
  final bool value;
  const SwitchOffEvent({required this.value});

  @override
  List<Object?> get props => [value];
}
