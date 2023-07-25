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
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius:  const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 10, right: 15, left: 20, bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  statusIconMap[status] ?? '', 
                  width: 20.0,
                  height: 20.0,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    flex: 8,
                    child: Text(    // headerStatus
                      FlutterI18n.translate(context, "tr.proposal.$status"),
                      style: Theme.of(context).textTheme.titleLarge!,
                      maxLines: 1,
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
                Text(
                  FlutterI18n.translate(context, "tr.order.no" ),
                  style:Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  id,
                  style:Theme.of(context).textTheme.labelLarge!,
                ),
                const Spacer(flex: 1),
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