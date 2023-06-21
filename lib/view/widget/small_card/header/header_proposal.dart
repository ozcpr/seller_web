import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../utils/widget_helper.dart';
import '../../countdown_date.dart';

class HeaderProposal extends StatelessWidget {
  final String id;
  final String status;
  final String headerDate;
  final String className;
  final Widget ?newMessageSvg;

  const HeaderProposal({ 
    Key? key, 
    required this.id, 
    required this.status, 
    required this.headerDate, 
    this.newMessageSvg, required this.className
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    const surfaceDim = Color(0xFFD8DBD8);
    return Container(
      decoration: const BoxDecoration(
          color: surfaceDim,
          borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10, right: 15, left: 20, bottom: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(  // icon
                  child: SvgPicture.asset(
                    statusIconMap[status] ?? '', 
                    semanticsLabel: 'Order Status Icon',
                    width: 30.0,
                    height: 30.0,
                  ),
                ),
                Expanded(
                    flex: 15,
                    child: AutoSizeText(    // headerStatus
                      FlutterI18n.translate(context, "tr.proposal.$status"),
                      style:
                          Theme.of(context).textTheme.titleMedium!,
                    )),
                Flexible(child: newMessageSvg ?? const SizedBox(width: 1)),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // headerId
                Flexible(
                  child:  AutoSizeText(
                    FlutterI18n.translate(context, "tr.order.no" ) + id,
                    style: Theme.of(context).textTheme.titleMedium!,
                    )
                ),
                 // header date
                Flexible( 
                  child: CountdownDate(headerDate: headerDate),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}