import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:db_info/models/yacht.dart';
import '../models/reservation.dart';

const String reservationCollectionRef = "reservations";
const String yachtCollectionRef = "yachts";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _reservationsRef;
  late final CollectionReference _yachtsRef;

  DatabaseService() {
    _reservationsRef = _firestore
        .collection(reservationCollectionRef)
        .withConverter<Reservation>(
            fromFirestore: (snapshots, _) => Reservation.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (reservation, _) => reservation.toJson());

    _yachtsRef = _firestore.collection(yachtCollectionRef).withConverter<Yacht>(
        fromFirestore: (snapshots, _) => Yacht.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (yacht, _) => yacht.toJson());
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

 Stream<QuerySnapshot<Object?>> getYachts(capacity) {
    return _yachtsRef
        .where('capacity', isGreaterThanOrEqualTo: capacity)
        .snapshots();
  }


  void addYacht(Yacht yacht) async {
    _yachtsRef.add(yacht);
  }

  void updateYacht(String yachtId, Reservation yacht) {
    _yachtsRef.doc(yachtId).update(yacht.toJson());
  }

  void deleteYacht(String yachtId) {
    _yachtsRef.doc(yachtId).delete();
  }
}
