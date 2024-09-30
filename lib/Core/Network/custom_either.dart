class Either<L, R> {
  final L? left;
  final R? right;
  const Either.left(this.left) : right = null;
  const Either.right(this.right) : left = null;

  ///   -----------   Custom Fold Function
  T fold<T>(T Function(L) inCaseLeft, T Function(R) inCaseRight) {
    if (left != null) {
      return inCaseLeft(left as L);
    } else {
      return inCaseRight(right as R);
    }
  }
}
