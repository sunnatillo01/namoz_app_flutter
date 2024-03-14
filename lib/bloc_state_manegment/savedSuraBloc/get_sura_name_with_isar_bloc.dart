import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/isar_sura/user.dart';
import '../../services/iser_service/isar_service.dart';

part 'get_sura_name_with_isar_event.dart';
part 'get_sura_name_with_isar_state.dart';

class GetSuraNameWithIsarBloc
    extends Bloc<GetSuraNameWithIsarEvent, GetSuraNameWithIsarState> {
  GetSuraNameWithIsarBloc() : super(GetSuraNameWithIsarInitial()) {
    on<StartSuraNameWithIsarEvent>(getIsarSuraNameAndIndex);
    on<RemoveSuraNameWithIsarEvent>(removeIsarSuraNameAndIndex);
  }

  Future<void> getIsarSuraNameAndIndex(
    StartSuraNameWithIsarEvent event,
    Emitter<GetSuraNameWithIsarState> emmit,
  ) async {
    List newUser = await IsarService().getAllSura();
    emmit(StartSuraNameWithIsarState(newUser.cast<User>()));
  }

  Future<void> removeIsarSuraNameAndIndex(
    RemoveSuraNameWithIsarEvent event,
    Emitter<GetSuraNameWithIsarState> emmit,
  ) async {
    await IsarService().removeSura(event.id);
    emmit(ReloadingSuraNameWithIsarState());
  }
}
