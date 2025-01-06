import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:upfa/collection_campaign/collection_campaigns_controller.dart';
import 'package:upfa/events/event_controller.dart';
import 'package:upfa/events/event_view.dart';
import 'package:upfa/executive_members/executive_members_controller.dart';
import 'package:upfa/home/home_controller.dart';
import 'package:upfa/home/home_view.dart';
import 'package:upfa/landing_page/landing_page_controller.dart';
import 'package:upfa/landing_page/landing_page_view.dart';
import 'package:upfa/login/login_controller.dart';
import 'package:upfa/login/login_view.dart';
import 'package:upfa/member_ship_renewal/member_ship_renewal_controller.dart';
import 'package:upfa/member_ship_renewal_details/member_ship_renewal_details_controller.dart';
import 'package:upfa/member_ship_renewal_details/member_ship_renewal_details_view.dart';
import 'package:upfa/otp/otp_controller.dart';
import 'package:upfa/otp/otp_view.dart';
import 'package:upfa/product_details/product_details_controller.dart';
import 'package:upfa/product_details/product_details_view.dart';
import 'package:upfa/product_listing/product_listing_controller.dart';
import 'package:upfa/product_listing/product_listing_view.dart';
import 'package:upfa/profile/profile_controller.dart';
import 'package:upfa/profile/profile_view.dart';
import 'package:upfa/profile_edit/profile_edit_controller.dart';
import 'package:upfa/profile_edit/profile_edit_view.dart';
import 'package:upfa/record_entry/record_entry_controller.dart';
import 'package:upfa/report_generation/report_generation_controller.dart';
import 'package:upfa/route/routes.dart';
import 'package:upfa/splash/splash_controller.dart';
import 'package:upfa/user_review_details/user_review_details_controller.dart';
import 'package:upfa/user_review_details/user_review_details_view.dart';
import 'package:upfa/user_review_listing/user_review_listing_controller.dart';
import 'package:upfa/user_review_listing/user_review_listing_view.dart';

import '../collection_campaign/collection_campaign_view.dart';
import '../executive_members/executive_members_view.dart';
import '../member_ship_renewal/member_ship_renewal_view.dart';
import '../qr_code/qr_code_controller.dart';
import '../qr_code/qr_code_view.dart';
import '../record_entry/record_entry_view.dart';
import '../report_generation/report_generation_view.dart';
import '../splash/splash_view.dart';

class AppPages {
  static List<GetPage> appPages = <GetPage>[
    GetPage(
        name: AppRoutes.splash,
        page: () => const SplashView(),
        binding: SplashControllerBinding()),
    GetPage(
        name: AppRoutes.editProfile,
        page: () => const ProfileEditView(),
        binding: ProfileEditControllerBinding()),
    GetPage(
        name: AppRoutes.login,
        page: () => const LoginView(),
        binding: LoginControllerBinding()),
    GetPage(
        name: AppRoutes.products,
        page: () => const ProductListingView(),
        binding: ProductListingControllerBinding()),
    GetPage(
        name: AppRoutes.productDetails,
        page: () => const ProductDetailsView(),
        binding: ProductDetailsControllerBinding()),
    GetPage(
        name: AppRoutes.otp,
        page: () => const OtpView(),
        binding: OtpControllerBinding()),
    GetPage(
        name: AppRoutes.events,
        page: () => const EventView(),
        binding: EventControllerBinding()),
    GetPage(
        name: AppRoutes.reportGeneration,
        page: () => const ReportGenerationView(),
        binding: ReportGenerationControllerBinding()),
    GetPage(
        name: AppRoutes.memberShipRenewal,
        page: () => const MemberShipRenewalView(),
        binding: MemberShipRenewalControllerBinding()),
    GetPage(
        name: AppRoutes.memberShipRenewalDetails,
        page: () => const MemberShipRenewalDetailsView(),
        binding: MemberShipRenewalDetailsControllerBinding()),
    GetPage(
        name: AppRoutes.qrCodeScanner,
        page: () => const QrCodeScannerView(),
        binding: QrCodeScannerControllerBinding()),
    GetPage(
        name: AppRoutes.recordEntry,
        page: () => const RecordEntryView(),
        binding: RecordEntryControllerBinding()),
    GetPage(
        name: AppRoutes.userReviewListing,
        page: () => const UserReviewListingView(),
        binding: UserReviewListingControllerBinding()),
    GetPage(
        name: AppRoutes.executiveMembers,
        page: () => const ExecutiveMembersView(),
        binding: ExecutiveMembersControllerBinding()),
    GetPage(
        name: AppRoutes.userReviewDetails,
        page: () => const UserReviewDetailsView(),
        binding: UserReviewDetailsControllerBinding()),
    GetPage(
        name: AppRoutes.collectionCampaign,
        page: () => const CollectionCampaignView(),
        binding: CollectionCampaignsControllerBinding()),
    GetPage(
        name: AppRoutes.landingPage,
        page: () => const LandingPageView(),
        binding: LandingPageControllerBinding()),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeView(),
        binding: HomeControllerBinding()),
    GetPage(
        name: AppRoutes.profile,
        page: () => const ProfileView(),
        binding: ProfileControllerBinding()),
  ];
}
