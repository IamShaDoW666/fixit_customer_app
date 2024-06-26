import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) =>
      Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get walkTitle1;

  String get walkTitle2;

  String get walkTitle3;

  String get getStarted;

  String get signIn;

  String get signUp;

  String get lbloffice => 'Office';

  String get selecttype => 'Select Address Type';

  String get selectBuilding => 'Building/Street Name';

  String get selectApartment => 'Apartment/Villa Number';

  String get hintFirstNameTxt;

  String get hintLastNameTxt;

  String get hintContactNumberTxt;

  String get hintEmailAddressTxt;

  String get hintUserNameTxt;

  String get hintOldPasswordTxt;

  String get hintNewPasswordTxt;

  String get hintPasswordTxt;

  String get hintReenterPasswordTxt;

  String get confirm;

  String get hintEmailTxt;

  String get forgotPassword;

  String get alreadyHaveAccountTxt;

  String get rememberMe;

  String get resetPassword;

  String get dashboard;

  String get camera;

  String get language;

  String get paymentMode;

  String get appTheme;

  String get bookingHistory;

  String get rateUs;

  String get termsCondition;

  String get helpSupport;

  String get privacyPolicy;

  String get inclusions;

  String get uploadimage => 'Kindly upload images related to the service';

  String get uploadimg => 'Upload Images';

  String get notes;

  String get exclusions;

  String get about;

  String get changePassword;

  String get logout;

  String get editProfile;

  String get chooseTheme;

  String get selectCountry;

  String get selectState;

  String get selectCity;

  String get passwordNotMatch;

  String get doNotHaveAccount;

  String get hintAddress;

  String get hintDescription;

  String get lblGallery;

  String get yourReview;

  String get review;

  String get lblApply;

  String get bookTheService;

  String get contactAdmin;

  String get allServices;

  String get duration;

  String get hourly;

  String get payment;

  String get done;

  String get totalAmount;

  String get priceDetail;

  String get home;

  String get category;

  String get cash => "Cash";

  String get card => "Card";

  String get selectedProvider;

  String get changeProvider => "Change Provider";

  String get addressdetail => 'Address Details';

  String get cashHandling => "Cash Handling Charges";

  String get booking;

  String get selectProvider;

  String get profile;

  String get lblAlertBooking;

  String get applyCoupon;

  String get serviceName;

  String get service;

  String get lblCancelReason;

  String get enterReason;

  String get noDataAvailable;

  String get lblOk;

  String get paymentDetail;

  String get paymentStatus;

  String get viewDetail;

  String get appThemeLight;

  String get appThemeDark;

  String get appThemeDefault;

  String get markAsRead;

  String get lblYes;

  String get lblNo;

  String get btnRate;

  String get btnSubmit;

  String get walkThrough1;

  String get walkThrough2;

  String get walkThrough3;

  String get lblNotification;

  String get lblUnAuthorized;

  String get btnNext;

  String get lblViewAll;

  String get notAvailable;

  String get lblFavorite;

  String get lblChat;

  String get getLocation;

  String get setAddress;

  String get requiredText;

  String get phnRequiredText;

  String get lblCall;

  String get lblRateHandyman;

  String get msgForLocationOn;

  String get msgForLocationOff;

  String get lblEnterPhnNumber;

  String get btnSendOtp;

  String get lblLocationOff;

  String get lblAppSetting;

  String get lblSubTotal;

  String get lblImage;

  String get lblVideo;

  String get lblAudio;

  String get lblChangePwdTitle;

  String get lblForgotPwdSubtitle;

  String get lblLoginTitle;

  String get lblLoginSubTitle;

  String get lblOrContinueWith;

  String get lblHelloUser;

  String get lblSignUpSubTitle;

  String get lblStepper1Title;

  String get lblDateAndTime;

  String get chooseDateAndTime;

  String get lblYourAddress;

  String get lblEnterYourAddress;

  String get lblUseCurrentLocation;

  String get lblEnterDescription;

  String get lblPrice;

  String get lblTax;

  String get lblDiscount;

  String get lblAvailableCoupons;

  String get lblPrevious;

  String get lblCoupon;

  String get lblEditYourReview;

  String get lblTime;

  String get textProvider;

  String get lblConfirmBooking;

  String get lblConfirmMsg;

  String get lblCancel;

  String get lblExpiryDate;

  String get lblRemoveCoupon;

  String get lblNoCouponsAvailable;

  String get lblStep1;

  String get lblStep2;

  String get lblStep4;

  String get lblBookingID;

  String get lblDate;

  String get lblAboutHandyman;

  String get lblAboutProvider;

  String get lblNotRatedYet;

  String get lblDeleteReview;

  String get lblConfirmReviewSubTitle;

  String get lblConfirmService;

  String get lblConFirmResumeService;

  String get lblEndServicesMsg;

  String get lblCancelBooking;

  String get lblStart;

  String get lblHold;

  String get lblResume;

  String get lblPayNow;

  String get lblCheckStatus;

  String get lblID;

  String get lblNoBookingsFound;

  String get lblCategory;

  String get lblYourComment;

  String get lblIntroducingCustomerRating;

  String get lblSeeYourRatings;

  String get lblFeatured;

  String get lblNoServicesFound;

  String get lblGENERAL;

  String get lblAboutApp;

  String get lblPurchaseCode;

  String get lblNoRateYet;

  String get lblMemberSince;

  String get lblFilterBy;

  String get lblClearFilter;

  String get lblNoReviews;

  String get lblUnreadNotification;

  String get lblChoosePaymentMethod;

  String get lblNoPayments;

  String get lblPayWith;

  String get payWith;

  String get lblYourRating;

  String get lblEnterReview;

  String get lblDelete;

  String get lblDeleteRatingMsg;

  String get lblSelectRating;

  String get lblNoServiceRatings;

  String get lblSearchFor;

  String get lblRating;

  String get lblAvailableAt;

  String get lblRelatedServices;

  String get lblBookNow;

  String get lblWelcomeToHandyman;

  String get lblWalkThroughSubTitle;

  String get textHandyman;

  String get lblChooseFromMap;

  String get lblDeleteAddress;

  String get lblDeleteSunTitle;

  String get lblFaq;

  String get lblServiceFaq;

  String get lblLogoutTitle;

  String get lblLogoutSubTitle;

  String get lblFeaturedProduct;

  String get lblAlert;

  String get lblOnBase;

  String get lblInvalidCoupon;

  String get lblSelectCode;

  String get lblBackPressMsg;

  String get lblHour;

  String get lblHr;

  String get lblOff;

  String get lblHelplineNumber;

  String get lblSubcategories;

  String get lblAgree;

  String get lblTermsOfService;

  String get lblWalkThrough0;

  String get lblServiceTotalTime;

  String get lblDateTimeUpdated;

  String get lblSelectDate;

  String get lblReasonCancelling;

  String get lblReasonRejecting;

  String get lblFailed;

  String get lblNotDescription;

  String get lblMaterialTheme;

  String get lblServiceProof;

  String get lblAndroid12Support;

  String get lblSignInWithGoogle;

  String get lblSignInWithOTP;

  String get lblDangerZone;

  String get lblDeleteAccount;

  String get lblUnderMaintenance;

  String get lblCatchUpAfterAWhile;

  String get lblId;

  String get lblMethod;

  String get lblStatus;

  String get lblPending;

  String get confirmationRequestTxt;

  String get lblDeleteAccountConformation;

  String get lblAutoSliderStatus;

  String get lblPickAddress;

  String get lblUpdateDateAndTime;

  String get lblRecheck;

  String get lblLoginAgain;

  String get lblUpdate;

  String get lblNewUpdate;

  String get lblOptionalUpdateNotify;

  String get lblAnUpdateTo;

  String get lblIsAvailableWouldYouLike;

  String get lblRegisterAsPartner;

  String get lblSignInWithApple;

  String get lblWaitingForProviderApproval;

  String get lblFree;

  String get lblAppleSignInNotAvailable;

  String get lblTotalExtraCharges;

  String get lblWaitingForResponse;

  String get lblAll;

  String get noConversation;

  String get noConversationSubTitle;

  String get noBookingSubTitle;

  String get myReviews;

  String get noCategoryFound;

  String get noProviderFound;

  String get createServiceRequest;

  String get chooseImages;

  String get serviceDescription;

  String get addNewService;

  String get newPostJobRequest;

  String get postJobTitle;

  String get postJobDescription;

  String get services;

  String get myPostJobList;

  String get requestNewJob;

  String get noNotifications;

  String get noNotificationsSubTitle;

  String get noFavouriteSubTitle;

  String get termsConditionsAccept;

  String get disclaimer;

  String get disclaimerContent;

  String get inputMustBeNumberOrDigit;

  String get requiredAfterCountryCode;

  String get selectedOtherBookingTime;

  String get lblother => 'Other';

  String get myServices;

  String get doYouWantToAssign;

  String get bidPrice;

  String get accept;

  String get price;

  String get remove;

  String get add;

  String get save;

  String get createPostJobWithoutSelectService;

  String get selectCategory;

  String get pleaseAddImage;

  String get selectedBookingTimeIsAlreadyPassed;

  String get jobPrice;

  String get estimatedPrice;

  String get bidder;

  String get assignedProvider;

  String get myPostDetail;

  String get thankYou;

  String get bookingConfirmedMsg;

  String get goToHome;

  String get goToReview;

  String get noServiceAdded;

  String get noPostJobFound;

  String get noPostJobFoundSubtitle;

  String get pleaseEnterValidOTP;

  String get confirmOTP;

  String get sendingOTP;

  String get pleaseSelectDifferentSlotThenPrevious;

  String get pleaseSelectTheSlotsFirst;

  String get editTimeSlotsBooking;

  String get availableSlots;

  String get noTimeSlots;

  String get bookingDateAndSlot;

  String get extraCharges;

  String get chatCleared;

  String get clearChat;

  String get jobRequestSubtitle;

  String get verified;

  String get theEnteredCodeIsInvalidPleaseTryAgain;

  String get otpCodeIsSentToYourMobileNumber;

  String get yourPaymentFailedPleaseTryAgain;

  String get yourPaymentHasBeenMadeSuccessfully;

  String get transactionFailed;

  String get lblStep3;

  String get lblAvailableOnTheseDays;

  String get internetNotAvailable;

  String get pleaseTryAgain;

  String get somethingWentWrong;

  String get postJob;

  String get package;

  String get frequentlyBoughtTogether;

  String get endOn;

  String get buy;

  String get includedServices;

  String get includedInThisPackage;

  String get lblInvalidTransaction;

  String get getTheseServiceWithThisPackage;

  String get lblNotValidUser;

  String get lblSkip;

  String get lblChangeCountry;

  String get lblTimeSlotNotAvailable;

  String get lblAreYouSureWant;

  String get lblAdd;

  String get lblThisService;

  String get lblYourCurrenciesNotSupport;

  String get lblSignInFailed;

  String get lblUserCancelled;

  String get lblTransactionCancelled;

  String get lblExample;

  String get lblCheckOutWithCinetPay;

  String get lblLocationPermissionDenied;

  String get lblLocationPermissionDeniedPermanently;

  String get lblEnableLocation;

  String get lblNoUserFound;

  String get lblUserNotCreated;

  String get lblTokenExpired;

  String get lblConfirmationForDeleteMsg;

  String get favouriteProvider;

  String get noProviderFoundMessage;

  String get personalInfo;

  String get essentialSkills;

  String get knownLanguages;

  String get authorBy;

  String get views;

  String get blogs;

  String get noBlogsFound;

  String get categories;

  String get requestInvoice;

  String get invoiceSubTitle;

  String get sentInvoiceText;

  String get send;

  String get published;

  String get clearChatMessage;

  String get deleteMessage;

  String get accepted;

  String get onGoing;

  String get inProgress;

  String get cancelled;

  String get rejected;

  String get failed;

  String get completed;

  String get pendingApproval;

  String get waiting;

  String get paid;

  String get advancePaid;

  String get insufficientBalanceMessage;

  String get cinetPayNotSupportedMessage;

  String get loading;

  String get walletBalance;

  String get payAdvance;

  String get advancePaymentMessage;

  String get advancePayAmount;

  String get remainingAmount;

  String get advancePayment;

  String get withExtraAndAdvanceCharge;

  String get withExtraCharge;

  String get min;

  String get hour;

  String get customerRatingMessage;

  String get paymentHistory;

  String get message;

  String get wallet;

  String get payWithFlutterWave;

  String get goodMorning;

  String get goodAfternoon;

  String get goodEvening;

  String get invalidURL;

  String get use24HourFormat;

  String get email;

  String get badRequest;

  String get forbidden;

  String get pageNotFound;

  String get tooManyRequests;

  String get internalServerError;

  String get badGateway;

  String get serviceUnavailable;

  String get gatewayTimeout;

  String get pleaseWait;

  String get externalWallet;

  String get userNotFound;

  String get requested;

  String get assigned;

  String get reload;

  String get lblStripeTestCredential;

  String get noDataFoundInFilter;

  String get addYourCountryCode;

  String get help;

  String get couponCantApplied;

  String get priceAmountValidationMessage;

  String get pleaseWaitWhileWeLoadChatDetails;

  String get isNotAvailableForChat;

  String get connectWithFirebaseForChat;

  String get closeApp;

  String get providerAddedToFavourite;

  String get providerRemovedFromFavourite;

  String get provideValidCurrentPasswordMessage;

  String get copied;

  String get copyMessage;

  String get messageDelete;

  String get pleaseChooseAnyOnePayment;

  String get myWallet;

  String get balance;

  String get topUpWallet;

  String get topUpAmountQuestion;

  String get paymentMethod;

  String get selectYourPaymentMethodToAddBalance;

  String get proceedToTopUp;

  String get serviceAddedToFavourite;

  String get serviceRemovedFromFavourite;

  String get firebaseRemoteCannotBe;

  String get search;

  String get close;

  String get totalAmountShouldBeMoreThan;

  String get totalAmountShouldBeLessThan;

  String get doYouWantToTopUpYourWallet;

  String get chooseYourLocation;

  String get connect;

  String get transactionId;

  String get at;

  String get appliedTaxes;

  String get accessDeniedContactYourAdmin;

  String get yourWalletIsUpdated;
}
