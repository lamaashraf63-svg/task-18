import 'package:flutter/material.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final Color color;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.color,
  });
}