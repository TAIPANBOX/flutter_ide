import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_visual_builder/editor/properties/property.dart' as prop;
import 'package:flutter_visual_builder/generated/server.pb.dart';
import 'package:ide/ui/home_page.dart';
import 'package:ide/ui/widget_editors/property_changers/numeric_values.dart';


mixin EditorMixin {

  String get id;

  void sendUpdate(String propertyName, prop.Property property) {
    serverClient.fieldUpdates.add(
      FieldUpdate()
        ..id = id
        ..propertyName = propertyName
        ..property = json.encode(property.toMap())
    );
  }
}

class ContainerEditor extends StatelessWidget with EditorMixin{

  ContainerEditor({Key key, this.id}) : super(key: key);

  final String id;

  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Container Editor", style: TextStyle(fontSize: 25),),
          Text("Id: $id"),
          Divider(),
          NumericChangeableTextField(
            name: "Width",
            onUpdate: (it) {
              print("sending $it");
              sendUpdate("width", prop.DoubleProperty(data: it));
            },
          ),
        ],
      ),
    );
  }
}
