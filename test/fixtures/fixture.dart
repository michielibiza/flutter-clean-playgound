import 'dart:convert';
import 'dart:io';

String fixture(String name) => File('test/fixtures/$name').readAsStringSync(encoding: latin1);

Map<String, dynamic> fixtureJson(String name) => json.decode(fixture(name));
