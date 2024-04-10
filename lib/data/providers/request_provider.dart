import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:client.gogogo/core/helpers/environment.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';

import '../../core/helpers/environment2.dart';
import '../models/request/request.dart';

class RequestProvider {
  var tokens = "";
  QueryResult? queryResult;
  Future<void> initState() async {
    var box = await Hive.openBox('SessionFR');
    tokens = box.get('token');
  }

  RequestProvider() {
    initState();
  }

  Future<String> createRequest(Solicitud? solicitud) async {
    String requests;
    var box = await Hive.openBox('SessionFR');
    var token = box.get('token');

    QueryResult? queryResult;
    try {
      Map<String, dynamic> variables = {
        "createRequestInput": {
          "pickUpDate": solicitud!.pickUpDate,
          "obs": solicitud.obs,
          "weight":
              solicitud.weight == null ? null : int.parse(solicitud.weight!),
          "volume":
              solicitud.volume == null ? null : int.parse(solicitud.volume!),
          "packages": solicitud.packages == null
              ? null
              : int.parse(solicitud.packages!),
          "value": 0,
          "isImo": solicitud.isImo,
          "isRefrigerated": solicitud.isRefrigerated,
          "originAddress": solicitud.originAddress,
          "destinyAddress": solicitud.destinyAddress,
          "title": solicitud.title,
          "origin": solicitud.origin.toJson(),
          "destiny": solicitud.destiny.toJson(),
          "distance": solicitud.distance
        }
      };
      // print(json.encode(variables));
      //var variabless = json.encode(variables);

      HttpLink link = HttpLink(Environment.apigogo, defaultHeaders: {
        'apikey': Environments.apiKeyBalanc,
        'Authorization': 'Bearer $token'
      });

      final policies = Policies(
        fetch: FetchPolicy.noCache,
      );

      GraphQLClient qlClient = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: null,
        ),
        defaultPolicies: DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
        ),
      );
      queryResult = await qlClient.mutate(
        MutationOptions(
            operationName: 'CreateRequest',
            document: gql(
              Environment.createSolicitud,
            ),
            variables: variables),
      );

      if (queryResult.data == null && queryResult.hasException) {
        var error = queryResult.exception!.graphqlErrors[0].toString();
        if (kDebugMode) {
          // print(error);
        }
        requests = "false";
      } else {
        // exeption.value = false;
        // requests = queryResult.data!['createRequest']['ok'];
        requests = "true";
      }

      return requests;
    } catch (e) {
      if (kDebugMode) {
        // print('Error: $e');
      }
      return "false";
    }
  }

  Future<String> updateRequest(Solicitud? solicitud, String id) async {
    String requests;
    var box = await Hive.openBox('SessionFR');
    var token = box.get('token');

    QueryResult? queryResult;
    try {
      Map<String, dynamic> variables = {
        "updateRequestInput": {
          "id": id,
          "pickUpDate": solicitud!.pickUpDate,
          "obs": solicitud.obs,
          "weight":
              solicitud.weight == null ? null : int.parse(solicitud.weight!),
          "volume":
              solicitud.volume == null ? null : int.parse(solicitud.volume!),
          "packages": solicitud.packages == null
              ? null
              : int.parse(solicitud.packages!),
          "value": 0,
          "isImo": false,
          "isRefrigerated": false,
          "originAddress": solicitud.originAddress,
          "destinyAddress": solicitud.destinyAddress,
          "title": solicitud.title,
          "origin": solicitud.origin.toJson(),
          "destiny": solicitud.destiny.toJson(),
          "distance": solicitud.distance
        }
      };
      // print(json.encode(variables));
      //var variabless = json.encode(variables);

      HttpLink link = HttpLink(Environment.apigogo, defaultHeaders: {
        'apikey': Environments.apiKeyBalanc,
        'Authorization': 'Bearer $token'
      });

      final policies = Policies(
        fetch: FetchPolicy.noCache,
      );

      GraphQLClient qlClient = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: null,
        ),
        defaultPolicies: DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
        ),
      );
      queryResult = await qlClient.mutate(
        MutationOptions(
            operationName: 'UpdateRequest',
            document: gql(
              Environment.updateSolicitud,
            ),
            variables: variables),
      );

      if (queryResult.data == null && queryResult.hasException) {
        var error = queryResult.exception!.graphqlErrors[0].toString();
        if (kDebugMode) {
          // print(error);
        }
        requests = "false";
      } else {
        // exeption.value = false;
        // requests = queryResult.data!['createRequest']['ok'];
        requests = "true";
      }

      return requests;
    } catch (e) {
      if (kDebugMode) {
        // print('Error: $e');
      }
      return "false";
    }
  }

  Future<dynamic> getrequestsbyId(String id) async {
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
              Environment.getsolicitudesByClientid,
            ),
            variables: {
              "id": id,
            }),
      );

      if (queryResult!.data == null && queryResult!.hasException) {
        // var error = queryResult!.exception!.graphqlErrors[0].toString();
        if (kDebugMode) {
          // print(queryResult!.exception!.graphqlErrors[0]);
        }
        return "Error Server";
        // exeption.value = true;
      } else {
        //  exeption.value = false;
        var request = queryResult!.data!['findRequestByIdByClient']['request'];
        return request;
      }
    } catch (e) {
      return "Error Server";
    }
  }

  Future<dynamic> requestmarkLista(
      String requestId, String obs, String date) async {
    dynamic requests;
    var box = await Hive.openBox('SessionFR');
    var token = box.get('token');

    QueryResult? queryResult;
    try {
      Map<String, dynamic> variables = {
        "setRequestStatusInput": {
          "requestId": requestId,
          "pickUpDate": date,
          "obs": obs
        }
      };
      // print(json.encode(variables));
      //var variabless = json.encode(variables);

      HttpLink link = HttpLink(Environment.apigogo, defaultHeaders: {
        'apikey': Environments.apiKeyBalanc,
        'Authorization': 'Bearer $token'
      });

      final policies = Policies(
        fetch: FetchPolicy.noCache,
      );

      GraphQLClient qlClient = GraphQLClient(
        link: link,
        cache: GraphQLCache(
          store: null,
        ),
        defaultPolicies: DefaultPolicies(
          watchQuery: policies,
          query: policies,
          mutate: policies,
        ),
      );
      queryResult = await qlClient.mutate(
        MutationOptions(
            document: gql(
              Environment.requestmarkLista,
            ),
            variables: variables),
      );

      if (queryResult.data == null && queryResult.hasException) {
        dynamic error =
            queryResult.exception!.graphqlErrors[0].message.toString();
        if (kDebugMode) {
          // print(error);
        }
        requests = error;
      } else {
        // exeption.value = false;
        // requests = queryResult.data!['createRequest']['ok'];
        requests = true;
      }

      return requests;
    } catch (e) {
      if (kDebugMode) {
        // print('Error: $e');
      }
      return false;
    }
  }

//--------------------Obtiene la tarifa por kilometraje actualizada--------------------------------
  Future<dynamic> getfeeupdate() async {
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
              Environment.getfeeupdate,
            ),
            variables: {}),
      );

      if (queryResult!.data == null && queryResult!.hasException) {
        // var error = queryResult!.exception!.graphqlErrors[0].toString();
        if (kDebugMode) {
          // print(queryResult!.exception!.graphqlErrors[0]);
        }
        return "Error Server";
        // exeption.value = true;
      } else {
        //  exeption.value = false;
        var request = queryResult!.data!['findCurrentServiceFee']['serviceFee'];
        box.put('fee', request['fee'].toString());
        return request;
      }
    } catch (e) {
      return "Error Server";
    }
  }
}
