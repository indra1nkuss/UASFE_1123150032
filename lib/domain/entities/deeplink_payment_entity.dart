import 'package:equatable/equatable.dart';

class DeepLinkPaymentEntity extends Equatable {
  final String trxId;
  final String bikeName;
  final double amount;
  final String sourceApp;
  final String? itemsJson;

  const DeepLinkPaymentEntity({
    required this.trxId,
    required this.bikeName,
    required this.amount,
    required this.sourceApp,
    this.itemsJson,
  });

  @override
  List<Object?> get props => [trxId, bikeName, amount, sourceApp, itemsJson];
}
