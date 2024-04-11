import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation.dart';


const String clientCollectionRef = "clients";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _clientsRef;

  DatabaseService() {
    _clientsRef = _firestore.collection(clientCollectionRef).withConverter<Reservation>(
        fromFirestore: (snapshots, _) => Reservation.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (reservation, _) => reservation.toJson());
  }

  Stream<QuerySnapshot> getReservations() {
    return _clientsRef.snapshots();
  }

  void addReservation(Reservation reservation) async {
    _clientsRef.add(reservation);
  }

  void updateReservation(String reservationId, Reservation reservation) {
    _clientsRef.doc(reservationId).update(reservation.toJson());
  }

  void deleteReservation(String reservationId) {
    _clientsRef.doc(reservationId).delete();
  }
}
