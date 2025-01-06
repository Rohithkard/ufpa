import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:upfa/collection_campaign/collection_campaigns_model.dart';
import 'package:upfa/executive_members/executive_members_model.dart';
import 'package:upfa/otp/otp_model.dart';

import '../blogs/blogs_model.dart';
import '../events/event_model.dart';
import '../login/login_model.dart';
import '../member_ship_renewal/member_ship_renewal_model.dart';
import '../product_details/product_details_model.dart';
import '../product_listing/product_listing_model.dart';
import '../profile/profile_model.dart';
import '../record_entry/record_entry_model.dart';
import '../report_generation/report_generation_model.dart';
import '../user_review_details/user_review_details_model.dart';
import '../user_review_listing/user_review_model.dart';
import 'urls.dart';

class ApiServices {
  static printResponse(
      {required String url,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameter,
      required http.Response response}) {
    if (kDebugMode) {
      print(Uri.https(AppUrls.base, url, queryParameter ?? {}));
      if (body != null) {
        print("${Uri.https(AppUrls.base, url)}====>$body");
      }
      print("${Uri.https(AppUrls.base, url)}====>${response.statusCode}");
      log("${Uri.https(AppUrls.base, url)}====>${response.body}");
    }
  }

  static Future<LoginResponseModel> login(
      {required Map<String, String> body}) async {
    var response = await http.post(
        Uri.https(
          AppUrls.base,
          AppUrls.login,
        ),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'sessionid=tq3d5subilerpvizjfr2bu9hnxcosube'
        },
        body: json.encode(body));
    print('sessionid=${body["phone_number1"]}');
    printResponse(url: AppUrls.login, response: response, queryParameter: body);
    if (response.statusCode == 200) {
      return loginResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<ReportGenrationResponseModel> sendReport(
      {required Map<String, dynamic> body}) async {
    var response = await http.post(
        headers: {'Content-Type': 'application/json'},
        Uri.https(
          AppUrls.base,
          AppUrls.report,
        ),
        body: json.encode(body));
    printResponse(url: AppUrls.report, response: response, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return reportGenrationResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<ReportGenrationResponseModel> upDateProfile(
      {required Map<String, dynamic> body}) async {
    var response = await http.patch(
        headers: {'Content-Type': 'application/json'},
        Uri.https(
          AppUrls.base,
          AppUrls.updateProfile,
        ),
        body: json.encode(body));
    printResponse(url: AppUrls.updateProfile, response: response, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return reportGenrationResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<OtpResponseModel> verifyOtp(
      {required Map<String, dynamic> body}) async {
    var response = await http.post(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'sessionid=tq3d5subilerpvizjfr2bu9hnxcosube'
        },
        Uri.https(
          AppUrls.base,
          AppUrls.otp,
        ),
        body: json.encode(body));

    printResponse(url: AppUrls.otp, response: response, body: body);
    return otpResponseModelFromJson(response.body);
  }

  static Future<GetRenewalDetailsResponseModel> getRenewalDetails(
      {required Map<String, dynamic> body}) async {
    var response = await http.post(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'sessionid=tq3d5subilerpvizjfr2bu9hnxcosube'
        },
        Uri.https(
          AppUrls.base,
          AppUrls.renewal,
        ),
        body: json.encode(body));

    printResponse(url: AppUrls.renewal, response: response, body: body);
    if (response.statusCode == 200) {
      return getRenewalDetailsResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<SendReviewResponseModel> sendReview(
      {required Map<String, dynamic> body}) async {
    var response = await http.post(
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'sessionid=tq3d5subilerpvizjfr2bu9hnxcosube'
        },
        Uri.https(
          AppUrls.base,
          AppUrls.review,
        ),
        body: json.encode(body));

    printResponse(url: AppUrls.review, response: response, body: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return sendReviewResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<GetEventsResponseModel>> events(
      {required Map<String, String> queryParameter}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.events, queryParameter),
    );
    printResponse(
        url: AppUrls.events,
        response: response,
        queryParameter: queryParameter);
    if (response.statusCode == 200) {
      return getEventsResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<GetProductsDetailsResponseModel> getProductDetails(
      {required int? id}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.ufpaco + (id ?? 0).toString()),
    );
    printResponse(
      url: AppUrls.events,
      response: response,
    );
    if (response.statusCode == 200) {
      return getProductsDetailsResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<GetEventUserCountResponseModel> eventUserCount(
      {required Map<String, dynamic> queryParameter}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.eventUserCount, queryParameter),
    );
    printResponse(
      url: AppUrls.eventUserCount,
      queryParameter: queryParameter,
      response: response,
    );
    if (response.statusCode == 200) {
      return getEventUserCountResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<GetExcutiveMembersResponseModel> executive(
      {required Map<String, String> body}) async {
    var response =
        await http.post(Uri.https(AppUrls.base, AppUrls.executive), body: body);
    printResponse(url: AppUrls.executive, response: response, body: body);
    if (response.statusCode == 200) {
      return getExcutiveMembersResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<GetBlogsResponseModel> getBlogs(
      {required Map<String, String> body}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.blogs, body),
    );
    printResponse(url: AppUrls.blogs, response: response, body: body);
    if (response.statusCode == 200) {
      return getBlogsResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<GetExcutiveMembersResponseModel> meghala(
      {required Map<String, String> body}) async {
    var response =
        await http.post(Uri.https(AppUrls.base, AppUrls.meghala), body: body);
    printResponse(url: AppUrls.meghala, response: response, body: body);
    if (response.statusCode == 200) {
      return getExcutiveMembersResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<GetExcutiveMembersResponseModel> addUserCount(
      {required Map<String, dynamic> body}) async {
    var response =
        await http.post(Uri.https(AppUrls.base, AppUrls.create), body: body);
    printResponse(url: AppUrls.create, response: response, body: body);
    if (response.statusCode == 200) {
      return getExcutiveMembersResponseModelFromJson(response.body);
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  static Future<GetExcutiveMembersResponseModel> executiveOfficial(
      {required Map<String, String> body}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.executiveOfficial),
    );
    printResponse(
      url: AppUrls.executiveOfficial,
      response: response,
    );
    if (response.statusCode == 200) {
      return getExcutiveMembersResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<MembershipResponseModel> members(
      {required Map<String, dynamic> body}) async {
    var response = await http.post(Uri.https(AppUrls.base, AppUrls.members),
        headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    printResponse(url: AppUrls.members, response: response, body: (body));
    if (response.statusCode == 200) {
      return membershipResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<UserDetailsResponseModel> memberDetails(
      {required String id}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.members + id),
    );
    printResponse(
      url: AppUrls.members + id,
      response: response,
    );
    if (response.statusCode == 200) {
      return userDetailsResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<GetProductsResponseModel> productListing(
      {required Map<String, String> body}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.ufpaco, body),
    );
    printResponse(
      url: AppUrls.ufpaco,
      response: response,
    );
    if (response.statusCode == 200) {
      return getProductsResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<UserDetailsResponseModel> getGuestUserDetails(
      {required String id}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.membersData + id),
    );
    printResponse(
      url: AppUrls.membersData + id,
      response: response,
    );
    if (response.statusCode == 200) {
      return userDetailsResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<GetCampaignResponseModel>> campaigns(
      {required Map<String, String> queryParameter}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.campaigns, queryParameter),
    );
    printResponse(
        url: AppUrls.campaigns,
        response: response,
        queryParameter: queryParameter);

    if (response.statusCode == 200) {
      return getCampaignResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  static Future<List<SearchUsersResponseModel>> search(
      {required Map<String, String> queryParameter}) async {
    var response = await http.get(
      Uri.https(AppUrls.base, AppUrls.search, queryParameter),
    );
    printResponse(
      url: AppUrls.search,
      queryParameter: queryParameter,
      response: response,
    );

    if (response.statusCode == 200) {
      return searchUsersResponseModelFromJson(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}
