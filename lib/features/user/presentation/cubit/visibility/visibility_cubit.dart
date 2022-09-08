import 'package:flutter_bloc/flutter_bloc.dart';
part 'visibility_state.dart';

class VisibilityCubit extends Cubit<VisibilityState> {
  VisibilityCubit() : super(VisibilityInitial());

  /// PASSWORD VISIBILITY
  bool isVisible = false;

  void changeVisibility() {
    isVisible = !isVisible;
    emit(ChangeVisibility());
  }

}
