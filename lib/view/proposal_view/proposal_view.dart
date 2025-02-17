import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:seller_point/view/widget/big_card%20/info/info.dart';
import '../../utils/widget_helper.dart';
import '../../view_model/create_order_view_model.dart';
import '../../view_model/proposal_view_model.dart';
import '../../view_model/provider_controller.dart';
import '../widget/big_card /buttons/button_widget.dart';
import '../widget/big_card /info/info_box.dart';
import '../widget/loading_widget.dart';
import '../widget/main_page_content.dart';
import '../widget/small_card/small_card.dart';

class ProposalView extends ConsumerWidget {
  const ProposalView({
    Key? key,
  }) : super(key: key);
  final String className = 'proposal';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalListAsyncValue = ref.watch(getProposalListProvider);
    return proposalListAsyncValue.when(
      data: (proposalList) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: constraints.maxHeight > 300,
                    child: allMainPageContent(
                      topic: FlutterI18n.translate(context, 'tr.proposal.proposals')
                    ),
                  ),
                  Flexible(
                    child: StaggeredGridView.countBuilder(
                      crossAxisCount: getCrossAxisCount(constraints),
                      mainAxisSpacing: 3,
                      crossAxisSpacing: 3,
                      itemCount: proposalList.length,
                      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        return SmallCard(
                          index: index,
                          className: className,
                          id: proposalList[index].proposalId.toString(),
                          status: proposalList[index].proposalState.toString(),
                          bodyHeader: proposalList[index].demandListName.toString(),
                          headerDate: proposalList[index].proposalValidDate.toString(),
                          bodyList: proposalList[index].productProposals!,
                          bigCardButtons: ButtonWidget(
                            className: className,
                            status: proposalList[index].proposalState.toString(),
                            onPressed: () async {
                              ref.read(proposalIndexProvider.notifier).state=index;
                              await ref.watch(createOrderProvider);
                              Navigator.pop(context);
                            },
                          ),
                          infoBoxWidget: InfoBox(
                            className: className,
                            row1: proposalList[index].updateCounter.toString(),
                            row2: proposalList[index].proposalValidDate.toString(),
                            row3: proposalList[index].proposalValidPeriod.toString(),
                          ),
                          infoWidget: Info(
                            className: className,
                            demandName: proposalList[index].demandListName.toString(),
                            infoRow1: proposalList[index].proposalCreatedAt.toString(),
                            infoRow2: formattedDate(proposalList[index].deliveryDate.toString()),
                            infoRow3: proposalList[index].paymentType.toString(),
                            infoRow4: proposalList[index].paymentDueDate.toString(),
                            infoRow5: proposalList[index].proposalDeliveryTime.toString(),
                            infoRow6: proposalList[index].includeShipmentCost.toString(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );

      },
      loading: () => const LoadingWidget(),
      error: (error, stack) {
        print('Hata: $error');
        print('Stack trace: $stack');
        WidgetsBinding.instance.addPostFrameCallback((_) {});
        return Text('An error occurred: $error');
      },
    );
  }

  int getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 900) {
      return 3;
    } else if (constraints.maxWidth > 550) {
      return 2;
    } else {
      return 1;
    }
  }
}
