import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gardenia/controller/store_controller.dart/gardenia_store_controller.dart';
import 'package:gardenia/theme.dart';
import 'package:gardenia/view/storeview/detail_store_page.dart';
import 'package:gardenia/view/common_widget/plant_widget.dart';
import 'package:gardenia/view/storeview/add_plant.dart';
import 'package:get/get.dart';
import 'update_plant.dart';

class StoreProducts extends StatefulWidget {
  const StoreProducts({super.key});

  @override
  State<StoreProducts> createState() => _StoreProductsState();
}

class _StoreProductsState extends State<StoreProducts> {
  GardeniaStoreController controller = Get.put(GardeniaStoreController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: ThemeColor.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Products',
              style: TextStyle(
                color: ThemeColor.blackColor,
                fontWeight: FontWeight.w500,
                fontSize: 24,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.to(const AddPlant());
              },
              icon: const Icon(Icons.add),
              color: ThemeColor.blackColor,
              iconSize: 40,
            )
          ],
        ),
        backgroundColor: ThemeColor.background,
        elevation: 0.0,
      ),
      body: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: size.height,
          child: controller.loadAddProducts.value == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: controller.products.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Slidable(
                      startActionPane: ActionPane(
                        dragDismissible: false,
                        motion: const DrawerMotion(),
                        dismissible: DismissiblePane(onDismissed: () {}),
                        children: [
                          SlidableAction(
                            onPressed: (context) => {
                              controller
                                  .delete(controller.products[index].productId)
                            },
                            backgroundColor:
                                const Color.fromARGB(255, 37, 15, 15),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              controller.editPlantName.text =
                                  controller.products.value[index].plantName;
                              controller.editCategory.text = controller
                                  .products.value[index].plantCategory;
                              controller.editDesc.text =
                                  controller.products.value[index].plantDesc;
                              controller.editPrice.text =
                                  controller.products.value[index].plantPrice;
                              Get.to(UpdatePlant(
                                productImage: controller
                                    .products.value[index].productImage,
                                productId:
                                    controller.products.value[index].productId,
                              ));
                            },
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: PlantWidget(
                        index: index,
                        plant: controller.products[index],
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailStorePage(
                                        plant: controller.products[index],
                                      )));
                        },
                        // ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
