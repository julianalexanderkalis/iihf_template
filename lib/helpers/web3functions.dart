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

  Future<void> addTask(String task) async {
    const List<String> abi = scabi;

    const String contractAddress = '0xCb89DeC390c26085E643F72Eab901561E612167F';

    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    await testToken.send('addTask', <String>[task]);
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

  Future<void> fetchProposals() async {
    const List<String> abi = scabi;

    const String contractAddress = '0xd20238542C388795d4eC9F7021569bEd0E73eeae';
    final Contract testToken = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );

    var res = await testToken.call("fetchProposals");
    print(res);
  }
}
