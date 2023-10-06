import 'package:flutter/material.dart';

enum PresetColors {
  red(color: Colors.red),
  // pink(color: Colors.pink),
  // purple(color: Colors.purple),
  deepPurple(color: Colors.deepPurple),
  // indigo(color: Colors.indigo),
  blue(color: Colors.blue),
  // lightBlue(color: Colors.lightBlue),
  // cyan(color: Colors.cyan),
  teal(color: Colors.teal),
  // green(color: Colors.green),
  lightGreen(color: Colors.lightGreen),
  // lime(color: Colors.lime),
  yellow(color: Colors.yellow),
  // amber(color: Colors.amber),
  orange(color: Colors.orange),
  // deepOrange(color: Colors.deepOrange),
  brown(color: Colors.brown),
  // blueGrey(color: Colors.blueGrey),
  // grey(color: Colors.grey)
  ;

  final Color color;

  const PresetColors({
    required this.color,
  });
}
