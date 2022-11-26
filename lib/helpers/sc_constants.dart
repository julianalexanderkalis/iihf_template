// ignore_for_file: slash_for_doc_comments

// defines the hash address of the Smart Contract on the Blockchain
const String scAddress = "0x889E71466819018C284792646c86558bFe010F7b";

/**
 * Defines the ABI (Application Binary Interface) of the callable functions of the Smart Contract.
 *  Type: List of Strings
 */
const scabi = <String>[
  'function generateAccessRequest(address[] accountsRequested)',
  'function viewAccessRequests() view returns (tuple[](uint256 id, address requestSender, address[] accountsRequested, bool[] requestsAccepted, uint256 createdAt))',
  'function viewAccessRequestsScout() view returns (tuple[](uint256 id, address requestSender, address[] accountsRequested, bool[] requestsAccepted, uint256 createdAt))',
  'function approveAccessRequest(uint256 id)',
  'function returnStats() view returns (tuple[](uint256 a_one, uint256 a_two, uint256 a_three, uint256 a_four, uint256 a_five))'
];

// NOTE: How to write these Strings can be seen from the compiled Smart Contracts generated ABI file puzzled together
