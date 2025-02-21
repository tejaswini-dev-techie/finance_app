class ValidationUtil {
  /* Group Name Validation */
  static String? validateGroupName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%]').hasMatch(value)) {
      return 'Group Name should not contain special characters';
    }
    return null;
  }
  /* Group Name Validation */

  /* Name Validation */
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Name should not contain numbers or special characters';
    }
    return null;
  }
  /* Name Validation */

  /* Reference Name Validation */
  static String? validateReferenceName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Reference Name';
    } else if (value.length < 3) {
      return 'Reference Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Reference Name should not contain numbers or special characters';
    }
    return null;
  }
  /* Reference Name Validation */

  /* Agent Name Validation */
  static String? validateAgentName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Agent Name';
    } else if (value.length < 3) {
      return 'Agent Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Agent Name should not contain numbers or special characters';
    }
    return null;
  }
  /* Agent Name Validation */

  /* Agent Number Validation */
  static String? validateAgentNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    } else if (value.length != 10) {
      return 'Mobile number must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number can only contain digits';
    }
    return null;
  }
  /* Agent Number Validation */

  /* Verified By Agent Name Validation */
  static String? validateByAgentName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Verifed By Agent Name';
    } else if (value.length < 3) {
      return 'Verifed By Agent Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Verifed By Agent Name should not contain numbers or special characters';
    }
    return null;
  }
  /* Verified By Agent Name Validation */

  /* Mobile Number Validation */
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number cannot be empty';
    } else if (value.length != 10) {
      return 'Mobile number must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number can only contain digits';
    }
    return null;
  }
  /* Mobile Number Validation */

  /* Password Validation */
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters long';
    }
    return null;
  }
  /* Password Validation */

  /* Confirm Passowrd Validation */
  static String? confirmPasswordValidation(String? value, String? newPswdVal) {
    if (value == null || value.isEmpty) {
      return 'Please enter the confirm password';
    } else if (value != newPswdVal) {
      return "The password entered doesn't match";
    }
    return null;
  }

  /* Confirm Password Validation */

  /* Email Address Validation */
  static String? validateEmailAddress(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }
  /* Email Address Validation */

  /* location */
  static String? validateLocation(String? value, int type,
      {String? pageType =
          "0"} // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
      ) {
    /* type 1 - Street Address | 2 - State | 3 - City | 4 - Country | 5 - Permanent Address | 6 - Guarantor's location */
    if (value == null || value.isEmpty) {
      return (type == 1)
          ? 'Please enter Current Address'
          : (type == 2)
              ? 'Please enter State'
              : (type == 3)
                  ? 'Please enter City'
                  : (type == 4)
                      ? 'Please enter Country'
                      : (type == 5)
                          ? "Please enter Permanent Address"
                          : (type == 6)
                              ? ((pageType == "1") || (pageType == "2"))
                                  ? null
                                  : "Please enter Guarantor's location details"
                              : "Please enter location details";
    }
    return null;
  }
  /* location */

  /* Pincode Validation */
  static String? validatePinCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pin Code cannot be empty';
    } else if (value.length != 6) {
      return 'Pin Code must be exactly 6 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Pin Code can only contain digits';
    }
    return null;
  }
  /* Pincode Validation */

  /* Deposit Amount Validation */
  static String? validateDepositAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Amount cannot be empty';
    } else if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(value)) {
      return 'Amount can only contain digits';
    }
    return null;
  }
  /* Deposit Amount Validation */

  /* Alternate Mobile Number Validation */
  static String? validateAltMobileNumber(
      String? value, String? primaryMobileNumber) {
    if (value == null || value.isEmpty) {
      // Return null because validation should only occur if there's a value
      return null;
    } else if (value.length != 10) {
      return 'Mobile number must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number can only contain digits';
    } else if (primaryMobileNumber != null && primaryMobileNumber == value) {
      return 'Mobile number and alternate mobile number cannot be the same';
    }
    return null;
  }
  /* Alternate Mobile Number Validation */

  /* Mobile Number Validation */
  static String? validateReferenceMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (value.length != 10) {
      return 'Mobile number must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number can only contain digits';
    }
    return null;
  }
  /* Mobile Number Validation */

  /* Frequency Validation */
  static String? validateFrequency(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select the frequency';
    } else if (value == "Select PIGMY Frequency") {
      return 'Please select the frequency';
    }
    return null;
  }
  /* Frequency Validation */

  /* Withdrawal Amount Validation */
  static String? validateWithdrawAmount(String? value, {String balAmt = "0"}) {
    if (value == null || value.isEmpty) {
      return 'Withdraw Amount cannot be empty';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Withdraw Amount can only contain digits';
    } else if (int.parse(value) > int.parse(balAmt)) {
      return 'Withdraw Amount can\'t exceed available balance';
    }
    return null;
  }
  /* Withdrawal Amount Validation */

  /* Withdrawal Reason Validation */
  static String? validateWithdrawReason(String? value) {
    if (value == null || value.isEmpty) {
      return 'Reason cannot be empty';
    }
    return null;
  }
  /* Withdrawal Reason Validation */

  /* Aadhaar Validation */
  static String? validateAadhaar(String? value) {
    final aadhaarPattern =
        RegExp(r"^[2-9]{1}[0-9]{11}$"); // Aadhaar regex pattern
    if (value == null || value.isEmpty) {
      return 'Please enter Aadhaar number';
    } else if (!aadhaarPattern.hasMatch(value)) {
      return 'Please enter a valid 12-digit Aadhaar number';
    }
    return null;
  }
  /* Aadhaar Validation */

  /* Guarantor Aadhaar Validation */
  static String? validateGuarantorAadhaar(
    String? value,
    String? type,
  ) {
    final aadhaarPattern =
        RegExp(r"^[2-9]{1}[0-9]{11}$"); // Aadhaar regex pattern
    if (value == null || value.isEmpty) {
      return ((type == "1") || (type == "2"))
          ? null
          : 'Please enter Guarantor\'s Aadhaar number';
    } else if (!aadhaarPattern.hasMatch(value)) {
      return 'Please enter a valid 12-digit Aadhaar number';
    }
    return null;
  }
  /* Guarantor Aadhaar Validation */

  /* PAN Validation */
  static String? validatePAN(String? value) {
    // PAN regex pattern: 5 uppercase letters, 4 digits, and 1 uppercase letter
    final panPattern = RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]{1}$");
    if (value == null || value.isEmpty) {
      return 'Please enter PAN number';
    } else if (!panPattern.hasMatch(value)) {
      return 'Please enter a valid 10-character PAN number';
    }
    return null;
  }
  /* PAN Validation */

  /* Guarantor PAN Validation */
  static String? validateGuarantorPAN(String? value) {
    // PAN regex pattern: 5 uppercase letters, 4 digits, and 1 uppercase letter
    final panPattern = RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]{1}$");
    if (value == null || value.isEmpty) {
      return null;
    } else if (!panPattern.hasMatch(value)) {
      return 'Please enter a valid 10-character Guarantor\'s PAN number';
    }
    return null;
  }
  /* Guarantor PAN Validation */

  /* CODE or ID Validation */
  static String? validateCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Code cannot be empty';
    }
    return null;
  }
  /* CODE or ID Validation */

  /* Cheque Number Validation */
  static String? validateChequeNumber(String? value) {
    // Cheque number regex pattern: 6 to 10 digits
    final chequePattern = RegExp(r"^[0-9]{6,10}$");
    if (value == null || value.isEmpty) {
      return 'Please enter cheque number';
    } else if (!chequePattern.hasMatch(value)) {
      return 'Please enter a valid cheque number (6-10 digits)';
    }
    return null;
  }
  /* Cheque Number Validation */

  /* Cheque Number Validation */
  static String? validateGuarantorChequeNumber(String? value, String? type) {
    // Cheque number regex pattern: 6 to 10 digits
    final chequePattern = RegExp(r"^[0-9]{6,10}$");
    if (value == null || value.isEmpty) {
      return ((type == "1") || (type == "2"))
          ? null
          : 'Please enter cheque number';
    } else if (!chequePattern.hasMatch(value)) {
      return 'Please enter a valid cheque number (6-10 digits)';
    }
    return null;
  }
  /* Cheque Number Validation */

  /* Property Details Validation */
  static String? validatePropertyDetails(String? value) {
    if (value == null || value.isEmpty) {
      return 'Property Details cannot be empty';
    }
    return null;
  }
  /* Property Details Validation */

  /* RC Holder Name Validation */
  static String? validateRCHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter RC Holder name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Name should not contain numbers or special characters';
    }
    return null;
  }
  /* RC Holder Name Validation */

  /* Property Holder Name Validation */
  static String? validatePropertyHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter Property Holder name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Name should not contain numbers or special characters';
    }
    return null;
  }
  /* Property Holder Name Validation */

  /* Image Error */
  static String? validateImage(String? value, int type) {
    // type 1 - Aadhaar | 2 - PAN | 3 - Cheque | 4 - RC | 5 - Property | 6 - Bank Pass book
    if (value == null || value.isEmpty) {
      return (type == 1)
          ? 'Please upload valid Aadhaar Image'
          : (type == 2)
              ? 'Please upload valid PAN Image'
              : (type == 3)
                  ? 'Please upload valid Cheque Image'
                  : (type == 4)
                      ? 'Please upload valid RC Image'
                      : (type == 5)
                          ? 'Please upload valid Property Image'
                          : (type == 6)
                              ? "Please upload valid Bank Pass book Image"
                              : (type == 7)
                                  ? "Please upload valid Signature Image"
                                  : (type == 8)
                                      ? 'Please upload valid Photo Image'
                                      : 'Please upload valid Image';
    }
    return null;
  }
  /* Image Error */

  /* Loan Amount Validation */
  static String? validateLoanAmount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Loan Amount cannot be empty';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Loan Amount can only contain digits';
    }
    return null;
  }
  /* Loan Amount Validation */

  /* Bank Name Validation */
  static String? validateBankName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the bank name';
    }
    return null;
  }
/* Bank Name Validation */

/* Bank Account Number Validation */
  static String? validateAccountNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter bank account number';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Account number should contain only numbers';
    } else if (value.length < 8 || value.length > 18) {
      return 'Account number must be between 8 and 18 digits long';
    }
    return null;
  }
/* Bank Account Number Validation */

/* Bank Branch Name Validation */
  static String? validateBranchName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the bank branch name';
    } else if (value.length < 3) {
      return 'Branch name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9]').hasMatch(value)) {
      return 'Branch name should not contain numbers or special characters';
    }
    return null;
  }
/* Bank Branch Name Validation */

/* IFSC Code Validation */
  // static String? validateIFSC(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter the IFSC code';
  //   } else if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(value)) {
  //     return 'Invalid IFSC code format';
  //   } else if (value.length != 11) {
  //     return 'IFSC code must be 11 characters long';
  //   }
  //   return null;
  // }
/* IFSC Code Validation */

/* Nominee Name Validation */
  static String? validateNomineeName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter nominee name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Nominee name should not contain numbers or special characters';
    }
    return null;
  }
  /* Nominee Name Validation */

  /* Nominee Relation Validation */
  static String? validateNomineeRelation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter nominee relation';
    } else if (value.length < 3) {
      return 'Relation must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Nominee relation should not contain numbers or special characters';
    }
    return null;
  }
  /* Nominee Relation Validation */

  /* Nominee Acc Holder Name Validation */
  static String? validateNomineeAccHolderName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter bank account holder name';
    } else if (value.length < 3) {
      return 'Bank account holder name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Bank account holder name should not contain numbers or special characters';
    }
    return null;
  }
  /* Nominee Acc Holder Name Validation */

  /* Fields Validation */
  static String? validateFieldsValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is mandatory';
    } else if (value.length < 3) {
      return 'Field must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Field should not contain numbers or special characters';
    }
    return null;
  }
  /* Fields Validation */

  /* Tenure Validation */
  static String? validateTenure(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the tenure';
    }
    return null;
  }
  /* Tenure Validation */

  /* Amount To be Paid Validation */
  static String? validateAmtToBePaid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }
  /* Amount To be Paid Validation */

  /* Frequency Validation */
  static String? validatePigmyPlan(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select the PIGMY Plan';
    } else if (value == "Select PIGMY Plan") {
      return 'Please select the PIGMY Plan';
    }
    return null;
  }
  /* Frequency Validation */

  /* Frequency Validation */
  static String? validateDocType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select the document type';
    } else if (value == "Select Document Type") {
      return 'Please select the document type';
    }
    return null;
  }
  /* Frequency Validation */

  /* Guarantor Name Validation */
  static String? validateGuarantorName(
    String? value,
    String?
        type, // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
  ) {
    if (value == null || value.isEmpty) {
      return ((type == "1") || (type == "2"))
          ? null
          : 'Please enter Guarantor name';
    } else if (value.length < 3) {
      return 'Guarantor Name must be at least 3 characters long';
    } else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return 'Guarantor Name should not contain numbers or special characters';
    }
    return null;
  }
  /* Name Validation */

  /* Guarantor Mobile Number Validation */
  static String? validateGuarantorMobileNumber(
    String? value,
    String?
        type, // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
  ) {
    if (value == null || value.isEmpty) {
      return ((type == "1") || (type == "2"))
          ? null
          : 'Guarantor Mobile number cannot be empty';
    } else if (value.length != 10) {
      return 'Guarantor Mobile number must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Guarantor Mobile number can only contain digits';
    }
    return null;
  }
  /* Guarantor Mobile Number Validation */

  /* Guarantor Alternate Mobile Number Validation */
  static String? validateGuarantorAltMobileNumber(
    String? value,
    String? primaryMobileNumber,
  ) {
    if (value == null || value.isEmpty) {
      // Return null because validation should only occur if there's a value
      return null;
    } else if (value.length != 10) {
      return 'Guarantor Mobile number must be exactly 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Guarantor Mobile number can only contain digits';
    } else if (primaryMobileNumber != null && primaryMobileNumber == value) {
      return 'Guarantor Mobile number and alternate mobile number cannot be the same';
    }
    return null;
  }
  /* Guarantor Alternate Mobile Number Validation */

  /* Guarantor Email Address Validation */
  static String? validateGuarantorEmailAddress(
    String? value,
    String?
        type, // type: 0 - KYC | 1 - Add Group Customer | 2 - Register Individual Customer | 3- Verification SCreen - Customer Details
  ) {
    if (value == null || value.isEmpty) {
      return null;
    } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(value)) {
      return 'Please enter a valid Guarantor email address';
    }
    return null;
  }
  /* Guarantor Email Address Validation */
}
