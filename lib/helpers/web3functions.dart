import 'package:flutter_web3/flutter_web3.dart';
import 'sc_constants.dart';

class Web3FunctionsForWeb {
  Web3FunctionsForWeb();

  Future<Map<String, bool>> metamask() async {
    if (ethereum != null) {
      try {
        await ethereum!.requestAccount();
        int chain = 0;
        chain = await ethereum!.getChainId();
        if (chain != 4002) {
          ethereum!.walletSwitchChain(4002);
        }

        return <String, bool>{'connected': true};
      } on EthereumUserRejected {
        return <String, bool>{'connected': false};
      }
    }

    return <String, bool>{'connected': false};
  }

  Future<void> generateAccessRequest() async {
    const List<String> abi = scabi;

    const String contractAddress = scAddress;

    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );
    var acc = await ethereum!.requestAccount();
    print(acc[0]);
    await testToken.send('generateAccessRequest', <List<String>>[acc]);
  }

  Future<List<dynamic>> fetchAccessRequests() async {
    const List<String> abi = scabi;

    const String contractAddress = scAddress;
    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    var res = await testToken.call("viewAccessRequests");
    return res;
  }

  Future<List<dynamic>> fetchAccessRequestsScout() async {
    const List<String> abi = scabi;

    const String contractAddress = scAddress;
    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    var res = await testToken.call("viewAccessRequestsScout");
    return res;
  }

  Future<void> acceptAccessRequest(int id) async {
    const List<String> abi = scabi;

    const String contractAddress = scAddress;

    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );
    print("ID:" + id.toString());
    await testToken.send('approveAccessRequest', <int>[id]);
  }
}
