import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class CreateEventModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress widget.
  TextEditingController? generatedByController;
  TextEditingController? titleController;
  TextEditingController? descriptionController;
  TextEditingController? locationController;
  TextEditingController? dateController;
  TextEditingController? timeController;
  TextEditingController? ticketCount;
  TextEditingController? id;

  // String? Function(BuildContext, String?)? emailAddressControllerValidator;
  // // State field(s) for password widget.
  // TextEditingController? passwordController;
  // String? Function(BuildContext, String?)? passwordControllerValidator;
  // // State field(s) for emailAddress-Create widget.
  // TextEditingController? emailAddressCreateController;
  // String? Function(BuildContext, String?)?
  //     emailAddressCreateControllerValidator;
  // // State field(s) for password-Create widget.
  // TextEditingController? passwordCreateController;
  // late bool passwordCreateVisibility;
  // String? Function(BuildContext, String?)? passwordCreateControllerValidator;

  // late bool passwordVisibility;
  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    generatedByController?.dispose();
    titleController?.dispose();
    descriptionController?.dispose();
    locationController?.dispose();
    dateController?.dispose();
    timeController?.dispose();
    ticketCount?.dispose();
    id?.dispose();
  }
}
