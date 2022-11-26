// ignore_for_file: slash_for_doc_comments

import 'package:flutter_web3/flutter_web3.dart';
import 'sc_constants.dart';

// Defines new 'class' object for everything Web3 (e.g. BLockchain) related
class Web3FunctionsForWeb {
  Web3FunctionsForWeb();

  /**
   * Asynchronous function that connects to a users wallet.
   * 
   * Returns: Future value of a Map of String to bool variables
   * 
   */
  Future<Map<String, bool>> metamask() async {
    // checks if ethereum object is present in browser environment
    if (ethereum != null) {
      try {
        // awaits (e.g. waits for user action and continue only afterwards) the users connection of the wallet to the App
        await ethereum!.requestAccount();
        // initializes chain ID as 0
        int chain = 0;
        // Gets current chain the user has selected in his Metamask browser extension
        chain = await ethereum!.getChainId();
        // Checks if chain is equal to the Fantom testnet ID
        if (chain != 96970) {
          // switch chain to desired chain
          ethereum!.walletSwitchChain(96970);
        }

        return <String, bool>{'connected': true};
      } on EthereumUserRejected {
        // if user rejected to connect his wallet to the app
        return <String, bool>{'connected': false};
      }
    }
    // if ethereum object not found in environment
    return <String, bool>{'connected': false};
  }

  /**
   * Asynchronous function that generates an access request.
   * 
   * Returns nothing (void, e.g. empty)
   */
  Future<void> generateAccessRequest() async {
    // loads Smart Contracs ABI from 'sc_constants'
    const List<String> abi = scabi;
    // loads contract address from 'sc_constants'
    const String contractAddress = scAddress;
    // initialize new contract object
    final Contract iihfContract = Contract(
      contractAddress,
      abi,
      provider!.getSigner(), // connect to the Signer object
    );
    var acc = await ethereum!.requestAccount();
    // print(acc[0]); just for debug
    /** 
     * Execute the 'generateAccessRequest' function on the Smart Contract
     *  Inputs:
     *    List of strings
     *      Here: users account
     */
    await iihfContract.send('generateAccessRequest', <List<String>>[
      [
        "0x3953aE615bE1bD9379B29e87f4BB2f832C2ffeF2", // wallet of Simon Knak
        "0x534b6237D8dCAb93ad08bB40d87F9D2Ec0625c90", // wallet of Emil Andrae
        acc[0] // my wallet
      ]
    ]);
  }

  /**
   * Asynchronous function that fetches all available access requests for the sender athlete (maybe rename that)
   * 
   * Returns:
   *  List of 'dynamic' objects
   */
  Future<List<dynamic>> fetchAccessRequests() async {
    // loads Smart Contracs ABI from 'sc_constants'
    const List<String> abi = scabi;
    // loads contract address from 'sc_constants'
    const String contractAddress = scAddress;
    // initialize new contract object
    final Contract iihfContract = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );
    // returns the results of the contract call
    return await iihfContract.call("viewAccessRequests");
  }

/**
 * Asynchronous function that fetches all available access requests for the sender scout
 */
  Future<List<dynamic>> fetchAccessRequestsScout() async {
    // loads Smart Contracs ABI from 'sc_constants'
    const List<String> abi = scabi;
    // loads contract address from 'sc_constants'
    const String contractAddress = scAddress;
    // initialize new contract object
    final Contract iihfContract = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );
    // returns the results of the contract call
    return await iihfContract.call("viewAccessRequestsScout");
  }

/**
 * Asynchronous function that accepts an access Request
 *  Inputs:
 *    id, Type: int
 *  Returns nothing, maybe change that to bool for nice display message or so...
 */
  Future<void> acceptAccessRequest(int id) async {
    // loads Smart Contracs ABI from 'sc_constants'
    const List<String> abi = scabi;
    // loads contract address from 'sc_constants'
    const String contractAddress = scAddress;
    // initialize new contract object
    final Contract iihfContract = Contract(
      contractAddress,
      abi,
      provider!.getSigner(),
    );
    // print("ID:" + id.toString());
    await iihfContract.send('approveAccessRequest', <int>[id]);
  }

  /**
   * Asynchronous function that returns view statistics.
   * 
   * Returns list of uint256
   */
  Future<List<dynamic>> getStats() async {
    // loads Smart Contracs ABI from 'sc_constants'
    const List<String> abi = scabi;
    // loads contract address from 'sc_constants'
    const String contractAddress = scAddress;
    // initialize new contract object
    final Contract iihfContract = Contract(
      contractAddress,
      abi,
      provider!.getSigner(), // connect to the Signer object
    );

    return await iihfContract.call('returnStats');
  }
}
