import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Payment extends StatefulWidget {
  final String? price;
  final orderID;

  Payment({required this.price, super.key, required this.orderID});

  @override
  State<Payment> createState() => _PaymentState();
}

enum PaymentMethos { cash, credit, apple, wallet }

class _PaymentState extends State<Payment> {
  PaymentMethos? payment;
  late TextEditingController cardNumber = TextEditingController();

  late TextEditingController expiryDate = TextEditingController();

  late TextEditingController cvv = TextEditingController();

  late TextEditingController cardHolderName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Payment",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "Select Payment Method",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blue.shade200),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(color: Colors.blue.shade100, width: 2),
                        top: BorderSide(color: Colors.blue.shade100, width: 2),
                        left: BorderSide(color: Colors.blue.shade100, width: 2),
                        bottom:
                            BorderSide(color: Colors.blue.shade100, width: 2))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.monetization_on_sharp,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Cash",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Radio<PaymentMethos>(
                          activeColor: Colors.black,
                          value: PaymentMethos.cash,
                          groupValue: payment,
                          onChanged: (PaymentMethos? value) {
                            setState(() {
                              payment = value;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(color: Colors.blue.shade100, width: 2),
                        top: BorderSide(color: Colors.blue.shade100, width: 2),
                        left: BorderSide(color: Colors.blue.shade100, width: 2),
                        bottom:
                            BorderSide(color: Colors.blue.shade100, width: 2))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wallet,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "My Wallet",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Radio<PaymentMethos>(
                          activeColor: Colors.black,
                          value: PaymentMethos.wallet,
                          groupValue: payment,
                          onChanged: (PaymentMethos? value) {
                            setState(() {
                              payment = value;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: 350,
                  decoration: BoxDecoration(
                      border: Border(
                          right:
                              BorderSide(color: Colors.blue.shade100, width: 2),
                          top:
                              BorderSide(color: Colors.blue.shade100, width: 2),
                          left:
                              BorderSide(color: Colors.blue.shade100, width: 2),
                          bottom: BorderSide(
                              color: Colors.blue.shade100, width: 2))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.credit_card,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "Credit/Debit Card",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        Radio<PaymentMethos>(
                            activeColor: Colors.black,
                            value: PaymentMethos.credit,
                            groupValue: payment,
                            onChanged: (PaymentMethos? value) {
                              setState(() {
                                payment = value;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                decoration: BoxDecoration(
                    border: Border(
                        right:
                            BorderSide(color: Colors.blue.shade100, width: 2),
                        top: BorderSide(color: Colors.blue.shade100, width: 2),
                        left: BorderSide(color: Colors.blue.shade100, width: 2),
                        bottom:
                            BorderSide(color: Colors.blue.shade100, width: 2))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.apple,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Apple Pay",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Radio<PaymentMethos>(
                          activeColor: Colors.black,
                          value: PaymentMethos.apple,
                          groupValue: payment,
                          onChanged: (PaymentMethos? value) {
                            setState(() {
                              payment = value;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Total                          ${widget.price}",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 100,
              ),
              MaterialButton(
                  height: 50,
                  color: Colors.red,
                  child: const Text(
                    "Pay",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if (payment != null) {
                      payment == PaymentMethos.credit
                          ? showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Container(
                                    color: Colors.white,
                                    height: 350,
                                    width: 500,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 180),
                                              child: Text(
                                                "Card Number",
                                                style: TextStyle(fontSize: 16),
                                              )),
                                          TextField(
                                            controller: cardNumber,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: Text(
                                                            "Expiry date",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          )),
                                                      TextField(
                                                        controller: expiryDate,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      const Text(
                                                        "CVV",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      SizedBox(
                                                          height: 50,
                                                          child: TextField(
                                                            controller: cvv,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(right: 150),
                                            child: Text(
                                              "Card holder name",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: SizedBox(
                                                height: 50,
                                                child: TextField(
                                                  controller: cardHolderName,
                                                )),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          MaterialButton(
                                            onPressed: () async {
                                              Get.back();
                                              await FirebaseFirestore.instance
                                                  .collection("order")
                                                  .doc(widget.orderID)
                                                  .update({"status": "paied"});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "The payment was completed successfully")));
                                            },
                                            color: const Color(0xFF3498C8),
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : {
                              await FirebaseFirestore.instance
                                  .collection("order")
                                  .doc(widget.orderID)
                                  .update({"status": "paied"}),
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "The payment was completed successfully")))
                            };
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Payment failed")));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
