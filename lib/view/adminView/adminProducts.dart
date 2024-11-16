import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gardenia/controller/admin_controller/adminController.dart';
import 'package:get/get.dart';
import '../../controller/store_controller.dart/gardenia_store_controller.dart';
import '../../theme.dart';
import '../common_widget/plant_widget.dart';
import '../storeview/add_plant.dart';
import '../storeview/detail_store_page.dart';
import '../storeview/update_plant.dart';

class Adminproducts extends StatelessWidget {
  const Adminproducts({super.key});

  @override
  Widget build(BuildContext context) {
    GardeniaStoreController controller = Get.put(GardeniaStoreController());
    Get.put(AdminController());
    controller.getAllProducts();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const AddPlant());
        },
        backgroundColor: ThemeColor.primary,
        child: const Icon(Icons.add),
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
                              controller.delete(
                                controller.products[index].productId,
                              ),
                              controller.getAllProducts()
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
                              controller.getAllProducts();
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
