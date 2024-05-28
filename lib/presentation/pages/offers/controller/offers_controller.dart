import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:flutx/flutx.dart';
import 'package:get/get.dart';
import 'package:client.gogogo/data/providers/request_provider.dart';
import 'package:client.gogogo/presentation/pages/auth/sign_in/login_ui.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../../../core/helpers/environment.dart';
import '../../../../core/helpers/environment2.dart';

enum ProductViewType { grid, list }

enum RequestStatus {
  nueva,
  aprobada,
  aceptada,
  asignada,
  lista,
  transportando,
  entregada,
  cancelada,
}

class OffersController extends FxController {
  TickerProvider ticker;

  var searchvisible = false.obs;
  OffersController(this.ticker,this.requestId);
  late TextEditingController textsearch = TextEditingController(text: "");
  late TextEditingController obsLista = TextEditingController(text: "");
  //List<Product>? products;
  bool showLoading = true, uiLoading = true;
  var loadrequest = false.obs;
  List<dynamic> bids = [];
  QueryResult? queryResult;
  var lod = false.obs;
  var exeption = false.obs;
  var userid = "".obs;
  List<String> statusfilter = [];
  final String requestId;

  dynamic categoriaList;
  dynamic selectecChoices;
  bool loaodingIncrement = false;
  var nameuser = "".obs;
  final f = DateFormat('yyyy-MM-dd hh:mm aa');
  RequestProvider rp = RequestProvider();

  @override
  Future<void> initState() async {
    super.initState();
    await getsession();
    textsearch = TextEditingController(text: '');
    obsLista = TextEditingController(text: '');
    loadrequest.value = true;
    await getBids();
    await rp.getfeeupdate();
    loadrequest.value = false;
  }

  Future<void> getsession() async {
    var box = await Hive.openBox('SessionFR');
    userid.value = box.get('iduser');
  }

  Future<void> getBids() async {
    loadrequest.value = true;

    try {
      var box = await Hive.openBox('SessionFR');
      var token = box.get('token');

      var token0 = 'Bearer ' + token;

      HttpLink link = HttpLink(Environments.apigogo, defaultHeaders: {
        'apikey': Environments.apiKeyBalanc,
        'authorization': token0,
      });
      final policies = Policies(
        fetch: FetchPolicy.noCache,
      );

      GraphQLClient qlClient = GraphQLClient(
        link: link,
        defaultPolicies: DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
        ),
        cache: GraphQLCache(
          store: HiveStore(),
        ),
      );
      queryResult = await qlClient.query(
        QueryOptions(
            document: gql(
              Environment.findBidsByRequestId,
            ),
            variables: {
              "requestId":requestId,
            }),
      );

      if (queryResult!.data == null && queryResult!.hasException) {
        exeption.value = true;

        //throw queryResult!.exception!;
      } else {
        exeption.value = false;
        bids = queryResult!.data!['findBidsByRequestIdClient']['bids'];
        print(bids);
        //  categoriaList = queryResult!.data!['getrequestsGridData']['categories'];
      }
      loadrequest.value = false;
    } catch (e) {
      loadrequest.value = false;
      exeption.value = true;
      //loadrequest.value = false;
    }
  }

  Future<dynamic> acceptBid(String bidId) async {
    try {
      
      var resp = await rp.acceptBid(bidId);

      if (resp == true) {
        AlertController.show(
          "Completado",
          "Ha aceptado la oferta correctamente",
          TypeAlert.success,
        );

        // ignore: use_build_context_synchronously
        getBids();

        //okok pop
      } else {
        resp != false
            ? AlertController.show(
                "Error al intentar aceptar la oferta",
                resp,
                TypeAlert.warning,
              )
            : AlertController.show(
                "Error ",
                "Error al intentar aceptar la oferta",
                TypeAlert.warning,
              );
      }
      return resp;
    } catch (e) {
      AlertController.show(
        "Error al intentar aceptar la oferta",
        e.toString(),
        TypeAlert.error,
      );
      return false;
    }
  }

  Future<dynamic> rejectBid(String bidId, String reason) async {
    try {
      
      var resp = await rp.rejectBid(bidId, reason);

      if (resp == true) {
        AlertController.show(
          "Completado",
          "Ha rechazado la oferta correctamente",
          TypeAlert.success,
        );

        // ignore: use_build_context_synchronously
        getBids();

        //okok pop
      } else {
        resp != false
            ? AlertController.show(
                "Error al intentar rechazar la oferta",
                resp,
                TypeAlert.warning,
              )
            : AlertController.show(
                "Error ",
                "Error al intentar rechazar la oferta",
                TypeAlert.warning,
              );
      }
      return resp;
    } catch (e) {
      AlertController.show(
        "Error al intentar rechazar la oferta",
        e.toString(),
        TypeAlert.error,
      );
      return false;
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<bool> onWillPop() async {
    return true;
  }

  void logout() async {
    await Hive.deleteBoxFromDisk('SessionFR');
    //  await Hive.deleteBoxFromDisk('BalancSession');

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SignInUI()),
        (Route<dynamic> route) => false);
  }

  void changeselectstatus(int index) {}

  DateTime getdaterequest(task) {
    return DateTime.parse(task["pickUpDate"]).toLocal();
  }

  // ignore: unnecessary_overrides

  @override
  String getTag() {
    return "home_controller";
  }
}
