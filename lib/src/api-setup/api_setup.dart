import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:sprout_mobile/src/api/api.dart';
import 'package:sprout_mobile/src/components/authentication/repository/auth_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/borow/repository/borrow_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/borow/service/borrow_service.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/repository/complete_account_setup_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/complete-account-setup/service/complete_account_setup_service.dart';
import 'package:sprout_mobile/src/components/fund-wallet/repository/fund_wallet_repositoryImpl.dart';
import 'package:sprout_mobile/src/components/fund-wallet/service/fund_wallet_service.dart';
import 'package:sprout_mobile/src/components/help/repository/help_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/help/service/help_service.dart';
import 'package:sprout_mobile/src/components/home/repository/home_repositoryImpl.dart';
import 'package:sprout_mobile/src/components/home/service/home_service.dart';
import 'package:sprout_mobile/src/components/invoice/repository/invoice_repositoryImpl.dart';
import 'package:sprout_mobile/src/components/invoice/service/invoice_service.dart';
import 'package:sprout_mobile/src/components/pay-bills/repository/pay_bills_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/pay-bills/service/pay_bills_service.dart';
import 'package:sprout_mobile/src/components/send-money/repository/send_money_repository.dart';
import 'package:sprout_mobile/src/components/send-money/service/send_money_service.dart';
import 'package:sprout_mobile/src/components/profile/repository/profile_repositoryimpl.dart';
import 'package:sprout_mobile/src/components/profile/service/profile_service.dart';
import 'package:sprout_mobile/src/public/repository/shared_repositoryimpl.dart';
import 'package:sprout_mobile/src/public/services/date_service.dart';
import 'package:sprout_mobile/src/public/services/pdf_service.dart';
import 'package:sprout_mobile/src/public/services/shared_service.dart';

import '../components/authentication/service/auth_service.dart';

GetIt locator = GetIt.instance;

Future<void> registerApiInstance() async {
  final Api api = Api(Dio());
  Get.put(api);
  api.setUpInterceptors();

  locator.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl());
  locator.registerLazySingleton<AuthService>(() => AuthService());

  locator.registerLazySingleton<HomeRepositoryImpl>(() => HomeRepositoryImpl());
  locator.registerLazySingleton<HomeService>(() => HomeService());

  locator.registerLazySingleton<CompleteAccountSetupRepositoryImpl>(
      () => CompleteAccountSetupRepositoryImpl());
  locator.registerLazySingleton<CompleteAccountSetupService>(
      () => CompleteAccountSetupService());

  locator.registerLazySingleton<SendMoneyRepositoryImpl>(
      () => SendMoneyRepositoryImpl());
  locator.registerLazySingleton<SendMoneyService>(() => SendMoneyService());
  locator.registerLazySingleton<HelpRepositoryImpl>(() => HelpRepositoryImpl());
  locator.registerLazySingleton<HelpService>(() => HelpService());

  locator.registerLazySingleton<SharedRepositoryImpl>(
      () => SharedRepositoryImpl());
  locator.registerLazySingleton<SharedService>(() => SharedService());

  locator.registerLazySingleton<ProfileRepositoryImpl>(
      () => ProfileRepositoryImpl());
  locator.registerLazySingleton<ProfileService>(() => ProfileService());

  locator.registerLazySingleton<InvoiceRepositoryImpl>(
      () => InvoiceRepositoryImpl());
  locator.registerLazySingleton<InvoiceService>(() => InvoiceService());

  locator.registerLazySingleton<BorrowRepositoryImpl>(
      () => BorrowRepositoryImpl());
  locator.registerLazySingleton<BorrowService>(() => BorrowService());

  locator.registerLazySingleton<DateService>(() => DateService());
  locator.registerLazySingleton<PdfService>(() => PdfService());

  locator.registerLazySingleton<PayBillsRepositoryImpl>(
      () => PayBillsRepositoryImpl());
  locator.registerLazySingleton<PayBillsService>(() => PayBillsService());

  locator.registerLazySingleton<FundWalletRepositoryImpl>(
      () => FundWalletRepositoryImpl());
  locator.registerLazySingleton<FundWalletService>(() => FundWalletService());
}
