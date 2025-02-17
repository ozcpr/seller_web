import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:data_table_2/data_table_2.dart';

import '../../../../utils/widget_helper.dart';

class ProductListTable extends StatelessWidget {
  final List productList;
  final String className;

  const ProductListTable({
    super.key, 
    required this.productList,
    required this.className
    });

  @override
  Widget build(BuildContext context) {
    Map<String, String> description= {
      'order': FlutterI18n.translate(context, "tr.order.description"),
      'proposal': FlutterI18n.translate(context, "tr.proposal.proposal_note"),
    };

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
          label: Text('#', maxLines: 1, textDirection: TextDirection.rtl),
          numeric: true,
          fixedWidth: 20,
        ),
        DataColumn2(
          label: Text(FlutterI18n.translate(context, "tr.order.product")),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(description[className] ?? ' '),  //tedarikci nocu
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
          // size: ColumnSize.S,
          fixedWidth: 70,
        ),
      ],
      rows: productList
          .map(
            (item) => DataRow2(
              cells: [
                DataCell(Text((productList.indexOf(item) + 1).toString(), textDirection: TextDirection.ltr,)),
                DataCell(Text(item.name.toString())), //product_name
                DataCell(Text(item.description.toString())), //propsal_note
                DataCell(
                  Text(
                    '${item.amount} ' ' ${item.unit}',
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
                    calcuteAmount(item.amount.toString(), item.price.toString()),
                    textDirection: TextDirection.rtl,
                  )
                ),
            ]),
          )
          .toList(),
    );
  }
}
