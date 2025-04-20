import 'package:get/get.dart';
import '../bindings/product_binding.dart';

import '../views/screens/product_list_screen.dart';
import '../views/screens/product_details_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.productList,
      page: () => ProductListScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.productDetails,
      page: () => ProductDetailsScreen(),
    ),
  ];
}
