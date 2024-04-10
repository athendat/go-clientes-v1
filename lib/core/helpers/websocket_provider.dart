import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client.gogogo/core/helpers/environment.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;


/*final webSocketProvider =
    StateNotifierProvider<WebSocketNotifier, WebSocketState>((ref) {
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return WebSocketNotifier(
    keyValueStorageService: keyValueStorageService,
  );
});

/// Notifier
class WebSocketNotifier extends StateNotifier<WebSocketState> {
  final KeyValueStorageService keyValueStorageService;
  late final IO.Socket socket;

  WebSocketNotifier({
    required this.keyValueStorageService,
  }) : super(WebSocketState()) {
    _initSocket();
  }

  void _initSocket() async {
    final token = await keyValueStorageService.getValue<String>('token');

    // Configura el socket con la URL de tu servidor WebSocket
    socket = IO.io(Environment.socketUrl, <String, dynamic>{
      'path': '/api_006/socket',
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'auth': {'token': token},
    });

    // Maneja los eventos del socket según tus necesidades
    socket.onConnect((_) {
      // print('Connection established');
      state = state.copyWith(isSocketConnected: true);
    });

    socket.onDisconnect((_) {
      // print('Connection Disconnection');
      state = state.copyWith(isSocketConnected: false);
    });

    socket.onConnectError((err) => // print(err));
    socket.onError((err) => // print(err.message));
  }

  void connect() {
    // print('connect');
    socket.io.connect(); // Conecta el socket
  }

  void disconnect() {
    socket.disconnect(); // Desconecta el socket
  }

  void sendMessage(String event, dynamic data) {
    socket.emit(event, data); // Envía un mensaje al servidor
  }
}

/// State
class WebSocketState {
  final bool isSocketConnected;

  WebSocketState({
    this.isSocketConnected = false,
  });

  WebSocketState copyWith({
    bool? isSocketConnected,
  }) {
    return WebSocketState(
      isSocketConnected: isSocketConnected ?? this.isSocketConnected,
    );
  }
}*/
