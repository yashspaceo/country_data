import 'package:country_data/ui/dashboard/binding/dashboard_binding.dart';
import 'package:country_data/ui/dashboard/view/dashboard_page.dart';
import 'package:country_data/ui/dashboard/view/image_page.dart';
import 'package:country_data/ui/splash/view/splash_page.dart';
import 'package:get/get.dart';

/// All routes for app pages are defined here
class AppRoutes {
  static const initialRoute = '/splash_page';
  static const dashboardPage = '/dashboard_page';
  static const imagePage = '/image_page';

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.initialRoute,
      page: () => SplashPage(),
    ),
    GetPage(
      name: AppRoutes.dashboardPage,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.imagePage,
      page: () => const ImagePage(),
      binding: DashboardBinding(),
    ),
  ];
}
