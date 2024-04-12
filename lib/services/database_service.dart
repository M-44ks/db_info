import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/reservation.dart';


const String reservationCollectionRef = "reservations";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _reservationsRef;

  DatabaseService() {
    _reservationsRef = _firestore.collection(reservationCollectionRef).withConverter<Reservation>(
        fromFirestore: (snapshots, _) => Reservation.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (reservation, _) => reservation.toJson());
  }

  Stream<QuerySnapshot> getReservations() {
    return _reservationsRef.snapshots();
  }

  void addReservation(Reservation reservation) async {
    _reservationsRef.add(reservation);
  }

  void updateReservation(String reservationId, Reservation reservation) {
    _reservationsRef.doc(reservationId).update(reservation.toJson());
  }

  void deleteReservation(String reservationId) {
    _reservationsRef.doc(reservationId).delete();
  }
}
