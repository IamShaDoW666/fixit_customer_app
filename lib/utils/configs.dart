import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

const APP_NAME = 'YallaKhedma';
const APP_NAME_TAG_LINE = 'Ouality Services Beyond Expectations';
const APP_DEVELOPER_NAME = 'Developed by Digiimpact';
var defaultPrimaryColor = Color.fromARGB(255, 241, 119, 32);
// const DOMAIN_URL = 'https://yallakhedma.com';
const DOMAIN_URL = 'https://yallakhedma.com';
const BASE_URL = '$DOMAIN_URL/api/';
const DEFAULT_LANGUAGE = 'en';

/// You can change this to your Provider App package name
/// This will be used in Registered As Partner in Sign In Screen where your users can redirect to the Play/App Store for Provider App
/// You can specify in Admin Panel, These will be used if you don't specify in Admin Panel
const PROVIDER_PACKAGE_NAME = 'com.yallakhedma.provider';
const IOS_LINK_FOR_PARTNER = "";

const IOS_LINK_FOR_USER = '';

const DASHBOARD_AUTO_SLIDER_SECOND = 5;

const TERMS_CONDITION_URL = 'https://yallakhedma.com/term-conditions';
const PRIVACY_POLICY_URL = 'https://yallakhedma.com/privacy-policy';
const INQUIRY_SUPPORT_EMAIL = 'support@yallakhedma.com';

/// You can add help line number here for contact. It's demo number
const HELP_LINE_NUMBER = '+971565002940';

/// STRIPE PAYMENT DETAIL
const STRIPE_MERCHANT_COUNTRY_CODE = 'AE';
const STRIPE_CURRENCY_CODE = 'DHS';
DateTime todayDate = DateTime(2022, 8, 24);

/// SADAD PAYMENT DETAIL
const SADAD_API_URL = 'https://api-s.sadad.qa';
const SADAD_PAY_URL = "https://d.sadad.qa";

Country defaultCountry() {
  return Country(
    phoneCode: '971',
    countryCode: 'AE',
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
