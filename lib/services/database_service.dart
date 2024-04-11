import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_info/models/client.dart';


const String CLIENT_COLLECTON_REF = "clients";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _clientsRef;

  DatabaseService() {
    _clientsRef = _firestore.collection(CLIENT_COLLECTON_REF).withConverter<Client>(
        fromFirestore: (snapshots, _) => Client.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (client, _) => client.toJson());
  }

  Stream<QuerySnapshot> getClients() {
    return _clientsRef.snapshots();
  }

  void addClient(Client client) async {
    _clientsRef.add(client);
  }

  void updateClient(String clientId, Client client) {
    _clientsRef.doc(clientId).update(client.toJson());
  }

  void deleteClient(String clientId) {
    _clientsRef.doc(clientId).delete();
  }
}
