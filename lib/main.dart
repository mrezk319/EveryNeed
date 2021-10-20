import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/modules/login/log_in_screen.dart';
import 'package:e_commerce/shared/bloc_observer.dart';
import 'package:e_commerce/shared/network/local.dart';
import 'package:e_commerce/utils/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'home/home_layout.dart';
import 'modules/productDetails/noSql/nosql.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  await Hive.initFlutter();
  Hive.registerAdapter(ProdcutModelAdapter());
  await Hive.openBox<ProdcutModel>('fov');

  var firstScreen = CacheHelper.getData(key: "isLogged");
  runApp(MyApp(firstScreen));
}

class MyApp extends StatelessWidget {
  var whoIsFirst;

  MyApp(this.whoIsFirst);

  var controller = FlameSplashController(
      fadeInDuration: Duration(seconds: 1),
      fadeOutDuration: Duration(milliseconds: 250),
      waitDuration: Duration(seconds: 1),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeLayoutCubit())
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: FlameSplashScreen(
          showAfter: (BuildContext context) {
            return Image.asset("assets/images/splash.png",fit: BoxFit.cover,width: double.infinity,height: double.infinity,);
          },
          theme: FlameSplashTheme.white,
          onFinish: (context) => whoIsFirst == true
              ? Get.offAll(HomeLayout())
              : Get.offAll(LogIn()),
          controller: controller,
        ),
        locale: CacheHelper.getData(key: "isArabic") == true
            ? Locale('ar')
            : Locale('en'),
        translations: Translation(),
      ),
    );
  }
}
