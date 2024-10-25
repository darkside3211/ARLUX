class OrderStatusCount {
  final int totalOrders;
  final int toPay;
  final int toShip;
  final int toReceive;
  final int toRate;

  const OrderStatusCount({
    this.totalOrders = 0,
    this.toPay = 0,
    this.toShip = 0,
    this.toReceive = 0,
    this.toRate = 0,
  });

  // Create a copy with modified values
  OrderStatusCount copyWith({
    int? totalOrders,
    int? toPay,
    int? toShip,
    int? toReceive,
    int? toRate,
  }) {
    return OrderStatusCount(
      totalOrders: totalOrders ?? this.totalOrders,
      toPay: toPay ?? this.toPay,
      toShip: toShip ?? this.toShip,
      toReceive: toReceive ?? this.toReceive,
      toRate: toRate ?? this.toRate,
    );
  }
}
