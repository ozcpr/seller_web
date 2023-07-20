
  import 'package:flutter/material.dart';
  import 'package:flutter/widgets.dart';

Map<String, String> statusIconMap = {
    'pending': 'assets/pending2.svg',
    'replied': 'assets/exportNotes.svg',
    'proposal_stvs': 'assets/exportNotes.svg',
    // 'order_pending': 'assets/exportNotes.svg',
    'order_approved': 'assets/exportNotes.svg',
    'order_confirmed': 'assets/conveyor.svg',
    'order_prepared': 'assets/trolley.svg',
    'order_on_the_way': 'assets/shipment.svg',
    'order_delivered': 'assets/warehouse.svg',
    'invoice_paid': 'assets/paid.svg',
    'invoice_discounted': 'assets/paymentProcess.svg',
    'invoice_approved_dbs': 'assets/DBS.svg',
    'invoice_pending': 'assets/pending.svg',
    'delivered': 'assets/package.svg',
  };

class ScreenSize {
   MediaQueryData ?mediaQueryData;
   double ?screenWidth;
   double ?screenHeight;
   double ?widthLarge;
   double ?heightLarge;


  //  ScreenSize( {
  //   Key? key,
  //   this.mediaQueryData,
  //   this.screenWidth,
  //   this.screenHeight,
  //   this.widthLarge,
  //   this.heightLarge,
  // });


  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData!.size.width;
    screenHeight = mediaQueryData!.size.height;
    widthLarge = screenWidth! / 1280 ;
    heightLarge = screenHeight! / 720 ;

  }

}
