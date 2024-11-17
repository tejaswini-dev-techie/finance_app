import 'package:flutter/material.dart';
import 'package:hp_finance/Constants/routing_constants.dart';
import 'package:hp_finance/Screens/CreateAccountScreen/create_account_screen.dart';
import 'package:hp_finance/Screens/CreatePigmySavingsAccount/create_pigmy_savings_acc_screen.dart';
import 'package:hp_finance/Screens/CustomCamera/capture_photo_camera.dart';
import 'package:hp_finance/Screens/Dashboard/dashboard_screen.dart';
import 'package:hp_finance/Screens/Enquiry/enquiry_screen.dart';
import 'package:hp_finance/Screens/GroupMembersDetails/group_members_details_screen.dart';
import 'package:hp_finance/Screens/IntroScreen/intro_screen.dart';
import 'package:hp_finance/Screens/LearnAboutPigmySavings/learn_about_pigmy_savings_screen.dart';
import 'package:hp_finance/Screens/LoginScreen/login_screen.dart';
import 'package:hp_finance/Screens/PigmyHistory/pigmy_history_screen.dart';
import 'package:hp_finance/Screens/Profile/profile_screen.dart';
import 'package:hp_finance/Screens/ResetPassword/reset_password_screen.dart';
import 'package:hp_finance/Screens/SearchCustomerDetails/search_customer_details_screen.dart';
import 'package:hp_finance/Screens/SearchIntermitentScreen/search_intermitent_screen.dart';
import 'package:hp_finance/Screens/TransactionDetails/transaction_details_screen.dart';
import 'package:hp_finance/Screens/UpdatePaymentDetails/update_payment_details.dart';
import 'package:hp_finance/Screens/VerfifyCustomers/verfify_customers.dart';
import 'package:hp_finance/Screens/WithdrawPigmySavings/withdraw_pigmy_savings_screen.dart';
import 'package:sizer/sizer.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case RoutingConstants.routeDefault:
        return MaterialPageRoute(
          builder: (_) => const IntroScreen(),
          settings: RouteSettings(name: settings.name),
        );

      /* Login Screen */
      case RoutingConstants.routeLoginScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const LoginScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const LoginScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }

      /* Create Account Screen */
      case RoutingConstants.routeCreateAccountScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const CreateAccountScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const CreateAccountScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }

      /* Dashboard Screen */
      case RoutingConstants.routeDashboardScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => Dashboard(
                tabIndex: data['data']['tab_index'] ?? "",
              ),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const Dashboard(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }

      case RoutingConstants.routeEnquiryScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => EnquiryScreen(
                title: data['data']['title'] ?? "Enquiry",
              ),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const EnquiryScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }

      case RoutingConstants.routeCreatePigmySavingsAccountScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const CreatePigmySavingsAccountScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const CreatePigmySavingsAccountScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }

      /* Profile Screen */
      case RoutingConstants.routeProfileScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Profile Screen */

      /* Learn About Pigmy Savings Screen */
      case RoutingConstants.routeLearnAboutPigmySavingsScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const LearnAboutPigmySavingsScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const LearnAboutPigmySavingsScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Learn About Pigmy Savings Screen */

      /* Reset Password */
      case RoutingConstants.routeResetPasswordScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const ResetPassword(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const ResetPassword(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Reset Password */

      /* Withdraw Pigmy Savings */
      case RoutingConstants.routeWithdrawPigmySavingsScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const WithdrawPigmySavings(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const WithdrawPigmySavings(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Withdraw Pigmy Savings */

      /* Pigmy Transaction History */
      case RoutingConstants.routePigmyHistoryScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const PigmyHistoryScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const PigmyHistoryScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Pigmy Transaction History */

      /* Transaction History */
      case RoutingConstants.routeTransactionDetails:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const TransactionDetails(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const TransactionDetails(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Transaction History */

      /* Search Customer Details */
      case RoutingConstants.routeSearchCustomerDetails:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const SearchCustomerDetails(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const SearchCustomerDetails(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Search Customer Details */

      /* Search Customer Details */
      case RoutingConstants.routeGroupMembersDetailScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => const GroupMembersDetailsScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const GroupMembersDetailsScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Search Customer Details */

      /* Verify Customer Details */
      case RoutingConstants.routeVerifyCustomersDetailsScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => VerifyCustomersDetailsScreen(
                title: data['data']['title'] ?? "KYC",
              ),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const VerifyCustomersDetailsScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Verify Customer Details */

      /* Payment - Agent Collecting Amount from Customers Details */
      case RoutingConstants.routeAgentUpdatePaymentDetailsScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
              builder: (_) => UpdateCustomersPaymentDetailsScreen(
                title: data['data']['title'] ?? "Payment",
                customerID: data['data']['customerID'] ?? "0",
              ),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (_) => const UpdateCustomersPaymentDetailsScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Payment - Agent Collecting Amount from Customers Details */

      /* Capture Photo */
      case RoutingConstants.routeCapturePhotoCamera:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
                builder: (_) => CapturePhotoCamera(
                      type: data['data']['type'] ?? 1,
                    ),
                settings: RouteSettings(name: settings.name));
          } else {
            return MaterialPageRoute(
              builder: (_) => const CapturePhotoCamera(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Capture Photo */

      /* Search Intermittent Screen */

      case RoutingConstants.routeSearchIntermittentScreen:
        {
          if (args != "" && args != null) {
            Map<String, dynamic> data;
            data = args;
            return MaterialPageRoute(
                builder: (_) => SearchIntermitentScreen(
                      customerID: data['data']['customerID'] ?? "0",
                    ),
                settings: RouteSettings(name: settings.name));
          } else {
            return MaterialPageRoute(
              builder: (_) => const SearchIntermitentScreen(),
              settings: RouteSettings(
                name: settings.name,
              ),
            );
          }
        }
      /* Search Intermittent Screen */

      /* Error Route */
      default:
        return _errorRoute(settings.name);
    }
    // return null;
  }

  static Route<dynamic> _errorRoute(pageName) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(Icons.error_outline),
              Text(
                RoutingConstants.errPageText + pageName.toString(),
                style: TextStyle(
                  letterSpacing: 0.5,
                  height: 1.5,
                  fontStyle: FontStyle.normal,
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
