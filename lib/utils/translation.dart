import 'package:e_commerce/utils/ar.dart';
import 'package:e_commerce/utils/en.dart';
import 'package:get/get.dart';

class Translation extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en':en,
    'ar':ar,
  };

}