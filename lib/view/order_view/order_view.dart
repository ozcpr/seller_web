import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/get_order_list_model.dart';
import '../../view_model/order_list_view_model.dart';
import '../widget/appbar.dart';
import '../widget/main_page_content.dart';
import '../widget/nav_rail.dart';
import '../widget/screen_body.dart';

class OrderView extends ConsumerWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListAsyncValue = ref.watch(getOrderListProvider);

    return orderListAsyncValue.when(
      data: (orderList) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 1070) {
              return Scaffold(
                drawer: const Drawer(child: NavigationRailDrawer()),
                appBar: AppbarTop(), //appbar
                body: BodyWidget(orderList: orderList, topic: FlutterI18n.translate(context, "tr.order.orders")),
              );
            } else {
              return Scaffold(
                appBar: AppbarTop(), // appbar
                body: SafeArea(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: NavigationRailDrawer(), //drawer
                      ),
                      Expanded(
                        flex: 9,
                        child: BodyWidget(orderList: orderList, topic: FlutterI18n.translate(context, "tr.order.orders")), //order screen body
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/login');
        });
        return Text('An error occurred: $error');
      },
    );
  }
}
