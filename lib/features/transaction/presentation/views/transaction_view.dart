import 'package:finance_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:finance_flutter_app/features/home/data/models/finance_item_model.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

import 'widgets/transaction_view_body.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isSearching = false;
  String? searchText;
  List<FinanceItemModel> filteredFinances = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: isSearching,
        title:
            isSearching
                ? CustomTextFormField(
                  hintText: S.of(context).search,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFFB0BEC5),
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF6200EE),
                      width: 1.2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Colors.greenAccent,
                      width: 1.8,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                )
                : Text(S.of(context).transactions),
      ),
      body: TransactionViewBody(searchedText: searchText),
      floatingActionButton: FloatingActionButton(
        heroTag: 'search',
        backgroundColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          setState(() {
            isSearching = !isSearching;
          });
        },
        child: const Icon(Icons.search, size: 32, color: Color(0xFF262626)),
      ),
    );
  }
}

// TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     hintText: S.of(context).category,
//                     filled: true,
//                     //fillColor: Colors.white,
//                     hintStyle: TextStyle(fontSize: 16),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Color(
//                           0xFFB0BEC5,
//                         ), // Blue-grey 100: good neutral tone
//                         width: 1.2,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Color(0xFF6200EE),
//                         width: 1.2,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                         color: Colors.greenAccent,
//                         width: 1.8,
//                       ),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(color: Colors.red),
//                     ),
//                   ),
//                 )
