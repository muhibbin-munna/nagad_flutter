class NagadCredentials {
  final String merchantID;
  final String merchantPrivateKey;
  final String pgPublicKey;
  final bool isSandbox;


  const NagadCredentials({
    required this.merchantID,
    required this.merchantPrivateKey,
    required this.pgPublicKey,
    required this.isSandbox,
  });
}
