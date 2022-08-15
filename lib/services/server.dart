import 'dart:convert';
import 'dart:io';

import 'package:memri_web/model/user_commits.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;

/// HTTP server function to broadcast user information
Future<void> httpServer(List<User> userList) async {
  const port = 5001;
  final router = shelf_router.Router()
    ..get('/api', (Request req) {
      return Response.ok(
          userList.map((e) => jsonEncode(e.toMap())).toList().toString(),
          headers: {
            'Access-Control-Allow-Origin': 'http://localhost:8000',
            'Access-Control-Allow-Methods': 'GET, DELETE, HEAD, OPTIONS'
          });
    });

  final cascade = Cascade().add(router);

  final server = await shelf_io.serve(
      logRequests().addHandler(cascade.handler), InternetAddress.anyIPv4, port);

  String url = 'http://${server.address.host}:${server.port}';
  print('Serving at $url');
}
