class BookingAmountModel {
  num finalTotalServicePrice;
  num finalTotalTax;
  num finalSubTotal;
  num finalDiscountAmount;
  num finalCouponDiscountAmount;
  num finalGrandTotalAmount;
  num cashHandlingCharge;
  num vatAmount;

  BookingAmountModel({
    this.finalTotalServicePrice = 0,
    this.finalTotalTax = 0,
    this.finalSubTotal = 0,
    this.vatAmount = 0,
    this.finalDiscountAmount = 0,
    this.finalCouponDiscountAmount = 0,
    this.finalGrandTotalAmount = 0,
    this.cashHandlingCharge = 0,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['final_total_service_price'] = this.finalTotalServicePrice;
    data['final_total_tax'] = this.finalTotalTax;
    data['final_sub_total'] = this.finalSubTotal;
    data['vat_amount'] = this.vatAmount;
    data['final_discount_amount'] = this.finalDiscountAmount;
    data['final_coupon_discount_amount'] = this.finalCouponDiscountAmount;
    data['cash_handling_charge'] = this.cashHandlingCharge;
    return data;
  }

  Map<String, dynamic> toBookingUpdateJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['final_total_service_price'] = this.finalTotalServicePrice;
    data['final_total_tax'] = this.finalTotalTax;
    data['final_sub_total'] = this.finalSubTotal;
    data['vat_amount'] = this.vatAmount;
    data['final_discount_amount'] = this.finalDiscountAmount;
    data['final_coupon_discount_amount'] = this.finalCouponDiscountAmount;
    data['cash_handling_charge'] = this.cashHandlingCharge;
    data['total_amount'] = this.finalGrandTotalAmount;
    return data;
  }
}
