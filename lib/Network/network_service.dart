import 'dart:convert';

import 'package:hp_finance/DataModel/Dashboard/agents_dashboard_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/group_loans_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/loans_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/pigmy_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/report_details_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/user_dashboard_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/verify_info_data_model.dart';
import 'package:hp_finance/DataModel/LearnAboutPigmySavings/learn_about_pigmy_savings_data_model.dart';
import 'package:hp_finance/DataModel/PaymentDetails/update_group_payment_details_data_model.dart';
import 'package:hp_finance/DataModel/PaymentDetails/update_payment_details_data_model.dart';
import 'package:hp_finance/DataModel/Profile/profile_data_model.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/group_mem_details_data_model.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/search_customer_details_data_model.dart';
import 'package:hp_finance/DataModel/SearchCustomersDetails/search_intermittent_data_model.dart';
import 'package:hp_finance/DataModel/TransactionHistory/pigmy_transaction_history_data_model.dart';
import 'package:hp_finance/DataModel/TransactionHistory/transaction_history_data_model.dart';
import 'package:hp_finance/DataModel/WithdrawPigmy/withdraw_pigmy_details_data_model.dart';
import 'package:hp_finance/Network/api_urls.dart';
import 'package:hp_finance/Network/network.dart';
import 'package:hp_finance/Utils/get_device_info.dart';
import 'package:http/http.dart';
// import 'package:http/retry.dart';

class NetworkService {
  /* Declarations */
  final Network _network = Network();

  /* Singleton Class */
  static final NetworkService _serviceInstance = NetworkService._internal();
  NetworkService._internal();
  factory NetworkService() => _serviceInstance;

  static int apiHitTimeout = 30;

  /* SIGN IN */
  var signInRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "access_token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NmI3MTYwOWQ5MjMwZTY4YTBkNmVhZjkiLCJ1c2VyTmFtZSI6ImFkbWluVXNlcm5hbWUiLCJ0eXBlIjoiYWRtaW4iLCJjcmVhdGVkQXQiOiIyMDI0LTA4LTEwVDA3OjI2OjAxLjYxNloiLCJ1cGRhdGVkQXQiOiIyMDI0LTA4LTEwVDA3OjI2OjAxLjYyM1oiLCJfX3YiOjAsInByaW1hcnlQaG9uZSI6IjY2YjcxNjA5ZDkyMzBlNjhhMGQ2ZWFmYiIsImlhdCI6MTcyNjc2MDU3OSwiZXhwIjoxNzI2ODY4NTc4fQ.x277Fxh8bcT8fOBj_oMboV9Pj-t06lnsBiZz9DLEJEI",
    "user_id": "1",
    "user_type": "admin"
  };
  Future<dynamic> signInService({
    required String? primaryPhone,
    required String? password,
  }) async {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['loginValue'] = '$primaryPhone';
        paramsKeyVal['password'] = '$password';
        return _network
            .httpPost(apiHitTimeout, APIURLs.loginURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* SIGN IN */

  /* SIGN UP */
  var signUpRes = {
    "status": true,
    "logout": false,
    "message": "Account Created Successfully"
  };
  Future<dynamic> signUpService({
    required String? name,
    required String? primaryPhone,
    required String? email,
    required String? password,
    required String? address,
    required String? city,
    required String? state,
    required String? zip,
    required String? country,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['name'] = '$name';
        paramsKeyVal['mobile_number'] = '$primaryPhone';
        paramsKeyVal['phoneNumber'] = '$primaryPhone';
        paramsKeyVal['email'] = '$email';
        paramsKeyVal['password'] = '$password';
        paramsKeyVal['address'] = '$address';
        paramsKeyVal['city'] = '$city';
        paramsKeyVal['state'] = '$state';
        paramsKeyVal['zip'] = '$zip';
        paramsKeyVal['country'] = '$country';
        return _network
            .httpPost(apiHitTimeout, APIURLs.createUserURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* SIGN UP */

  /* Dashboard */
  // var dashboardRes = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Loaded Successfully",
  //   "data": {
  //     "banner_details": [
  //       {
  //         "id": "1",
  //         "title": "Start Your Pigmy Savings Journey Today!",
  //         "img_url": "",
  //       },
  //       {
  //         "id": "2",
  //         "title": "Grow Your Savings, One Step at a Time",
  //         "img_url": "",
  //       },
  //       {
  //         "id": "3",
  //         "title": "Your Personalized Financial Solution",
  //         "img_url": "",
  //       },
  //       {
  //         "id": "4",
  //         "title": "Empowering Communities Together",
  //         "img_url": "",
  //       },
  //       {
  //         "id": "5",
  //         "title": "Grow Communities Together",
  //         "img_url": "",
  //       },
  //       {
  //         "id": "6",
  //         "title": "Save with the Communities Together",
  //         "img_url": "",
  //       },
  //     ],
  //     "show_kyc_det": true,
  //     "kyc_det": {
  //       "title": "Verify your KYC",
  //       "subtitle":
  //           "It's quick, easy, and keeps your identity protected. Complete your KYC today!",
  //       "btn_text": "Complete KYC Now",
  //       "type": "1", // 1 - Complete KYC Now CTA | 2 - Contact Support CTA
  //     },
  //     "services_text": "Services",
  //     "services_list": [
  //       {
  //         "id": "1",
  //         "title": "PIGMY",
  //         "image_url": "",
  //       },
  //       {
  //         "id": "2",
  //         "title": "LOANS",
  //         "image_url": "",
  //       },
  //       {
  //         "id": "3",
  //         "title": "GROUP LOANS",
  //         "image_url": "",
  //       }
  //     ],
  //     "dues_text": "Dues",
  //     "dues_sec_list": [
  //       {
  //         "id": "1",
  //         "title": "PIGMY",
  //         "subtitle": "Due as on\n13th October 2024",
  //         "amt": "\u20B911200",
  //         "pay_now_text": "PAY NOW",
  //       },
  //       {
  //         "id": "2",
  //         "title": "LOANS",
  //         "subtitle": "Due as on\n14th October 2024",
  //         "amt": "\u20B9200",
  //         "pay_now_text": "PAY NOW",
  //       },
  //       {
  //         "id": "3",
  //         "title": "GROUP LOANS",
  //         "subtitle": "Due as on\n24th October 2024",
  //         "amt": "\u20B91200",
  //         "pay_now_text": "PAY NOW",
  //       }
  //     ],
  //   }
  // };

  Future<UserDashboard> dashboard() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.dashboardURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return UserDashboard.fromJson(res);
          },
        );
      },
    );
  }
  /* Dashboard */

  /* PIGMY */
  var pigmyDetRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "no_pigmy_title": "Start Your Pigmy Savings Journey Today!",
      "no_pigmy_subtitle":
          "Grow your savings effortlessly with Pigmy Savings. Start with small amounts and watch your funds grow over time. Begin now and see the benefits of consistent saving!",
      "btn_text": "START NOW",
      "btn_type": "1",
      "show_pigmy_status_nudge": true,
      "pigmy_status_nudge_title": "Approval in Progress",
      "pigmy_status_nudge_subtitle":
          "Your Pigmy Savings application is under review. Please allow up to 72 hours for approval. We'll notify you once the process is complete. Thank you for your patience!",
      "pigmy_status_nudge_btn": "Contact Support",
      "footer_text": "Click Here to Learn How to Start Pigmy Savings",
      "pigmy_menus_list": [
        {
          "menu_id": "1",
          "menu_title": "PIGMY ID",
          "menu_img": "",
          "menu_subtile": "1234"
        },
        {
          "menu_id": "2",
          "menu_title": "Savings Balance",
          "menu_img": "",
          "menu_subtile": "₹1200"
        },
        {
          "menu_id": "3",
          "menu_title": "Maturity",
          "menu_img": "",
          "menu_subtile": "16/08/2025"
        },
        {
          "menu_id": "4",
          "menu_title": "Frequency",
          "menu_img": "",
          "menu_subtile": "30 Days"
        }
      ],
      "learn_pigmy_btn_text": "Learn About PIGMY Savings",
      "withdraw_pigmy_btn_text": "Withdraw PIGMY Savings",
      "pigmy_transaction_history_btn_text": "PIGMY Transaction History",
      "upcoming_text": "Upcoming",
      "upcoming_list": [
        {
          "id": "1",
          "title": "PIGMYCODE1234",
          "subtitle": "Due as on\n16th August 2024",
          "amt": "₹1200",
          "pay_now_text": "PAY NOW"
        }
      ]
    }
  };

  Future<PigmyDataModel> pigmyDetailsService() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.pigmyURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return PigmyDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* PIGMY */

  /* Group Pigmy */
  Future<PigmyDataModel> groupPigmyDetailsService() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.groupPigmyURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return PigmyDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Group Pigmy */

  /* LOANS */
  // var loanRes = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Loaded Successfully",
  //   "data": {
  //     "no_loan_title": "Unlock Financial Freedom with Our Loans!",
  //     "no_loan_subtitle":
  //         "Need a boost to achieve your dreams? Whether it's for personal needs or a business venture, our loans offer flexible terms and easy approval. Don't miss out on the financial support you deserve. Start your journey today and take the first step toward your goals!",
  //     "btn_text": "ENQUIRE NOW",
  //     "loans_menus_list": [
  //       {
  //         "menu_id": "1",
  //         "menu_title": "LOAN ID",
  //         "menu_img": "",
  //         "menu_subtile": "1234"
  //       }
  //     ],
  //     "repay_all_text": "Repay All",
  //     "transaction_history_text": "Check Transaction History",
  //     "upcoming_text": "Upcoming",
  //     "upcoming_list": [
  //       {
  //         "id": "1",
  //         "title": "PIGMYCODE1234",
  //         "subtitle": "Due as on\n16th August 2024",
  //         "amt": "\u20B91200",
  //         "pay_now_tex": "PAY NOW"
  //       }
  //     ],
  //     "pay_all_nudge": {
  //       "pay_all_text": "Pay All",
  //       "load_code_text": "LOANCODE1234",
  //       "primary_btn_text": "Complete Payment",
  //       "sec_btn_text": "Cancel",
  //       "installment_det_list": [
  //         {"title": "Total Repayment Installment", "subtitle": "6"},
  //         {"title": "Installments Over", "subtitle": "Aug 2024 - Jan 2025"},
  //         {"title": "Amount Payable", "subtitle": "\u20B91200"}
  //       ]
  //     }
  //   }
  // };

  Future<LoansDataModel> loanDetailsService() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.loanURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return LoansDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* LOANS */

  /* Group Loans */
  // var gLoansRes = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Loaded Successfully",
  //   "data": {
  //     "no_gloan_title": "Join a Group Loan Today!",
  //     "no_gloan_subtitle":
  //         "Ready to achieve more together? Our Group Loans offer collective support and flexible terms to help you and your group reach your goals. Whether it's for community projects or joint ventures, now is the perfect time to benefit from shared financial power. Start your Group Loan journey today and see what you can achieve together!",
  //     "btn_text": "ENQUIRE NOW",
  //     "loans_menus_list": [
  //       {
  //         "menu_id": "1",
  //         "menu_title": "LOAN ID",
  //         "menu_img": "",
  //         "menu_subtile": "1234"
  //       }
  //     ],
  //     "repay_all_text": "Repay All",
  //     "transaction_history_text": "Check Transaction History",
  //     "group_mem_det": "Group Members Details",
  //     "upcoming_text": "Upcoming",
  //     "upcoming_list": [
  //       {
  //         "id": "1",
  //         "title": "LOANCODE1234",
  //         "subtitle": "Due as on\n16th August 2024",
  //         "amt": "₹1200",
  //         "pay_now_text": "PAY NOW"
  //       }
  //     ],
  //     "pay_all_nudge": {
  //       "pay_all_text": "Pay All",
  //       "load_code_text": "LOANCODE1234",
  //       "primary_btn_text": "Complete Payment",
  //       "sec_btn_text": "Cancel",
  //       "installment_det_list": [
  //         {"title": "Total Repayment Installment", "subtitle": "6"},
  //         {"title": "Installments Over", "subtitle": "Aug 2024 - Jan 2025"},
  //         {"title": "Amount Payable", "subtitle": "₹1200"}
  //       ]
  //     }
  //   }
  // };

  Future<GroupLoansDataModel> groupLoanDetailsService() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.groupLoanURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return GroupLoansDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Group Loans */

  /* Learn About Pigmy Savings */
  var learnPigmyRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "btn_text": "START NOW",
      "footer_text": "Save Smarter, Not Harder",
      "title": "Pigmy Savings",
      "subtitle":
          "The Pigmy Savings Scheme offers a simple and effective way to build your savings with regular, small deposits. Choose your preferred deposit frequency and watch your savings grow over time. It's designed for convenience, flexibility, and financial growth, making it the perfect choice for achieving your savings goals. Start today and enjoy the benefits of disciplined saving!",
      "how_it_works_text": "How it Works?",
      "how_it_works_list": [
        {
          "title": "Open Your Account",
          "subtitle":
              "Sign up by providing your personal details and choosing your deposit frequency."
        }
      ],
      "deposit_schemes_text": "Deposit Schemes",
      "schemes_list": [
        {
          "title": "One Year Daily Deposit Scheme (DDS)",
          "schemes_det": [
            "Plan Period 12 months",
            "The minimum investment plan of Rs 20 and in multiple of Rs 10."
          ]
        },
        {
          "title": "15 Months Daily Deposit Scheme (DDS)",
          "schemes_det": [
            "Plan Period 15 months",
            "The minimum investment plan of Rs 20 and in multiple of Rs 10."
          ]
        }
      ],
      "terms_condn_text": "Terms & Conditions",
      "terms_list": [
        {
          "title": "Eligibility",
          "schemes_det": [
            "Available to individuals over 18 years of age.",
            "Must provide valid identification and contact information."
          ]
        }
      ]
    }
  };
  Future<LearnAboutPigmySavings> learnAboutPigmySavingsService({
    required String?
        type, // 1 - Learn About PIGMY SAVINGS | 2 - Learn About GROUP PIGMY SAVINGS
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['type'] =
            type; // 1 - Learn About PIGMY SAVINGS | 2 - Learn About GROUP PIGMY SAVINGS
        return _network
            .httpGet(apiHitTimeout, APIURLs.learnAboutPigmyURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return LearnAboutPigmySavings.fromJson(res);
          },
        );
      },
    );
  }
  /* Learn About Pigmy Savings */

  /* Reset Password */
  // var resul = {
  //   "status": false,
  //   "logout": false,
  //   "message": "Password reset Successful"
  // };
  Future<dynamic> resetPasswordService({required String password}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) async {
        // String? userID = await SharedPreferencesUtil.getSharedPref(
        //     SharedPreferenceConstants.prefUserID);
        paramsKeyVal['password'] = password;
        // paramsKeyVal['userId'] = userID;
        return _network
            .httpPut(apiHitTimeout, APIURLs.resetPasswordURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Reset Password */

  /* Profile */
  var profileResults = {
    "status": true,
    "logout": false,
    "data": {
      "type": "2",
      "customer_id": "1234",
      "profile_img": "",
      "name": "Tejaswini D",
      "mob_num": "7259889622",
      "alt_mob_num": "6366317316",
      "email_address": "tejaswinidev24@gmail.com",
      "annual_income": "10000",
      "street_address": "Bhuvaneshwari Nagar",
      "city": "Bangalore",
      "state": "Karnataka",
      "country": "India",
      "pincode": "560057"
    }
  };
  Future<ProfileDataModel> profileDetails(
      {required String? type, required String? customerID}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['type'] = type; // type 1 - My Profile | 2 - Others Profile
        paramsKeyVal['id'] = customerID;
        return _network
            .httpGetQuery(apiHitTimeout, APIURLs.profileDetailsURL,
                queryParams: paramsKeyVal)
            .then(
          (dynamic res) {
            return ProfileDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Profile */

  /* Update Profile Details */
  var resultUpdateProfile = {
    "status": true,
    "logout": false,
    "message": "Profile details updated successfully"
  };
  Future<dynamic> updateProfileDetails({
    required String? profileImage,
    required String? userName,
    required String? mobNum,
    required String? altMobNum,
    required String? emailAddress,
    required String? streetAddress,
    required String? city,
    required String? state,
    required String? zipCode,
    required String? country,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['profileImage'] = profileImage;
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['altMobNum'] = altMobNum;
        paramsKeyVal['emailAddress'] = emailAddress;
        paramsKeyVal['streetAddress'] = streetAddress;
        paramsKeyVal['city'] = city;
        paramsKeyVal['state'] = state;
        paramsKeyVal['zipCode'] = zipCode;
        paramsKeyVal['country'] = country;
        return _network
            .httpPut(apiHitTimeout, APIURLs.updateProfileDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update Profile Details */

  /* Update KYC Details */
  var resultUpdateKYC = {
    "status": true,
    "logout": false,
    "message": "KYC details updated successfully"
  };
  Future<dynamic> updateKYCDetails({
    required String? aadhaarImage,
    required String? userName,
    required String? mobNum,
    required String? altMobNum,
    required String? emailAddress,
    required String? streetAddress,
    required String? city,
    required String? state,
    required String? zipCode,
    required String? country,
    required String? panImage,
    required String? agentName,
    required String? panNumber,
    required String? aadhaarNumber,
    required String? rcImage,
    required String? rcHolderName,
    required String? houseImage,
    required String? propertyHolderName,
    required String? propertyDetails,
    required String? chequeNumber,
    required String? bankName,
    required String? accNumber,
    required String? bankIFSCCode,
    required String? bankBranchName,
    required String? passbookImage,
    required String? signatureImage,
    required String?
        type, // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
    String? customerID,
    bool? isVerified,
    String? reference,
    String? referenceNum,
    String? reason,
    String? buildingImagePath1,
    String? buildingImagePath2,
    String? buildingImagePath3,
    String? buildingImagePath4,
    String? buildingImagePath5,
    String? buildingImagePath6,
    String? buildingImagePath7,
    String? buildingStreetImagePath,
    String? buildingAreaImagePath,
    required String? permanentAddress,
    required String? photoImagePath,
    required String? locLink,
    required String? workLocationLink,
    String? guarantorName,
    String? guarantorMobNum,
    String? guarantorAltMobNum,
    String? guarantorEmailAddress,
    String? guarantorAddress,
    String? guarantorAadhaar,
    String? guarantorPan,
    String? guarantorChequeNum,
    required String? docType,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['type'] =
            type; // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
        paramsKeyVal['customerID'] = customerID;
        paramsKeyVal['isVerified'] = isVerified;
        paramsKeyVal['reference'] = reference;
        paramsKeyVal['referenceNum'] = referenceNum;
        paramsKeyVal['reason'] = reason;
        paramsKeyVal['aadhaarImage'] = aadhaarImage;
        paramsKeyVal['aadhaarNumber'] = aadhaarNumber;
        paramsKeyVal['panNumber'] = panNumber;
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['altMobNum'] = altMobNum;
        paramsKeyVal['emailAddress'] = emailAddress;
        paramsKeyVal['streetAddress'] = streetAddress;
        paramsKeyVal['city'] = city;
        paramsKeyVal['state'] = state;
        paramsKeyVal['zipCode'] = zipCode;
        paramsKeyVal['country'] = country;
        paramsKeyVal['panImage'] = panImage;
        paramsKeyVal['rcImage'] = rcImage;
        paramsKeyVal['rcHolderName'] = rcHolderName;
        paramsKeyVal['houseImage'] = houseImage;
        paramsKeyVal['propertyHolderName'] = propertyHolderName;
        paramsKeyVal['propertyDetails'] = propertyDetails;
        paramsKeyVal['chequeNumber'] = chequeNumber;
        paramsKeyVal['bankName'] = bankName;
        paramsKeyVal['accNumber'] = accNumber;
        paramsKeyVal['bankIFSCCode'] = bankIFSCCode;
        paramsKeyVal['bankBranchName'] = bankBranchName;
        paramsKeyVal['passbookImage'] = passbookImage;
        paramsKeyVal['signatureImage'] = signatureImage;
        paramsKeyVal['buildingImagePath1'] = buildingImagePath1;
        paramsKeyVal['buildingImagePath2'] = buildingImagePath2;
        paramsKeyVal['buildingImagePath3'] = buildingImagePath3;
        paramsKeyVal['buildingImagePath4'] = buildingImagePath4;
        paramsKeyVal['buildingImagePath5'] = buildingImagePath5;
        paramsKeyVal['buildingImagePath6'] = buildingImagePath6;
        paramsKeyVal['buildingImagePath7'] = buildingImagePath7;
        paramsKeyVal['buildingStreetImagePath'] = buildingStreetImagePath;
        paramsKeyVal['buildingAreaImagePath'] = buildingAreaImagePath;
        paramsKeyVal['permanent_address'] = permanentAddress;
        paramsKeyVal['agentName'] = agentName;
        paramsKeyVal['photoImagePath'] = photoImagePath;
        paramsKeyVal['locLink'] = locLink;
        paramsKeyVal['workLocLink'] = workLocationLink;
        paramsKeyVal['guarantorName'] = guarantorName;
        paramsKeyVal['guarantorMobNum'] = guarantorMobNum;
        paramsKeyVal['guarantorAltMobNum'] = guarantorAltMobNum;
        paramsKeyVal['guarantorEmailAddress'] = guarantorEmailAddress;
        paramsKeyVal['guarantorAddress'] = guarantorAddress;
        paramsKeyVal['guarantorAadhaar'] = guarantorAadhaar;
        paramsKeyVal['guarantorPan'] = guarantorPan;
        paramsKeyVal['guarantorChequeNum'] = guarantorChequeNum;
        paramsKeyVal['docType'] = docType;
        return _network
            .httpPut(apiHitTimeout, APIURLs.updateKYCDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update KYC Details */

  /* Update Enquiry Details */
  var resultUpdateEnquiry = {
    "status": true,
    "logout": false,
    "message": "Enquiry details updated successfully"
  };
  Future<dynamic> updateEnquiryDetails({
    required String? userName,
    required String? mobNum,
    required String? altMobNum,
    required String? emailAddress,
    required String? streetAddress,
    required String? city,
    required String? state,
    required String? zipCode,
    required String? country,
    required String? loanAmount,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['altMobNum'] = altMobNum;
        paramsKeyVal['emailAddress'] = emailAddress;
        paramsKeyVal['streetAddress'] = streetAddress;
        paramsKeyVal['city'] = city;
        paramsKeyVal['state'] = state;
        paramsKeyVal['zipCode'] = zipCode;
        paramsKeyVal['country'] = country;
        paramsKeyVal['loanAmount'] = loanAmount;
        return _network
            .httpPost(apiHitTimeout, APIURLs.updateEnquiryDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update Enquiry Details */

  /* Create PIGMY */
  var resultCreatePIGMYDetails = {
    "status": true,
    "logout": false,
    "message": "PIGMY Account created successfully"
  };
  Future<dynamic> createPIGMYDetails({
    required String? userName,
    required String? mobNum,
    required String? altMobNum,
    required String? emailAddress,
    required String? streetAddress,
    required String? city,
    required String? state,
    required String? zipCode,
    required String? country,
    required String? depositAmount,
    required String? frequency,
    required String? nomineeName,
    required String? nomineeRelation,
    required String? nomineePhoneNumber,
    required String? nomineeAadhaarNumber,
    required String? nomineePanNumber,
    required String? nomineeBankName,
    required String? nomineeAccountNumber,
    required String? nomineeAccountName,
    required String? nomineeIFSC,
    required String? nomineeBranch,
    required String? permanentAddress,
    bool? isGroupPigmy,
    String? reference,
    String? referenceNum,
    required String? startDate,
    required String? endDate,
    required String? pigmyPlan,
    required String? bankName,
    required String? accNumber,
    required String? bankIFSCCode,
    required String? bankBranchName,
    required String? photoImagePath,
    required String? signatureImage,
    required String? locLink,
    required String? workLocLink,
    required String? aadhaarNum,
    required String? panNum,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['altMobNum'] = altMobNum;
        paramsKeyVal['emailAddress'] = emailAddress;
        paramsKeyVal['streetAddress'] = streetAddress;
        paramsKeyVal['city'] = city;
        paramsKeyVal['state'] = state;
        paramsKeyVal['zipCode'] = zipCode;
        paramsKeyVal['country'] = country;
        paramsKeyVal['depositAmount'] = depositAmount;
        paramsKeyVal['frequency'] = frequency;
        paramsKeyVal['nomineeName'] = nomineeName;
        paramsKeyVal['nomineeRelation'] = nomineeRelation;
        paramsKeyVal['nomineePhoneNumber'] = nomineePhoneNumber;
        paramsKeyVal['nomineeAadhaarNumber'] = nomineeAadhaarNumber;
        paramsKeyVal['nomineePanNumber'] = nomineePanNumber;
        paramsKeyVal['nomineeBankName'] = nomineeBankName;
        paramsKeyVal['nomineeAccountNumber'] = nomineeAccountNumber;
        paramsKeyVal['nomineeAccountName'] = nomineeAccountName;
        paramsKeyVal['nomineeIFSC'] = nomineeIFSC;
        paramsKeyVal['nomineeBranch'] = nomineeBranch;
        paramsKeyVal['permanentAddress'] = permanentAddress;
        paramsKeyVal['isGroupPigmy'] = isGroupPigmy;
        paramsKeyVal['reference'] = reference;
        paramsKeyVal['referenceNum'] = referenceNum;
        paramsKeyVal['startDate'] = startDate;
        paramsKeyVal['endDate'] = endDate;
        paramsKeyVal['pigmyPlan'] = pigmyPlan;
        paramsKeyVal['bankName'] = bankName;
        paramsKeyVal['accNumber'] = accNumber;
        paramsKeyVal['bankIFSCCode'] = bankIFSCCode;
        paramsKeyVal['bankBranchName'] = bankBranchName;
        paramsKeyVal['photoImagePath'] = photoImagePath;
        paramsKeyVal['signatureImage'] = signatureImage;
        paramsKeyVal['locLink'] = locLink;
        paramsKeyVal['workLocLink'] = workLocLink;
        paramsKeyVal['aadhaarNum'] = aadhaarNum;
        paramsKeyVal['panNum'] = panNum;
        return _network
            .httpPost(apiHitTimeout, APIURLs.createPIGMYURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Create PIGMY */

  /* Create PIGMY - by Agent */
  Future<dynamic> createPIGMYDetailsbyAgent({
    required String? userName,
    required String? mobNum,
    required String? altMobNum,
    required String? emailAddress,
    required String? streetAddress,
    required String? city,
    required String? state,
    required String? zipCode,
    required String? country,
    required String? depositAmount,
    required String? frequency,
    required String? nomineeName,
    required String? nomineeRelation,
    required String? nomineePhoneNumber,
    required String? nomineeAadhaarNumber,
    required String? nomineePanNumber,
    required String? nomineeBankName,
    required String? nomineeAccountNumber,
    required String? nomineeAccountName,
    required String? nomineeIFSC,
    required String? nomineeBranch,
    required String? permanentAddress,
    bool? isGroupPigmy,
    String? reference,
    String? referenceNum,
    required String? startDate,
    required String? endDate,
    required String? pigmyPlan,
    required String? agentName,
    required String? agentPhNum,
    String? password,
    required String? bankName,
    required String? accNumber,
    required String? bankIFSCCode,
    required String? bankBranchName,
    required String? photoImagePath,
    required String? signatureImage,
    required String? locLink,
    required String? workLocLink,
    required String? aadhaarNum,
    required String? panNum,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['altMobNum'] = altMobNum;
        paramsKeyVal['emailAddress'] = emailAddress;
        paramsKeyVal['streetAddress'] = streetAddress;
        paramsKeyVal['city'] = city;
        paramsKeyVal['state'] = state;
        paramsKeyVal['zipCode'] = zipCode;
        paramsKeyVal['country'] = country;
        paramsKeyVal['depositAmount'] = depositAmount;
        paramsKeyVal['frequency'] = frequency;
        paramsKeyVal['nomineeName'] = nomineeName;
        paramsKeyVal['nomineeRelation'] = nomineeRelation;
        paramsKeyVal['nomineePhoneNumber'] = nomineePhoneNumber;
        paramsKeyVal['nomineeAadhaarNumber'] = nomineeAadhaarNumber;
        paramsKeyVal['nomineePanNumber'] = nomineePanNumber;
        paramsKeyVal['nomineeBankName'] = nomineeBankName;
        paramsKeyVal['nomineeAccountNumber'] = nomineeAccountNumber;
        paramsKeyVal['nomineeAccountName'] = nomineeAccountName;
        paramsKeyVal['nomineeIFSC'] = nomineeIFSC;
        paramsKeyVal['nomineeBranch'] = nomineeBranch;
        paramsKeyVal['permanentAddress'] = permanentAddress;
        paramsKeyVal['isGroupPigmy'] = isGroupPigmy;
        paramsKeyVal['reference'] = reference;
        paramsKeyVal['referenceNum'] = referenceNum;
        paramsKeyVal['startDate'] = startDate;
        paramsKeyVal['endDate'] = endDate;
        paramsKeyVal['pigmyPlan'] = pigmyPlan;
        paramsKeyVal['agentName'] = agentName;
        paramsKeyVal['agentPhNum'] = agentPhNum;
        paramsKeyVal['password'] = password;
        paramsKeyVal['bankName'] = bankName;
        paramsKeyVal['accNumber'] = accNumber;
        paramsKeyVal['bankIFSCCode'] = bankIFSCCode;
        paramsKeyVal['bankBranchName'] = bankBranchName;
        paramsKeyVal['photoImagePath'] = photoImagePath;
        paramsKeyVal['signatureImage'] = signatureImage;
        paramsKeyVal['locLink'] = locLink;
        paramsKeyVal['workLocLink'] = workLocLink;
        paramsKeyVal['aadhaarNum'] = aadhaarNum;
        paramsKeyVal['panNum'] = panNum;
        return _network
            .httpPost(apiHitTimeout, APIURLs.createPIGMYbyAgentURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Create PIGMY - by Agent */

  /* Withdraw PIGMY */
  var resultWithdrawPIGMYDetailsUpdate = {
    "status": true,
    "logout": false,
    "message": "PIGMY Withdraw request updated successfully"
  };
  Future<dynamic> withdrawPIGMYDetailsUpdate({
    required String? userName,
    required String? mobNum,
    required String? altMobNum,
    required String? emailAddress,
    // required String? streetAddress,
    // required String? city,
    // required String? state,
    // required String? zipCode,
    // required String? country,
    required String? withdrawalAmount,
    required String? reason,
    // required String? agentName,
    // required String? agentPhNum,
    required String? type,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['altMobNum'] = altMobNum;
        paramsKeyVal['emailAddress'] = emailAddress;
        // paramsKeyVal['streetAddress'] = streetAddress;
        // paramsKeyVal['city'] = city;
        // paramsKeyVal['state'] = state;
        // paramsKeyVal['zipCode'] = zipCode;
        // paramsKeyVal['country'] = country;
        paramsKeyVal['withdrawalAmount'] = withdrawalAmount;
        paramsKeyVal['reason'] = reason;
        // paramsKeyVal['agentName'] = agentName;
        // paramsKeyVal['agentPhNum'] = agentPhNum;
        return _network
            .httpPost(
                apiHitTimeout,
                (type == "2")
                    ? APIURLs.withdrawPIGMYbyAgentURL
                    : APIURLs.withdrawPIGMYURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Withdraw PIGMY */

/* Close Loan */

  Future<dynamic> closeLoanUpdate({
    required String? id,
    required String? loanID,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = id;
        paramsKeyVal['loanID'] = loanID;
        return _network
            .httpPut(apiHitTimeout, APIURLs.closeLoanURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }

  /* Close Loan */

  /* Withdraw PIGMY Details */
  var pigmyFetchDet = {
    "status": true,
    "logout": false,
    "data": {
      "name": "Tejaswini D",
      "mob_num": "7259889622",
      "alt_mob_num": "6366317316",
      "email_address": "tejaswinidev24@gmail.com",
      // "annual_income": "10000",
      // "street_address": "Bhuvaneshwari Nagar",
      // "city": "Bangalore",
      // "state": "Karnataka",
      // "country": "India",
      // "pincode": "560057",
      "balance": "Savings: \u20B91200",
      "balance_amt": "1200"
    }
  };
  Future<WithdrawPigmyDataModel> withdrawPIGMYFetchDetails() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.withdrawPIGMYFetchDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return WithdrawPigmyDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Withdraw PIGMY Details */

  /* Withdraw Pigmy Details by Agent */
  Future<WithdrawPigmyDataModel> withdrawPIGMYFetchDetailsbyAgent(
      {required String? customerID}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = customerID;
        return _network
            .httpGetQuery(
                apiHitTimeout, APIURLs.withdrawPIGMYFetchDetailsByAgentURL,
                queryParams: paramsKeyVal)
            .then(
          (dynamic res) {
            return WithdrawPigmyDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Withdraw Pigmy Details by Agent */

  /* Post Image */
  Future<String?> imageUpload(String profilePath) async {
    try {
      var request = MultipartRequest('POST', Uri.parse(APIURLs.imageUploadURL));
      request.files.add(await MultipartFile.fromPath('image', profilePath));

      // Assuming GetDeviceInfo().getDeviceInfo() returns a Map<String, dynamic>
      Map<String, dynamic> paramsKeyVal = await GetDeviceInfo().getDeviceInfo();
      paramsKeyVal.forEach((k, v) {
        request.fields[k] = v.toString();
      });

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);

        // Assuming the URL is returned in a field named 'imageUrl'
        String? imageUrl = jsonResponse['url'];

        return imageUrl;
      } else {
        print("Failed to upload image. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    return null;
  }
  /* Post Image */

  /* PIGMY Transaction History */
  // var pigmyTansRes = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Loaded Successfully",
  //   "data": {
  //     "pigmy_hist_list": [
  //       {
  //         "id": "1",
  //         "header_text": "PAID TO",
  //         "mem_name": "HP FINANCE",
  //         "payment_date": "16th August 2024 6:45 PM",
  //         "footer_text": "PIGMYCODE1234",
  //         "amt_text": "₹1200",
  //         "pay_status": "PAID",
  //         "pay_status_type": "1",
  //         "acc_status": "ACTIVE",
  //         "acc_status_type": "1"
  //       }
  //     ]
  //   }
  // };
  Future<PigmyTransactionHistoryDataModel>
      pigmyTransactionHistoryDetailsService({
    int? page,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
        return _network
            .httpGetQuery(
          apiHitTimeout,
          APIURLs.pigmyTransactionDetURL,
          queryParams: paramsKeyVal,
        )
            .then(
          (dynamic res) {
            return PigmyTransactionHistoryDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* PIGMY Transaction History */

  /* Transaction History */
  var transRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "transaction_hist_list": [
        {
          "id": "1",
          "header_text": "PAID TO",
          "mem_name": "HP FINANCE",
          "payment_date": "16th August 2024 6:45 PM",
          "footer_text": "PIGMYCODE1234",
          "amt_text": "₹1200",
          "pay_status": "PAID",
          "pay_status_type": "1",
          "transaction_details": {
            "header_text": "PAID TO",
            "title": "HP FINANCE",
            "subtitle": "16th August 2024 6:45 PM",
            "amt_text": "1200",
            "pay_status": "PAID",
            "pay_status_type": "1",
            "transaction_acc_details": {
              "title": "",
              "subtitle": "",
              "type": "1"
            }
          }
        }
      ]
    }
  };
  Future<TransactionHistoryDataModel> transactionHistoryDetailsService({
    int? page,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
        return _network
            .httpGetQuery(
          apiHitTimeout,
          APIURLs.transactionDetURL,
          queryParams: paramsKeyVal,
        )
            .then(
          (dynamic res) {
            return TransactionHistoryDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Transaction History */

  /* Agents Dashboard */
  // var agentsRes = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Loaded Successfully",
  //   "data": {
  //     "agent_menus_list": [
  //       {
  //         "menu_id": "1",
  //         "menu_title": "PIGMY ID",
  //         "menu_img": "",
  //         "menu_subtile": "1234"
  //       },
  //       {
  //         "menu_id": "2",
  //         "menu_title": "Savings Balance",
  //         "menu_img": "",
  //         "menu_subtile": "₹1200"
  //       }
  //     ],
  //     "find_btn_text": "Find Customer Details",
  //     "verify_btn_text": "Verify Customer Details",
  //     "update_payment_det_text": "UpdatePaymentdetails"
  //   }
  // };
  Future<AgentsDashboardDataModel> agentsDashboardService({
    String? startDate,
    String? endDate,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['startDate'] = startDate;
        paramsKeyVal['endDate'] = endDate;
        return _network
            .httpGet(apiHitTimeout, APIURLs.agentsDashboardURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return AgentsDashboardDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Agents Dashboard */

  /* Group Member Details */
  var grpRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "group_members_list": [
        {
          "group_id": "1",
          "header_text": "Group Leader",
          "profile_img": "",
          "mem_name": "RAM",
          "joined_date": "Joined on 16th August 2024",
          "footer_text": "LOANID1234",
          "amt_text": "₹1200",
          "pay_status": "PAID",
          "pay_status_type": "1",
          "acc_status": "ACTIVE",
          "acc_status_type": "1"
        },
        {
          "group_id": "2",
          "header_text": "Group Member",
          "profile_img": "",
          "mem_name": "RAM",
          "joined_date": "Joined on 16th August 2024",
          "footer_text": "LOANID1234",
          "amt_text": "₹1200",
          "pay_status": "PAID",
          "pay_status_type": "1",
          "acc_status": "CLOSED",
          "acc_status_type": "2"
        }
      ]
    }
  };
  Future<GroupMembersDetailsDataModel> groupMemDetailsService(
      {int? page, required String? type}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
        paramsKeyVal['type'] = type; // type: 1 - G PIGMY | 2 - G Loans
        return _network
            .httpGet(apiHitTimeout, APIURLs.groupMemberDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return GroupMembersDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Group Member Details */

  /* Logout */
  Future<dynamic> logoutService() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.logoutURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Logout */

  /* Update Payment Details Prefetch */
  // var payRes = {
  //   "status": true,
  //   "logout": false,
  //   "data": {
  //     "id": "2",
  //     "name": "Tejaswini D",
  //     "mob_num": "7259889622",
  //     "code_id": "1234",
  //     "agent": "RAM",
  //     "amt_to_be_paid": "1200",
  //     "date": "16/10/2024",
  //     "due": "100",
  //     "customers_list": [
  //       {
  //         "cus_id": "1",
  //         "cus_name": "Ram",
  //         "cus_amt": "123.7",
  //         "is_editable": true,
  //         "is_selected": false
  //       },
  //       {
  //         "cus_id": "2",
  //         "cus_name": "Seetha",
  //         "cus_amt": "143.7",
  //         "is_editable": false,
  //         "is_selected": false
  //       },
  //       {
  //         "cus_id": "2",
  //         "cus_name": "Seetha",
  //         "cus_amt": "143.7",
  //         "is_editable": false,
  //         "is_selected": false
  //       }
  //     ]
  //   }
  // };
  Future<UpdatePaymentDetailsDataModel> updatePaymentPrefetchDetailsService({
    required String? id,
    required String? type,
    String? amtType,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = "$id";
        paramsKeyVal['type'] = "$type";
        paramsKeyVal['amtType'] = amtType;
        return _network
            .httpGetQuery(
                apiHitTimeout, APIURLs.updatePaymentPrefetchDetailsURL,
                queryParams: paramsKeyVal)
            .then(
          (dynamic res) {
            return UpdatePaymentDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Update Payment Details Prefetch */

  /* Update Group Payment Details */
  // var payRes = {
  //   "status": true,
  //   "logout": false,
  //   "data": {
  //     "id": "2",
  //     "name": "Tejaswini D",
  //     "mob_num": "7259889622",
  //     "code_id": "1234",
  //     "agent": "RAM",
  //     "amt_to_be_paid": "1200",
  //     "date": "16/10/2024",
  //     "due": "100",
  //     "customers_list": [
  //       {
  //         "cus_id": "1",
  //         "cus_name": "Ram",
  //         "cus_amt": "123.7",
  //         "is_editable": true,
  //         "is_selected": true
  //       },
  //       {
  //         "cus_id": "2",
  //         "cus_name": "Seetha",
  //         "cus_amt": "143.7",
  //         "is_editable": false,
  //         "is_selected": true
  //       },
  //       {
  //         "cus_id": "2",
  //         "cus_name": "Seetha",
  //         "cus_amt": "143.7",
  //         "is_editable": false,
  //         "is_selected": true
  //       }
  //     ]
  //   }
  // };

  Future<UpdateGroupPaymentDetailsDataModel>
      updateGroupPaymentPrefetchDetailsService({
    required String? id,
    required String? type,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = "$id";
        paramsKeyVal['type'] = "$type";

        return _network
            .httpGetQuery(
                apiHitTimeout, APIURLs.updateGroupPaymentPrefetchDetailsURL,
                queryParams: paramsKeyVal)
            .then(
          (dynamic res) {
            return UpdateGroupPaymentDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Update Group Payment Details */

  /* Update Edit Amount */
  Future<dynamic> updateGroupEditAmountPayService({
    required String? id,
    required String? type,
    required String? cusID,
    required String? cusAmount,
    required String? amtType,
    required String? groupID,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = "$id";
        paramsKeyVal['type'] = "$type";
        paramsKeyVal['customer_id'] = "$cusID";
        paramsKeyVal['customer_amt'] = "$cusAmount";
        paramsKeyVal['amtType'] = "$amtType";
        paramsKeyVal['groupID'] = groupID;
        return _network
            .httpPost(apiHitTimeout, APIURLs.updateGroupEditPayURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update Edit Amount */

  /* Update Save Action Group Payment Details */
  // var resultUpdatePayment = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Profile details updated successfully"
  // };

  /* Update Save Action Group Payment Details */
  Future<dynamic> updateSaveGrpPaymentDetails({
    required String? userName,
    required String? mobNum,
    required String? code,
    required String? agent,
    required String? amtPaid,
    // required String? amtDue,
    required String? date,
    required String? paymentCollectionDate,
    required String? paymentMode,
    // required String? paymentStatus,
    required String? amountType,
    required String? id,
    required String? type,
    required List? cusDetails,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = "$id";
        paramsKeyVal['type'] = "$type";
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['codeID'] = code;
        paramsKeyVal['agent'] = agent;
        paramsKeyVal['amountPaid'] = amtPaid;
        // paramsKeyVal['due'] = amtDue;
        paramsKeyVal['date'] = date;
        paramsKeyVal['paymentCollectionDate'] = paymentCollectionDate;
        paramsKeyVal['paymentMode'] = paymentMode;
        // paramsKeyVal['paymentStatus'] = paymentStatus;
        paramsKeyVal['amountType'] = amountType;
        paramsKeyVal['cusDetails'] = json.encode(cusDetails);
        return _network
            .httpPut(apiHitTimeout, APIURLs.saveDetailGrpPayURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }

  /* Update Save Action Group Payment Details */

  /* Update Payment Details */
  // var resultUpdatePayment = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Profile details updated successfully"
  // };

  Future<dynamic> updatePaymentDetails({
    required String? userName,
    required String? mobNum,
    required String? code,
    required String? agent,
    required String? amtPaid,
    // required String? amtDue,
    required String? date,
    required String? paymentCollectionDate,
    required String? paymentMode,
    // required String? paymentStatus,
    required String? amountType,
    required String? id,
    required String? type,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = "$id";
        paramsKeyVal['type'] = "$type";
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['codeID'] = code;
        paramsKeyVal['agent'] = agent;
        paramsKeyVal['amountPaid'] = amtPaid;
        // paramsKeyVal['due'] = amtDue;
        paramsKeyVal['date'] = date;
        paramsKeyVal['paymentCollectionDate'] = paymentCollectionDate;
        paramsKeyVal['paymentMode'] = paymentMode;
        // paramsKeyVal['paymentStatus'] = paymentStatus;
        paramsKeyVal['amountType'] = amountType;
        return _network
            .httpPut(apiHitTimeout, APIURLs.updatePaymentDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update Payment Details */

  /* Update Group Payment Details */
  Future<dynamic> updateGrpPaymentDetails(
      {required String? userName,
      required String? mobNum,
      required String? code,
      required String? agent,
      required String? amtPaid,
      // required String? amtDue,
      required String? date,
      required String? paymentCollectionDate,
      required String? paymentMode,
      required String? id,
      required String? type,
      required List<CustomersList>? cusDetails,
      required String? groupID}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = "$id";
        paramsKeyVal['type'] = "$type";
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['codeID'] = code;
        paramsKeyVal['agent'] = agent;
        paramsKeyVal['amountPaid'] = amtPaid;
        // paramsKeyVal['due'] = amtDue;
        paramsKeyVal['date'] = date;
        paramsKeyVal['paymentCollectionDate'] = paymentCollectionDate;
        paramsKeyVal['paymentMode'] = paymentMode;
        paramsKeyVal['cusDetails'] = jsonEncode(cusDetails);
        paramsKeyVal['groupID'] = groupID;
        return _network
            .httpPut(apiHitTimeout, APIURLs.updateGroupPaymentDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update Group Payment Details */

  /* Search Intermittent Screen */
  // var searchRes = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Loaded Successfully",
  //   "data": {
  //     "profile_image": "",
  //     "name": "RAM",
  //     "ph_num": "+91 877665654554 | +91 8767545678",
  //     "email_id": "abc@gmail.com",
  //     "address":
  //         "Bhuvaneshwari Nagar, T Dasarahalli, Bangalore, Karnataka, 560057",
  //     "documents_text": "Documents",
  //     "docs_list": [
  //       {"id": "1", "title": "PAN", "image_path": ""},
  //       {"id": "2", "title": "AADHAAR", "image_path": ""}
  //     ],
  //     "list_details": [
  //       {
  //         "list_det_title": "PIGMY",
  //         "list_det": [
  //           {
  //             "id": "1",
  //             "title": "PIGMYCODE1234",
  //             "subtitle": "Due as on\n16th August 2024",
  //             "amt": "₹1200",
  //             "pay_now_text": "PAY NOW"
  //           },
  //           {
  //             "id": "1",
  //             "title": "PIGMYCODE1234",
  //             "subtitle": "Paid as on\n16th August 2024",
  //             "amt": "₹1200",
  //             "pay_now_text": ""
  //           },
  //           {
  //             "id": "1",
  //             "title": "PIGMYCODE1234",
  //             "subtitle": "Paid as on\n16th August 2024",
  //             "amt": "₹1200",
  //             "pay_now_text": ""
  //           },
  //           {
  //             "id": "1",
  //             "title": "PIGMYCODE1234",
  //             "subtitle": "Paid as on\n16th August 2024",
  //             "amt": "₹1200",
  //             "pay_now_text": ""
  //           }
  //         ]
  //       },
  //       {
  //         "list_det_title": "LOAN",
  //         "list_det_menu": [
  //           {
  //             "menu_id": "1",
  //             "menu_title": "PIGMY ID",
  //             "menu_img": "",
  //             "menu_subtile": "1234"
  //           },
  //           {
  //             "menu_id": "2",
  //             "menu_title": "Savings Balance",
  //             "menu_img": "",
  //             "menu_subtile": "\u20B91200"
  //           }
  //         ],
  //         "list_det": [
  //           {
  //             "id": "1",
  //             "title": "PIGMYCODE1234",
  //             "subtitle": "Due as on\n16th August 2024",
  //             "amt": "₹1200",
  //             "pay_now_text": "PAY NOW"
  //           },
  //           {
  //             "id": "1",
  //             "title": "PIGMYCODE1234",
  //             "subtitle": "Due as on\n16th August 2024",
  //             "amt": "₹1200",
  //             "pay_now_text": ""
  //           }
  //         ]
  //       }
  //     ]
  //   }
  // };

  Future<SearchIntermittentDetailsDataModel> searchIntermittentService(
      {String? cusID, required String? type}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = cusID;
        paramsKeyVal['type'] = type; // 1 - Customers Serach | 2 - Group Search
        return _network
            .httpGetQuery(apiHitTimeout, APIURLs.searchIntermittentDetailsURL,
                queryParams: paramsKeyVal)
            .then(
          (dynamic res) {
            return SearchIntermittentDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Search Intermittent SCreen */

  /* Search Customer Details */

  // var searchCusrEs = {
  //   "status": true,
  //   "logout": false,
  //   "message": "Loaded Successfully",
  //   "data": {
  //     "search_members_list": [
  //       {
  //         "member_id": "1",
  //         "profile_img": "",
  //         "mem_name": "RAM",
  //         "loan_code": "LOANID1234",
  //         "location": "Bangalore, Karnataka",
  //         "ph_num": "+91 7259889622",
  //         "acc_status": "ACTIVE",
  //         "acc_status_type": "1" //1-ACTIVE|2-CLOSED
  //       }
  //     ]
  //   }
  // };

  Future<SearchCustomerDetailsDataModel> searchCusDetailsService({
    int? page,
    String? searchKey,
    required String?
        type, // 1 - Customers Search | 2 - Group Search | 3 - PIGMY Collections Search | 4 - G-PIGMY Collections Search | 5 - Loans Collections Search | 6 - G-Loan Collections Search
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
        paramsKeyVal['search_key'] = searchKey;
        paramsKeyVal['type'] = type; // 1 - Customers Serach | 2 - Group Search
        return _network
            .httpGetQuery(
          apiHitTimeout,
          APIURLs.searchCustomerDetailsURL,
          queryParams: paramsKeyVal,
        )
            .then(
          (dynamic res) {
            return SearchCustomerDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Search Customer Details */

  /* Update Group Creation Details */
  Future<dynamic> updateGroupCreationDetails({
    required String? groupName,
    required String? groupLeaderName,
    required String? mobNum,
    required String? loanAmt,
    required String? loanTenure,
    required String? frequency,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['groupName'] = groupName;
        paramsKeyVal['groupLeaderName'] = groupLeaderName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['loanAmt'] = loanAmt;
        paramsKeyVal['loanTenure'] = loanTenure;
        paramsKeyVal['frequency'] = frequency;

        return _network
            .httpPost(apiHitTimeout, APIURLs.updateGroupCreationURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update Group Creation Details */

  /* Report History */
  var reportDetRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "title": "Today's PIGMY Collections",
      "report_list": [
        {
          "id": "1",
          "type": "PIGMY",
          "header_text": "PIGMYCODE1234",
          "mem_name": "MAHALAKSHMI",
          "ph_num": "+91 7345678900",
          "payment_date": "16th August 2024 6:45 PM",
          "footer_text": "Bangalore, Karnataka",
          "amt_text": "₹1200",
          "pay_status": "PAID",
          "pay_status_type": "1"
        },
        {
          "id": "2",
          "type": "PIGMY",
          "header_text": "PIGMYCODE1234",
          "mem_name": "SITA",
          "ph_num": "+91 7678990866",
          "payment_date": "16th August 2024 6:45 PM",
          "footer_text": "Bangalore, Karnataka",
          "amt_text": "₹1200",
          "pay_status": "DUE",
          "pay_status_type": "2"
        }
      ]
    }
  };
  Future<ReportDetailsDataModel> reportHistoryDetailsService({
    required int? page,
    required String? type, // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['type'] =
            type; // 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
        paramsKeyVal['page'] = "$page";
        return _network
            .httpGetQuery(
          apiHitTimeout,
          APIURLs.reportDetURL,
          queryParams: paramsKeyVal,
        )
            .then(
          (dynamic res) {
            return ReportDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Report History */

  /* Verify Customer Info */
  var verifyRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "title": "Verify Information",
      "info_list": [
        {
          "id": "1",
          "type": "VERIFY",
          "mem_name": "MAHALAKSHMI",
          "ph_num": "+91 7567899876",
          "footer_text": "Bangalore, Karnataka",
          "status": "PENDING",
          "status_type": "1" // 1-VERIFIED | 2-PENDING
        }
      ]
    }
  };
  Future<VerifyInformationDetailsDataModel> verifyCustomerDetailsListService({
    required int? page,
    required String? searchKey,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
        paramsKeyVal['search_key'] = "$searchKey";
        return _network
            .httpGetQuery(
          apiHitTimeout,
          APIURLs.verifyCustomerInfoURL,
          queryParams: paramsKeyVal,
        )
            .then(
          (dynamic res) {
            return VerifyInformationDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Verify Customer Info */

  /* Verify Customer Profile */
  var verifyprofileResults = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "id": "123456",
      "name": "Tejaswini D",
      "mob_num": "7259889622",
      "alt_mob_num": "6366317316",
      "email_address": "tejaswinidev24@gmail.com",
      "address": "Bhuvaneshwari Nagar",
      "city": "Bangalore",
      "state": "Karnataka",
      "country": "India",
      "pincode": "560057",
      "aadhaar_num": "9813 3308 4678",
      "pan_num": "GHJKI567E",
      "rc_holder_name": "",
      "property_holder_name": "",
      "property_details": "",
      "cheque_num": "XXXXXXXX",
      "bank_name": "SBI",
      "acc_num": "467890987654",
      "ifsc_code": "SBIN0000813",
      "bank_branch": "Dasarahalli",
      "profile_img": "",
      "aadhaar_img": "",
      "pan_img": "",
      "cheque_img": "",
      "rc_img": "",
      "property_img": "",
      "pass_book_img": "",
      "signature_img": ""
    }
  };
  Future<dynamic> verifyCustomerProfilePrefetchDetails({
    required String? id,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = id;
        return _network
            .httpGetQuery(apiHitTimeout, APIURLs.verifyCustomerDetPrefetchURL,
                queryParams: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Verify Customer Profile */

  /* Register Group/Individual Customer */
  Future<dynamic> updateGroupIndividualCustomerDetails({
    required String? aadhaarImage,
    required String? userName,
    required String? mobNum,
    required String? altMobNum,
    required String? emailAddress,
    required String? streetAddress,
    required String? city,
    required String? state,
    required String? zipCode,
    required String? country,
    required String? panImage,
    String? referenceNumber,
    required String? panNumber,
    required String? aadhaarNumber,
    required String? rcImage,
    required String? rcHolderName,
    required String? houseImage,
    required String? propertyHolderName,
    required String? propertyDetails,
    required String? chequeNumber,
    required String? bankName,
    required String? accNumber,
    required String? bankIFSCCode,
    required String? bankBranchName,
    required String? passbookImage,
    required String? signatureImage,
    required String?
        type, // type: 1 - Add Group Customer | 2 - Register Individual Customer
    String? reference,
    String? buildingImagePath1,
    String? buildingImagePath2,
    String? buildingImagePath3,
    String? buildingImagePath4,
    String? buildingImagePath5,
    String? buildingImagePath6,
    String? buildingImagePath7,
    String? buildingStreetImagePath,
    String? buildingAreaImagePath,
    required String? permanentAddress,
    required String? agentName,
    required String? photoImagePath,
    required String? locLink,
    required String? workLocationLink,
    required String? guarantorName,
    required String? guarantorMobNum,
    required String? guarantorAltMobNum,
    required String? guarantorEmailAddress,
    required String? guarantorAddress,
    required String? guarantorAadhaar,
    required String? guarantorPan,
    required String? guarantorChequeNum,
    required String? docType,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['aadhaarImage'] = aadhaarImage;
        paramsKeyVal['aadhaarNumber'] = aadhaarNumber;
        paramsKeyVal['panNumber'] = panNumber;
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['altMobNum'] = altMobNum;
        paramsKeyVal['emailAddress'] = emailAddress;
        paramsKeyVal['streetAddress'] = streetAddress;
        paramsKeyVal['city'] = city;
        paramsKeyVal['state'] = state;
        paramsKeyVal['zipCode'] = zipCode;
        paramsKeyVal['country'] = country;
        paramsKeyVal['panImage'] = panImage;
        paramsKeyVal['reference'] = reference;
        paramsKeyVal['referenceNumber'] = referenceNumber;
        paramsKeyVal['is_group_customer'] = (type == "1") ? true : false;
        paramsKeyVal['rcImage'] = rcImage;
        paramsKeyVal['rcHolderName'] = rcHolderName;
        paramsKeyVal['houseImage'] = houseImage;
        paramsKeyVal['propertyHolderName'] = propertyHolderName;
        paramsKeyVal['propertyDetails'] = propertyDetails;
        paramsKeyVal['chequeNumber'] = chequeNumber;
        paramsKeyVal['bankName'] = bankName;
        paramsKeyVal['accNumber'] = accNumber;
        paramsKeyVal['bankIFSCCode'] = bankIFSCCode;
        paramsKeyVal['bankBranchName'] = bankBranchName;
        paramsKeyVal['passbookImage'] = passbookImage;
        paramsKeyVal['signatureImage'] = signatureImage;
        paramsKeyVal['buildingImagePath1'] = buildingImagePath1;
        paramsKeyVal['buildingImagePath2'] = buildingImagePath2;
        paramsKeyVal['buildingImagePath3'] = buildingImagePath3;
        paramsKeyVal['buildingImagePath4'] = buildingImagePath4;
        paramsKeyVal['buildingImagePath5'] = buildingImagePath5;
        paramsKeyVal['buildingImagePath6'] = buildingImagePath6;
        paramsKeyVal['buildingImagePath7'] = buildingImagePath7;
        paramsKeyVal['buildingStreetImagePath'] = buildingStreetImagePath;
        paramsKeyVal['buildingAreaImagePath'] = buildingAreaImagePath;
        paramsKeyVal['permanent_address'] = permanentAddress;
        paramsKeyVal['agentName'] = agentName;
        paramsKeyVal['photoImagePath'] = photoImagePath;
        paramsKeyVal['locLink'] = locLink;
        paramsKeyVal['workLocLink'] = workLocationLink;
        paramsKeyVal['guarantorName'] = guarantorName;
        paramsKeyVal['guarantorMobNum'] = guarantorMobNum;
        paramsKeyVal['guarantorAltMobNum'] = guarantorAltMobNum;
        paramsKeyVal['guarantorEmailAddress'] = guarantorEmailAddress;
        paramsKeyVal['guarantorAddress'] = guarantorAddress;
        paramsKeyVal['guarantorAadhaar'] = guarantorAadhaar;
        paramsKeyVal['guarantorPan'] = guarantorPan;
        paramsKeyVal['guarantorChequeNum'] = guarantorChequeNum;
        paramsKeyVal['docType'] = docType;
        return _network
            .httpPost(
          apiHitTimeout,
          APIURLs.updateIndividualGroupDetailsURL,
          body: paramsKeyVal,
        )
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Register Group/Individual Customer */

  /* Update Address & Mobile Number */
  Future<dynamic> updateAddressPhNumDetails({
    required String? customerID,
    required String? mobNum,
    required String? streetAddress,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['customer_id'] = customerID;
        paramsKeyVal['address'] = streetAddress;
        return _network
            .httpPut(apiHitTimeout, APIURLs.updateAddressMobNumURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return res;
          },
        );
      },
    );
  }
  /* Update Address & Mobile Number */

  /* Search Collection Details */
  Future<ReportDetailsDataModel> searchCollectionDetailsService({
    int? page,
    String? searchKey,
    required String?
        type, // type: 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
        paramsKeyVal['search_key'] = searchKey;
        paramsKeyVal['type'] =
            type; // type: 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
        return _network
            .httpGetQuery(
          apiHitTimeout,
          APIURLs.searchCollectionURL,
          queryParams: paramsKeyVal,
        )
            .then(
          (dynamic res) {
            return ReportDetailsDataModel.fromJson(res);
          },
        );
      },
    );
  }
  /* Search Collection Details */
}
