const String scAddress = "0xe6d580536FdBAb818bF6b71bFDa905f80A34dcAb";

const scabi = <String>[
  // for real functions
  'function generateAccessRequest(address[] accountsRequested)',
  'function viewAccessRequests() view returns (tuple[](uint256 id, address requestSender, address[] accountsRequested, bool[] requestsAccepted, uint256 createdAt))',
  'function viewAccessRequestsScout() view returns (tuple[](uint256 id, address requestSender, address[] accountsRequested, bool[] requestsAccepted, uint256 createdAt))',
  'function approveAccessRequest(uint256 id)'
];
