class APIURLs {
  static const networkCheckURL = 'https://www.google.com/';

  /* Staging */
  static const baseURL = "http://3.111.52.128:5000/api";
  /* Staging */

  /* Production */
  // static const baseURL = "http://3.111.52.128:5000/api";
  /* Production */

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
  static const updateIndividualGroupDetailsURL =
      "$baseURL/customer/create-customer-agent";
  static const updateAddressMobNumURL =
      "$baseURL/customer/update-address-phone";
  /* KYC */

  /* Enquiry */
  static const updateEnquiryDetailsURL = "$baseURL/customer/enquiry";
  /* Enquiry */

  /* PIGMY */
  static const createPIGMYURL = "$baseURL/pigmy/create-pigmy-request";
  static const createPIGMYbyAgentURL =
      "$baseURL/customer/create-pigmy-customer-agent";
  static const withdrawPIGMYURL = "$baseURL/pigmy/withdraw-request";
  static const withdrawPIGMYFetchDetailsURL =
      "$baseURL/pigmy/get-withdraw-details";
  static const pigmyTransactionDetURL = "$baseURL/pigmy/get-pigmy-history";
  static const withdrawPIGMYFetchDetailsByAgentURL =
      "$baseURL/pigmy/get-withdraw-prefill-agent";
  static const withdrawPIGMYbyAgentURL =
      "$baseURL/pigmy/create-withdraw-request-agent";
  /* PIGMY */

  static const imageUploadURL = "$baseURL/util/image-upload";

  static const transactionDetURL = "$baseURL/loan/loan-transaction";

  static const groupMemberDetailsURL = "$baseURL/agent/get-group-member-detail";
  static const logoutURL = "$baseURL/auth/logout";

  /* Update Payment Details */
  static const updatePaymentPrefetchDetailsURL =
      "$baseURL/collection/get-collection-details-agent";
  static const updatePaymentDetailsURL =
      "$baseURL/collection/update-collection";
  static const updateGroupPaymentPrefetchDetailsURL =
      "$baseURL/collection/get-group-collection-details";
  static const updateGroupEditPayURL =
      "$baseURL/collection/edit-group-collection";
  static const updateGroupPaymentDetailsURL =
      "$baseURL/collection/update-group-collection";
  static const saveDetailGrpPayURL =
      "$baseURL/collection/save-group-collection";

  static const searchIntermittentDetailsURL =
      "$baseURL/customer/get-customer-details-by-id";
  static const searchCustomerDetailsURL =
      "$baseURL/customer/search-customer-detail";

  static const updateGroupCreationURL = "$baseURL/group/create-group-agent";

  /* Report Details */
  static const reportDetURL = "$baseURL/collection/get-today-collection-list";
  static const verifyCustomerInfoURL =
      "$baseURL/customer/get-verify-customer-list";
  static const verifyCustomerDetPrefetchURL =
      "$baseURL/customer/get-verify-details";
  /* Report Details */

  /* Search Collection */
  static const searchCollectionURL =
      "$baseURL/collection/search-collection"; // type: 1 - PIGMY | 2 - G PIGMY | 3 - LOANS | 4 - G Loans
  /* Search Collection */

  /* Close Loan */
  static const closeLoanURL = "$baseURL/loan/close-loan";
  /* Close Loan */
}
