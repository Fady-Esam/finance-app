import 'package:finance_flutter_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';
import 'widgets/transaction_view_body.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;
  bool isSearching = false;
  String? searchText;

  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: isSearching,
        actions: [
          if (isSearching)
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                setState(() {
                  isSearching = false;
                  _searchController.clear();
                  searchText = null;
                });
              },
            ),
        ],
        title:
            isSearching
                ? CustomTextFormField(
                  hintText: S.of(context).search,
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        searchText = null;
                      });
                    },
                  ),
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
                    if (value.isEmpty) {
                      searchText = null;
                    } else {
                      searchText = value;
                    }
                    setState(() {});
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
          if (isSearching) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _searchFocusNode.requestFocus();
            });
          }
        },
        child: const Icon(Icons.search, size: 32, color: Color(0xFF262626)),
      ),
    );
  }
  

}
