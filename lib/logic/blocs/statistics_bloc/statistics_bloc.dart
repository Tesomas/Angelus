import 'package:hydrated_bloc/hydrated_bloc.dart';

abstract class PrayedCounterEvent{}

class PrayedCounterIncrement extends PrayedCounterEvent{}

class PrayerCounterClearIncrement extends PrayedCounterEvent{}

class StatisticsBloc extends HydratedBloc<PrayedCounterEvent, int>{
  StatisticsBloc():super(0){
    on<PrayedCounterIncrement>((event, emit) => emit(state + 1));
    on<PrayerCounterClearIncrement>((event, emit) => emit(0));
  }

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json["prayerCount"] as int;
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return {"prayerCount" : state};
  }
}