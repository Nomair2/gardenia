import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gardenia/view/adminView/stores.dart';
import 'package:gardenia/view/adminView/storesRequests.dart';
import '../../theme.dart';
import 'adminProducts.dart';

class ManageStoreAccounts extends StatelessWidget {
  const ManageStoreAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                  labelColor: ThemeColor.primary,
                  unselectedLabelColor: ThemeColor.black.withOpacity(0.5),
                  indicatorColor: ThemeColor.primary,
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  dividerColor: ThemeColor.black.withOpacity(0.2),
                  tabs: const [
                    Tab(
                      child: Text(" Stores requests"),
                    ),
                    Tab(
                      child: Text("Stores"),
                    ),
                    Tab(
                      child: Text("Products"),
                    ),
                  ]),
              const SizedBox(height: 20),
              const Expanded(
                child: TabBarView(
                    children: [Storesrequests(), Stores(), Adminproducts()]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
