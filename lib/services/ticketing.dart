import 'package:licenta_main/flutter_flow/flutter_flow_util.dart';
import 'package:licenta_main/models/ticket_model.dart';

class TicketService {
  static Future getTicketObject(ticketEncoded, ticketingContractLinking) async {
    var decodedJSON = jsonDecode(ticketEncoded);
    var ticketID = decodedJSON['ticketId'];
    var ticket = await ticketingContractLinking.getTicket(ticketID);
    var ticketData = {
      "eventTitle": ticket[1],
      "eventSeat": ticket[4],
    };
    return ticketData;
  }

  generateQRCodeString(int ticketId) {
    return jsonEncode({
      "ticketId": ticketId,
      "currentAccount": "0x2a5d56Fa54FFeD7B91CCe84EcB6aAF990254C3b8",
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString()
    });
  }

  static Future<bool> validateTicket(
      String scanData, ticketingContractLinking) async {
    // Decoding the scan data
    var decodedJSON;
    try {
      decodedJSON = jsonDecode(scanData);
    } catch (e) {
      print('Invalid JSON format: $e');
      return false;
    }

    // Checking for necessary fields
    if (!(decodedJSON.containsKey('ticketId') &&
        decodedJSON.containsKey('currentAccount') &&
        decodedJSON.containsKey('timestamp'))) {
      print('Missing necessary fields in the scan data');
      return false;
    }

    var ticketId = decodedJSON['ticketId'];
    var currentAccount = decodedJSON['currentAccount'];
    var timestamp = decodedJSON['timestamp'];

    // You might want to check whether the values are of correct type, for instance:
    if (!(ticketId is int) ||
        !(currentAccount is String) ||
        !(timestamp is String)) {
      print('Invalid data types in the scan data');
      return false;
    }

    // You can also add checks to validate timestamp or other fields, if necessary.

    bool isTicketValid = false;
    var ticketOwner = await ticketingContractLinking.getOwner(ticketId);

    if (ticketOwner.toString().toLowerCase() ==
        currentAccount.toString().toLowerCase()) {
      isTicketValid = true;
    }
    return isTicketValid;
  }
}
