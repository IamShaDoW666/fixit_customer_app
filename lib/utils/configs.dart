import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

const APP_NAME = 'Yallakhedma';
const APP_NAME_TAG_LINE = 'On-Demand Services App';
var defaultPrimaryColor = Color.fromARGB(255, 181, 93, 31);
const DOMAIN_URL = 'https://yallakhedma.com';
const BASE_URL = '$DOMAIN_URL/api/';
const DEFAULT_LANGUAGE = 'en';

/// You can change this to your Provider App package name
/// This will be used in Registered As Partner in Sign In Screen where your users can redirect to the Play/App Store for Provider App
/// You can specify in Admin Panel, These will be used if you don't specify in Admin Panel
const PROVIDER_PACKAGE_NAME = 'com.yallakhedma.provider';
const IOS_LINK_FOR_PARTNER =
    "https://apps.apple.com/in/app/handyman-provider-app/id1596025324";

const IOS_LINK_FOR_USER =
    'https://apps.apple.com/us/app/handyman-service-user/id1591427211';

const DASHBOARD_AUTO_SLIDER_SECOND = 5;

const TERMS_CONDITION_URL = 'https://yallakhedma.com';
const PRIVACY_POLICY_URL = 'https://yallakhedma.com';
const INQUIRY_SUPPORT_EMAIL = 'support@yallakhedma.com';

/// You can add help line number here for contact. It's demo number
const HELP_LINE_NUMBER = '+971565002940';

/// STRIPE PAYMENT DETAIL
const STRIPE_MERCHANT_COUNTRY_CODE = 'UAE';
const STRIPE_CURRENCY_CODE = 'DHS';
DateTime todayDate = DateTime(2022, 8, 24);

/// SADAD PAYMENT DETAIL
const SADAD_API_URL = 'https://api-s.sadad.qa';
const SADAD_PAY_URL = "https://d.sadad.qa";

Country defaultCountry() {
  return Country(
    phoneCode: '971',
    countryCode: 'UAE',
    e164Sc: 971,
    geographic: true,
    level: 1,
    name: 'United Arab Emirates',
    example: '971565002940',
    displayName: 'United Arab Emirates (UAE) [+971]',
    displayNameNoCountryCode: 'United Arab Emirates (UAE)',
    e164Key: '971-UAE-0',
    fullExampleWithPlusSign: '+971565002940',
  );
}
