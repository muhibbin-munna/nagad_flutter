class Credentials {
  final String merchantID;
  final String merchantPrivateKey;
  final String pgPublicKey;
  final bool isSandbox;


  const Credentials({
    required this.merchantID,
    required this.merchantPrivateKey,
    required this.pgPublicKey,
    required this.isSandbox,
  });
}
