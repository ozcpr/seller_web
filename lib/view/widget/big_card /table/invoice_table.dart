import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../utils/widget_helper.dart';

class InvoiceTable extends StatelessWidget {
  final List invoiceProductList;
  final String className;

  const InvoiceTable({
    super.key, 
    required this.invoiceProductList,
    required this.className
    });

  @override
  Widget build(BuildContext context) {
    //debugPrint('invoiceProductList: $invoiceProductList.shippedAmount');
    
    return DataTable2(
      columnSpacing: 5,
      fixedTopRows: 1,
      fixedLeftColumns: 1,
      dataRowHeight: 30,
      headingRowHeight: 30,
      smRatio: 0.3,
      lmRatio: 1.2,
      headingTextStyle: Theme.of(context).textTheme.labelMedium,
      dataTextStyle: Theme.of(context).textTheme.bodyMedium,
      dataRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.onPrimary),
      headingRowColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.surfaceVariant),
      columns: [
        const DataColumn2(
          // fixedWidth: 33,
          label: Text('#', textDirection: TextDirection.rtl),
          numeric: true,
          fixedWidth: 20,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.product")),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.description")),  //tedarikci nocu
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.amount")),
          size: ColumnSize.M,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.price")),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.total")),
          numeric: true,
          size: ColumnSize.S,
          // fixedWidth: 70,
        ),
      ],
      rows: invoiceProductList
          .map(
            (item) => DataRow2(
              cells: [
                DataCell(Text((invoiceProductList.indexOf(item) + 1).toString(), textDirection: TextDirection.ltr,)),
                DataCell(Text(item.name.toString())), //product_name
                DataCell(Text(item.proposalNote.toString())), //propsal_note
                DataCell(
                  Text(
                    '${item.shippedAmount} ' ' ${item.unit}',
                    // textDirection: TextDirection.rtl,
                  )
                ), //product_unit
                DataCell(
                  Text(
                    item.price.toString(),
                    textDirection: TextDirection.rtl,
                  )
                ),
                DataCell(
                  Text(
                  item.price.toString() == 'null' ? '-' 
                  : calcuteAmount(item.shippedAmount.toString(), item.price.toString()),
                    textDirection: TextDirection.rtl,
                  )
                ),
            ]),
          )
          .toList(),
    );
  }
}