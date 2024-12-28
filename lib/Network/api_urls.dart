class APIURLs {
  static const networkCheckURL = 'https://www.google.com/';
  static const baseURL = "http://3.111.52.128:5000/api";

  static const loginURL = "$baseURL/auth/user-login";
  static const createUserURL = "$baseURL/auth/customer-sign-up";

  /* Dashoard */
  static const dashboardURL = "$baseURL/dashboard/customer";
  static const pigmyURL = "$baseURL/pigmy/pigmy-list";
  static const groupPigmyURL = "$baseURL/pigmy/pigmy-list";
  static const loanURL = "$baseURL/loan/loan-list";
  static const groupLoanURL = "$baseURL/loan/group-loan/list";
  static const agentsDashboardURL = "$baseURL/agent/get-dashbaord-details";

  static const learnAboutPigmyURL = "$baseURL/pigmy/learn-about-pigmy";

  static const groupMembersURL = "$baseURL/loan/group-loan/members";

  static const resetPasswordURL = "$baseURL/auth/reset-password";

  /* Profile */
  static const profileDetailsURL = "$baseURL/customer/get-profile";
  static const updateProfileDetailsURL = "$baseURL/customer/update-profile";
  /* Profile */

  /* KYC */
  static const updateKYCDetailsURL = "$baseURL/customer/update-kyc";
  /* KYC */

  /* Enquiry */
  static const updateEnquiryDetailsURL = "$baseURL/customer/enquiry";
  /* Enquiry */

  /* PIGMY */
  static const createPIGMYURL = "$baseURL/pigmy/create-pigmy-request";
  static const withdrawPIGMYURL = "$baseURL/pigmy/withdraw-request";
  static const withdrawPIGMYFetchDetailsURL =
      "$baseURL/pigmy/get-withdraw-details";
  static const pigmyTransactionDetURL = "$baseURL/pigmy/get-pigmy-history";
  /* PIGMY */

  static const imageUploadURL = "$baseURL/util/image-upload";

  static const transactionDetURL = "$baseURL/loan/loan-transaction";

  // static const verifyCustomerDashboardURL =
  //     "$baseURL/agent/verify-customer-dashboard";
  static const groupMemberDetailsURL = "$baseURL/agent/get-group-member-detail";
  static const logoutURL = "$baseURL/auth/logout";

  /* Update Payment Details */
  static const updatePaymentPrefetchDetailsURL =
      "$baseURL/collection/get-collection-details-agent";
  static const updatePaymentDetailsURL =
      "$baseURL/collection/update-collection";
  static const updateGroupPaymentPrefetchDetailsURL =
      "$baseURL/collection/get-group-collection-details";
  static const updateGroupEditPayURL = "$baseURL/";
  static const updateGroupPaymentDetailsURL =
      "$baseURL/collection/update-group-collection";
  static const saveDetailGrpPayURL = "$baseURL/";

  static const searchIntermittentDetailsURL =
      "$baseURL/customer/get-customer-details-by-id";
  static const searchCustomerDetailsURL =
      "$baseURL/customer/search-customer-detail";

  static const updateGroupCreationURL = "$baseURL/group/create-group-agent";

  /* Report Details */
  static const reportDetURL = "$baseURL/collection/get-today-collection-list";
  static const verifyCustomerInfoURL =
      "$baseURL/customer/get-verify-customer-list";
  static const verifyCustomerDetPrefetchURL = "$baseURL/customer/get-verify-details";
  /* Report Details */
}
