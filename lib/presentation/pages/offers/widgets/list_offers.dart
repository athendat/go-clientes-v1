import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:client.gogogo/presentation/components/loading_effect.dart';
import 'package:client.gogogo/presentation/pages/home/controller/home_controller.dart';
import '../controller/offers_controller.dart';

import '../../request/screen/request_page.dart';

class Offer {
  final int no;
  final DateTime date;
  final double ammount;
  final String status;
  final int requestNo;
  final String merchant;

  Offer(this.no,this.date,this.ammount,this.status,this.requestNo,this.merchant);
}

class ListClientOffers extends StatelessWidget {
  const ListClientOffers({
    super.key,
    required this.offers,
    required this.theme,
    required this.controller,
  });

  final List<dynamic> offers;
  final ThemeData theme;
  final OffersController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        //physics: const NeverScrollableScrollPhysics(),
        
        shrinkWrap: true,
        padding: FxSpacing.only(bottom: 20),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          var loaodingIncrement = false.obs;
          return GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.background,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  FxContainer(
                    // color: theme.dialogBackgroundColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    height: 48,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        FxText.bodySmall(
                          offers[index]["merchant"]["name"]??"Sin Nombre"
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        FxText.bodySmall(
                          '',
                        ),
                        const Spacer(),
                        FxText.bodyMedium(offers[index]["status"].toUpperCase(),
                            fontWeight: 800,
                            color: offers[index]["status"] == "rechazada"
                                    ? Colors.red
                                    : offers[index]["status"] == "aceptada"
                                            ? Colors.green
                                            :Color.fromARGB(255, 208, 211, 31)
                                                   ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ),
                  Row(
                  children:[
                    FxSpacing.width(20),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [FxText.bodySmall(
                      'Importe',
                    ),
                    FxText.bodySmall(
                      offers[index]["price"].toStringAsFixed(2),
                      fontWeight: 300,
                    ),]
                  ),
                  FxSpacing.width(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      FxText.bodySmall(
                      'Fecha de Recogida',
                    ),
                      FxSpacing.width(10),
                      FxText.bodySmall(
                        controller.f.format(
                          DateTime.parse(offers[index]["pickUpDate"]),
                        ),
                        fontWeight: 300,
                      ),],
                  ),],
                  ),
                  FxSpacing.height(5),
                  offers[index]["status"] == "rechazada" && offers[index]["rejectObs"]!=""?
                  Row(children:[
                    FxSpacing.width(20),
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     FxText.bodySmall(
                      'Rechazada por:',
                    ),
                      FxText.bodySmall(
                      offers[index]["rejectObs"]??"",
                      fontWeight: 300,
                    ),
                  
                  ],
                  )],)
                  :SizedBox.shrink(),
                  FxSpacing.height(5),
                   offers[index]["status"] == "nueva"?
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                        ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController reasonController = TextEditingController();

                          return AlertDialog(
                            title: Text('Ayudenos a entender sus razones'),
                            content: TextField(
                              controller: reasonController, // Controlador del campo de texto
                              decoration: InputDecoration(hintText: 'Ingrese el motivo'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  dynamic result = controller.rejectBid(offers[index]["id"],reasonController.text);
                                  print(result);
                                  Navigator.of(context).pop();
                                },
                                child: Text('Aceptar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Rechazar',style: TextStyle(color: const Color.fromARGB(255, 252, 253, 253),),),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                        onPressed: () {
                          controller.acceptBid(offers[index]["id"]);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),
                        child: Text('Aceptar',style: TextStyle(color: const Color.fromARGB(255, 252, 253, 253),),),
                      ),
                    ],
                  )
                  :SizedBox.shrink(),
                ],
              ),
            ),
          );
        });
  }
}
