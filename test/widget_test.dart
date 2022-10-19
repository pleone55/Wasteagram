// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wasteagram/main.dart';
import 'package:wasteagram/models/posts.dart';

void main() {
  test('post created', () {
    final date = DateTime.parse('2022-01-01');
    const imageUrl = 'test';
    const quantity = 5;
    const latitude = 34.5677;
    const longitude = 117.3456;

    final Posts post = Posts(date: date, imageUrl: imageUrl, quantity: quantity, latitude: latitude, longitude: longitude);

    expect(post.date, date);
    expect(post.imageUrl, imageUrl);
    expect(post.quantity, quantity);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
  });

  test('post created to map', () {
    final post = Posts();

    post.date = DateTime.parse('2022-01-01');
    post.imageUrl = 'test';
    post.quantity = 5;
    post.latitude = 34.5677;
    post.longitude = 117.3456;

    final postObjTest = {
      'imageUrl': post.imageUrl,
      'date': post.date,
      'quantity': post.quantity,
      'latitude': post.latitude,
      'longitude': post.longitude
    };

    expect(post.toMap(), postObjTest);
  });
}
