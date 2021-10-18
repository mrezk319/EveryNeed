import 'package:e_commerce/modules/favourite/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavCubit extends Cubit<FavStates> {
  FavCubit() : super(initialFavState());

  static FavCubit get(context) => BlocProvider.of(context);


}