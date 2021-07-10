
import 'package:softag/screens/main_screen/models/change_favorite_model.dart';

class MainState {}

class MainInitState extends MainState {}

class MainLoadingState extends MainState {}

class MainSuccessState extends MainState {}

class MainErrorState extends MainState {}

class MainChangeState extends MainState {}

class MainLoadingCategoryState extends MainState {}

class MainSuccessCategoryState extends MainState {}

class MainErrorCategoryState extends MainState {}

class MainLoadingProductState extends MainState {}

class MainSuccessProductState extends MainState {}

class MainErrorProductState extends MainState {}

class MainLoadingUpdateState extends MainState {}

class MainSuccessUpdateState extends MainState {}

class MainErrorUpdateState extends MainState {}

class MainLoadingDataState extends MainState {}

class MainSuccessDataState extends MainState {}

class MainErrorDataState extends MainState {}

class MainChangeFavoriteState extends MainState {}

class MainSuccessChangeFavoriteState extends MainState {
  final ChangeFavoriteModel changeFavoriteModel;

  MainSuccessChangeFavoriteState(this.changeFavoriteModel);
}

class MainErrorChangeFavoriteState extends MainState {}

class MainLoadingGetFavoriteState extends MainState {}

class MainSuccessGetFavoriteState extends MainState {}

class MainErrorGetFavoriteState extends MainState {}