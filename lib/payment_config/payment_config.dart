
// String get applePayPaymentProfile => """{
//   "provider": "apple_pay",
//   "data": {
//     "merchantIdentifier": "merchant.info.gassho",
//     "displayName": "kkinc",
//     "merchantCapabilities": ["3DS", "debit", "credit"],
//     "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
//     "countryCode": "JP",
//     "currencyCode": "JPY",
//     "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber"],
//     "requiredShippingContactFields": [],
//     "shippingMethods": [] 
//   }
// }""";

const String defaultApplePay = '''{
  "provider": "apple_pay",
  "data": {
    "merchantIdentifier": "merchant.info.gassho",
    "displayName": "kkinc",
    "merchantCapabilities": ["3DS", "debit", "credit"],
    "supportedNetworks": ["amex", "visa", "discover", "masterCard"],
    "countryCode": "JP",
    "currencyCode": "JPY",
    "requiredBillingContactFields": ["emailAddress", "name", "phoneNumber", "postalAddress"],
    "requiredShippingContactFields": [],
    "shippingMethods": [
 
    ] 
  }
}''';