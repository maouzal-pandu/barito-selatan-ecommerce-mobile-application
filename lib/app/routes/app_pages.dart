import 'package:get/get.dart';

import '../modules/add-product/bindings/add_product_binding.dart';
import '../modules/add-product/views/add_product_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/edit-my-store/bindings/edit_my_store_binding.dart';
import '../modules/edit-my-store/views/edit_my_store_view.dart';
import '../modules/edit-profile/bindings/edit_profile_binding.dart';
import '../modules/edit-profile/views/edit_profile_view.dart';
import '../modules/forget-pass/bindings/forget_pass_binding.dart';
import '../modules/forget-pass/views/forget_pass_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my-store/bindings/my_store_binding.dart';
import '../modules/my-store/views/my_store_view.dart';
import '../modules/my_store_profile/bindings/my_store_profile_binding.dart';
import '../modules/my_store_profile/views/my_store_profile_view.dart';
import '../modules/product-details/bindings/product_details_binding.dart';
import '../modules/product-details/views/product_details_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/search_view/bindings/search_view_binding.dart';
import '../modules/search_view/views/search_view_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/store/bindings/store_binding.dart';
import '../modules/store/views/store_view.dart';
import '../modules/user-account/bindings/user_account_binding.dart';
import '../modules/user-account/views/user_account_view.dart';
import '../modules/verify-otp/bindings/verify_otp_binding.dart';
import '../modules/verify-otp/views/verify_otp_view.dart';
import '../modules/wishlist/bindings/wishlist_binding.dart';
import '../modules/wishlist/views/wishlist_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASS,
      page: () => const ForgetPassView(),
      binding: ForgetPassBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.USER_ACCOUNT,
      page: () => const UserAccountView(),
      binding: UserAccountBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.WISHLIST,
      page: () => const WishlistView(),
      binding: WishlistBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.MY_STORE,
      page: () => const MyStoreView(),
      binding: MyStoreBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_MY_STORE,
      page: () => const EditMyStoreView(),
      binding: EditMyStoreBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.MY_STORE_PROFILE,
      page: () => const MyStoreProfileView(),
      binding: MyStoreProfileBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => const ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.STORE,
      page: () => const StoreView(),
      binding: StoreBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_VIEW,
      page: () => const SearchViewView(),
      binding: SearchViewBinding(),
    ),
  ];
}
