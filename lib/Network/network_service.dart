import 'dart:convert';

import 'package:hp_finance/DataModel/Dashboard/agents_dashboard_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/group_loans_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/loans_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/pigmy_data_model.dart';
import 'package:hp_finance/DataModel/Dashboard/user_dashboard_data_model.dart';
import 'package:hp_finance/DataModel/LearnAboutPigmySavings/learn_about_pigmy_savings_data_model.dart';
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
  Future<LearnAboutPigmySavings> learnAboutPigmySavingsService() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
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
      "type": "1",
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
  Future<ProfileDataModel> profileDetails() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.profileDetailsURL,
                body: paramsKeyVal)
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
    required String? chequeImage,
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
        paramsKeyVal['chequeImage'] = chequeImage;
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
        return _network
            .httpPost(apiHitTimeout, APIURLs.createPIGMYURL, body: paramsKeyVal)
            .then(
          (dynamic res) {
            return resultCreatePIGMYDetails;
          },
        );
      },
    );
  }
  /* Create PIGMY */

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
        return _network
            .httpPost(apiHitTimeout, APIURLs.withdrawPIGMYURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return resultWithdrawPIGMYDetailsUpdate;
          },
        );
      },
    );
  }
  /* Withdraw PIGMY */

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
  var agentsRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "agent_menus_list": [
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
        }
      ],
      "find_btn_text": "Find Customer Details",
      "verify_btn_text": "Verify Customer Details",
      "update_payment_det_text": "UpdatePaymentdetails"
    }
  };
  Future<AgentsDashboardDataModel> agentsDashboardService() {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        return _network
            .httpGet(apiHitTimeout, APIURLs.verifyCustomerDashboardURL,
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
  Future<GroupMembersDetailsDataModel> groupMemDetailsService({int? page}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
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
  var payRes = {
    "status": true,
    "logout": false,
    "data": {
      "id": "2",
      "name": "Tejaswini D",
      "mob_num": "7259889622",
      "code_id": "1234",
      "agent": "RAM",
      "amt_to_be_paid": "1200",
      "date": "16/10/2024",
      "due": "100"
    }
  };
  Future<UpdatePaymentDetailsDataModel> updatePaymentPrefetchDetailsService(
      {required String? id}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = "$id";
        // return _network
        //     .httpGet(apiHitTimeout, APIURLs.updatePaymentPrefetchDetailsURL,
        //         body: paramsKeyVal)
        //     .then(
        //   (dynamic res) {
        return UpdatePaymentDetailsDataModel.fromJson(payRes);
        //   },
        // );
      },
    );
  }
  /* Update Payment Details Prefetch */

  /* Update Payment Details */
  var resultUpdatePayment = {
    "status": true,
    "logout": false,
    "message": "Profile details updated successfully"
  };
  Future<dynamic> updatePaymentDetails({
    required String? userName,
    required String? mobNum,
    required String? code,
    required String? agent,
    required String? amtPaid,
    required String? amtDue,
    required String? date,
    required String? paymentType,
    required String? paymentMode,
    required String? paymentStatus,
  }) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['userName'] = userName;
        paramsKeyVal['mobNum'] = mobNum;
        paramsKeyVal['codeID'] = code;
        paramsKeyVal['agent'] = agent;
        paramsKeyVal['amountPaid'] = amtPaid;
        paramsKeyVal['due'] = amtDue;
        paramsKeyVal['date'] = date;
        paramsKeyVal['paymentType'] = paymentType;
        paramsKeyVal['paymentMode'] = paymentMode;
        paramsKeyVal['paymentStatus'] = paymentStatus;
        return _network
            .httpPut(apiHitTimeout, APIURLs.updatePaymentDetailsURL,
                body: paramsKeyVal)
            .then(
          (dynamic res) {
            return resultUpdatePayment;
          },
        );
      },
    );
  }
  /* Update Payment Details */

  /* Search Intermittent Screen */
  var searchRes = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "profile_image": "",
      "name": "RAM",
      "ph_num": "+91 877665654554 | +91 8767545678",
      "email_id": "abc@gmail.com",
      "address":
          "Bhuvaneshwari Nagar, T Dasarahalli, Bangalore, Karnataka, 560057",
      "documents_text": "Documents",
      "docs_list": [
        {"id": "1", "title": "PAN", "image_path": ""},
        {"id": "2", "title": "AADHAAR", "image_path": ""}
      ],
      "list_details": [
        {
          "list_det_title": "PIGMY",
          "list_det": [
            {
              "id": "1",
              "title": "PIGMYCODE1234",
              "subtitle": "Due as on\n16th August 2024",
              "amt": "₹1200",
              "pay_now_text": "PAY NOW"
            },
            {
              "id": "1",
              "title": "PIGMYCODE1234",
              "subtitle": "Paid as on\n16th August 2024",
              "amt": "₹1200",
              "pay_now_text": ""
            },
            {
              "id": "1",
              "title": "PIGMYCODE1234",
              "subtitle": "Paid as on\n16th August 2024",
              "amt": "₹1200",
              "pay_now_text": ""
            },
            {
              "id": "1",
              "title": "PIGMYCODE1234",
              "subtitle": "Paid as on\n16th August 2024",
              "amt": "₹1200",
              "pay_now_text": ""
            }
          ]
        },
        {
          "list_det_title": "LOAN",
          "list_det_menu": [
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
              "menu_subtile": "\u20B91200"
            }
          ],
          "list_det": [
            {
              "id": "1",
              "title": "PIGMYCODE1234",
              "subtitle": "Due as on\n16th August 2024",
              "amt": "₹1200",
              "pay_now_text": "PAY NOW"
            },
            {
              "id": "1",
              "title": "PIGMYCODE1234",
              "subtitle": "Due as on\n16th August 2024",
              "amt": "₹1200",
              "pay_now_text": ""
            }
          ]
        }
      ]
    }
  };
  Future<SearchIntermittentDetailsDataModel> searchIntermittentService(
      {String? cusID}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['id'] = cusID;
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

  var searchCusrEs = {
    "status": true,
    "logout": false,
    "message": "Loaded Successfully",
    "data": {
      "search_members_list": [
        {
          "member_id": "1",
          "profile_img": "",
          "mem_name": "RAM",
          "loan_code": "LOANID1234",
          "location": "Bangalore, Karnataka",
          "ph_num": "+91 7259889622",
          "acc_status": "ACTIVE",
          "acc_status_type": "1" //1-ACTIVE|2-CLOSED
        }
      ]
    }
  };
  Future<SearchCustomerDetailsDataModel> searchCusDetailsService(
      {int? page, String? searchKey}) {
    return GetDeviceInfo().getDeviceInfo().then(
      (paramsKeyVal) {
        paramsKeyVal['page'] = "$page";
        paramsKeyVal['search_key'] = searchKey;
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
            .httpPut(apiHitTimeout, APIURLs.updateGroupCreationURL,
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
}
