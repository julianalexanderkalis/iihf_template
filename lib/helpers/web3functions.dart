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

    const String contractAddress = '0x285ddeAF9e34A8149451E0f6c904C8628bd71441';

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

    const String contractAddress = '0x285ddeAF9e34A8149451E0f6c904C8628bd71441';
    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    var res = await testToken.call("viewAccessRequests");
    return res;
  }

  Future<List<Event>> getTaskCount() async {
    const List<String> abi = scabi;

    const String contractAddress = '0xCb89DeC390c26085E643F72Eab901561E612167F';

    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    final events =
        await testToken.queryFilter(testToken.getFilter('TasksAdded'));

    return events;

    // print("here");
    // final tx = await testToken.send('getTaskCount');
    // tx.hash;

    // final receipt = await tx.wait(); // Wait until transaction complete
    // print(receipt.logs);
  }

  // Future<void> signCustomTransaction() async {
  //   try {
  //     final sig = await provider!.getSigner().signMessage("hehe");
  //     final acc = EthUtils.verifyMessage('hehe', sig);

  //     print(acc);
  //   } on ProviderRpcError catch (_) {
  //     print("did not sign the message");
  //   }
  // }

  Future<List<dynamic>> fetchProposals() async {
    const List<String> abi = scabi;

    const String contractAddress = scAddress;
    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    var res = await testToken.call("fetchProposals");
    return res;
  }

  Future<List<dynamic>> fetchCompanyInformation() async {
    const List<String> abi = scabi;

    const String contractAddress = scAddress;
    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    var res = await testToken.call("fetchCompanyInformation");
    return res;
  }
}
