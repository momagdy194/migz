import 'package:get_it/get_it.dart';
import 'package:google_place/google_place.dart';
import 'package:gshop/app_constants.dart';

// import 'package:google_place/google_place.dart';
import 'package:gshop/domain/interface/address.dart';
import 'package:gshop/domain/interface/auth.dart';
import 'package:gshop/domain/interface/banner.dart';
import 'package:gshop/domain/interface/blog.dart';
import 'package:gshop/domain/interface/brands.dart';
import 'package:gshop/domain/interface/cart.dart';
import 'package:gshop/domain/interface/category.dart';
import 'package:gshop/domain/interface/chat.dart';
import 'package:gshop/domain/interface/gallery.dart';
import 'package:gshop/domain/interface/order.dart';
import 'package:gshop/domain/interface/parcel.dart';
import 'package:gshop/domain/interface/payments.dart';
import 'package:gshop/domain/interface/products.dart';
import 'package:gshop/domain/interface/review.dart';
import 'package:gshop/domain/interface/settings.dart';
import 'package:gshop/domain/interface/shop.dart';
import 'package:gshop/domain/interface/user.dart';
import 'package:gshop/domain/service/http_service.dart';
import 'package:gshop/infrastructure/repository/address_repository.dart';
import 'package:gshop/infrastructure/repository/auth_repository.dart';
import 'package:gshop/infrastructure/repository/banners_repository.dart';
import 'package:gshop/infrastructure/repository/blogs_repository.dart';
import 'package:gshop/infrastructure/repository/brands_repository.dart';
import 'package:gshop/infrastructure/repository/cart_repository.dart';
import 'package:gshop/infrastructure/repository/categories_repository.dart';
import 'package:gshop/infrastructure/repository/chat_repository.dart';
import 'package:gshop/infrastructure/repository/gallery_repository.dart';
import 'package:gshop/infrastructure/repository/order_repository.dart';
import 'package:gshop/infrastructure/repository/parcel_repository.dart';
import 'package:gshop/infrastructure/repository/payments_repository.dart';
import 'package:gshop/infrastructure/repository/products_repository.dart';
import 'package:gshop/infrastructure/repository/review_repository.dart';
import 'package:gshop/infrastructure/repository/settings_repository.dart';
import 'package:gshop/infrastructure/repository/shops_repository.dart';
import 'package:gshop/infrastructure/repository/user_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setUpDependencies() async {
  getIt.registerLazySingleton<HttpService>(() => HttpService());
  getIt.registerSingleton<SettingsInterface>(SettingsRepository());
  getIt.registerSingleton<AuthInterface>(AuthRepository());
  getIt.registerSingleton<CategoryInterface>(CategoryRepository());
  getIt.registerSingleton<BannersInterface>(BannersRepository());
  getIt.registerSingleton<ProductsInterface>(ProductsRepository());
  getIt.registerSingleton<BlogInterface>(BlogsRepository());
  getIt.registerSingleton<ShopsInterface>(ShopsRepository());
  getIt.registerSingleton<BrandsInterface>(BrandsRepository());
  getIt.registerSingleton<GalleryInterface>(GalleryRepository());
  getIt.registerSingleton<UserInterface>(UserRepository());
  getIt.registerSingleton<ChatInterface>(ChatRepository());
  getIt.registerSingleton<AddressInterface>(AddressRepository());
  getIt.registerSingleton<CartInterface>(CartRepository());
  getIt.registerSingleton<ParcelInterface>(ParcelRepository());
  // getIt.registerSingleton<AddressRepositoryFacade>(AddressRepository());
  getIt.registerSingleton<GooglePlace>(GooglePlace(AppConstants.googleApiKey));
  getIt.registerSingleton<PaymentsInterface>(PaymentsRepository());
  getIt.registerSingleton<OrderInterface>(OrderRepository());
  getIt.registerSingleton<ReviewInterface>(ReviewRepository());
  // getIt.registerSingleton<DrawRepositoryFacade>(DrawRepository());
  // getIt.registerSingleton<NotificationRepositoryFacade>(NotificationRepositoryImpl());
}

final settingsRepository = getIt.get<SettingsInterface>();
final dioHttp = getIt.get<HttpService>();
final authRepository = getIt.get<AuthInterface>();
final categoriesRepository = getIt.get<CategoryInterface>();
final bannersRepository = getIt.get<BannersInterface>();
final productsRepository = getIt.get<ProductsInterface>();
final blogsRepository = getIt.get<BlogInterface>();
final shopsRepository = getIt.get<ShopsInterface>();
final brandsRepository = getIt.get<BrandsInterface>();
final galleryRepository = getIt.get<GalleryInterface>();
final userRepository = getIt.get<UserInterface>();
final chatRepository = getIt.get<ChatInterface>();
final addressRepository = getIt.get<AddressInterface>();
final cartRepository = getIt.get<CartInterface>();
// final addressesRepository = getIt.get<AddressRepositoryFacade>();
final googlePlace = getIt.get<GooglePlace>();
final paymentsRepository = getIt.get<PaymentsInterface>();
final ordersRepository = getIt.get<OrderInterface>();
final reviewRepository = getIt.get<ReviewInterface>();
final parcelRepository = getIt.get<ParcelInterface>();
