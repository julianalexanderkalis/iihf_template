// ignore_for_file: slash_for_doc_comments

// defines the hash address of the Smart Contract on the Blockchain
const String scAddress = "0x3F39D2f84db3947DDD7EfbFcEaD7015B49950577";

/**
 * Defines the ABI (Application Binary Interface) of the callable functions of the Smart Contract.
 *  Type: List of Strings
 */
const scabi = <String>[
  'function generateAccessRequest(address[] accountsRequested)',
  'function viewAccessRequests() view returns (tuple[](uint256 id, address requestSender, address[] accountsRequested, bool[] requestsAccepted, uint256 createdAt))',
  'function viewAccessRequestsScout() view returns (tuple[](uint256 id, address requestSender, address[] accountsRequested, bool[] requestsAccepted, uint256 createdAt))',
  'function approveAccessRequest(uint256 id)'
];

// NOTE: How to write these Strings can be seen from the compiled Smart Contracts generated ABI file puzzled together
