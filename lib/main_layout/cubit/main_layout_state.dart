
abstract class MainLayoutState {}

class MainLayoutInitial extends MainLayoutState {}
class SetAllCategories extends MainLayoutState{}
class SetScreenState extends MainLayoutState {}


class SelectImageStateSucess extends MainLayoutState {}
class SelectImageStateFaluire extends MainLayoutState {}


class GetAllUserLoading extends MainLayoutState {}
class GetAllUserSucess extends MainLayoutState {
  List list ;

  GetAllUserSucess(this.list);
}
class GetAllUserError extends MainLayoutState {
  String error ;

  GetAllUserError({required this.error});
}






