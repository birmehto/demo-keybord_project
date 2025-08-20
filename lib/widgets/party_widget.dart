// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:searchfield/searchfield.dart';

// import '../models/party_response.dart';
// import '../screens/transaction_management/web_sales/web_general_sales_controller.dart';

// class PartyDropdown extends StatefulWidget {
//   final TextEditingController controller;
//   final List<PartyModel> parties;
//   final Function(PartyModel) onSelected;

//   const PartyDropdown({
//     super.key,
//     required this.controller,
//     required this.parties,
//     required this.onSelected,
//   });

//   @override
//   State<PartyDropdown> createState() => _PartyDropdownState();
// }

// class _PartyDropdownState extends State<PartyDropdown> {
//   late FocusNode partyFocus;

//   @override
//   void initState() {
//     super.initState();
//     partyFocus = FocusNode();
//     // expose it so other fields can request focus
//     Get.find<WebGeneralSalesController>().rows.first. = partyFocus;
//   }

//   @override
//   void dispose() {
//     partyFocus.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SearchField<PartyModel>(
//       controller: widget.controller,
//       focusNode: partyFocus,
//       suggestions: widget.parties
//           .map((p) => SearchFieldListItem<PartyModel>(p.aCCNAME ?? '', item: p))
//           .toList(),
//       searchInputDecoration: const SearchInputDecoration(
//         labelText: 'Party Name',
//         border: OutlineInputBorder(),
//       ),
//       onSuggestionTap: (s) {
//         widget.onSelected(s.item!);

//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           final controller = Get.find<WebGeneralSalesController>();
//           if (controller.rows.isNotEmpty &&
//               controller.rows.first.productFocused.canRequestFocus) {
//             FocusScope.of(context).requestFocus(controller.rows.first.productFocused);
//           }
//         });
//       },
//     );
//   }
// }
