import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class OfferModel {
  String name;
  String deliveryDate;
  int validDays;
  int? selectedDay;
  int? selectedDay2;

  OfferModel()
      : name = '',
        deliveryDate = '',
        validDays = 0;
}

final offerModelProvider = Provider<OfferModel>((ref) => OfferModel());

class createProposalViewContent extends ConsumerWidget {
  final String topic;
  createProposalViewContent({this.topic = ' ', Key? key}) : super(key: key);
  final _dropdownMaxValue = 150;
  final TextEditingController _topic = TextEditingController();
  final TextEditingController _deliveryDate = TextEditingController();
  final TextEditingController _validDays = TextEditingController();
  int? _selectedDay;
  int? _selectedDay2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offerModel = ref.read(offerModelProvider);

    return Container(
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: const UnderlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              hintText: 'Konu',
            ),
            initialValue: topic,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen konu giriniz.';
              }
              return null;
            },
            onChanged: (value) {
              offerModel.name = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _deliveryDate,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: const UnderlineInputBorder(),
                    labelText: 'tarih giriniz',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      _deliveryDate.text =
                          formattedDate; // <- Bu satır eklenmeli
                      offerModel.deliveryDate = formattedDate;
                    } else {}
                  },
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _validDays,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    border: const UnderlineInputBorder(),
                    labelText: 'Son teklif verme tarihini giriniz',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      DateTime currentDate = DateTime.now();
                      int differenceInDays =
                          pickedDate.difference(currentDate).inDays;
                      differenceInDays = differenceInDays + 1;
                      debugPrint(differenceInDays.toString());


                      _validDays.text = pickedDate.toString();
                      offerModel.validDays = differenceInDays;
                    } else {}
                  },
                ),
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 3,
                  child: Text('Termin Tarihi',
                      style: Theme.of(context).textTheme.bodySmall)),
              const Spacer(),
              Expanded(
                  flex: 3,
                  child: Text('Son Teklif Verme Süresi',
                      style: Theme.of(context).textTheme.bodySmall)),
              const Spacer(
                flex: 2,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: 'Gun giriniz',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  isExpanded: true,
                  alignment: Alignment.centerRight,
                  value: offerModel.selectedDay,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  onChanged: (int? value) {
                    offerModel.selectedDay = value;
                  },
                  items: <int>[for (var i = 0; i <= _dropdownMaxValue; i++) i]
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        hintText: 'Gun giriniz',
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(8))),
                    isExpanded: true,
                    alignment: Alignment.centerRight,
                    value: offerModel.selectedDay2,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    onChanged: (int? value) {
                      offerModel.selectedDay2 = value;
                    },
                    items: <int>[for (var i = 0; i <= _dropdownMaxValue; i++) i]
                        .map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Spacer(
                flex: 3,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  flex: 3,
                  child: Text('Ödeme Vadesi',
                      style: Theme.of(context).textTheme.bodySmall)),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                  flex: 3,
                  child: Text('Nakliye Ödemesi',
                      style: Theme.of(context).textTheme.bodySmall)),
              const Spacer(
                flex: 2,
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
