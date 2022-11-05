const String scAddress = "0x7a4c12616F56c6B2c62E05d8513936B26aF1B931";

const scabi = <String>[
  'function addTask(string task)',
  'function getTaskCount() view returns (uint256)',
  'event TasksAdded(address _from, string task)',

  // testing
  'function fetchProposals() view returns (tuple[](uint256 id, address proposalCreator, string proposalName, uint256 createdAt, bool status, uint256 voteFor, uint256 voteAgainst, bool isAccepted))',
  'function fetchCompanyInformation() view returns (tuple(string companyName, address founder, string symbol, uint256 senderShares, uint256 totalShares))',

  // for real functions
  'function generateAccessRequest(address[] accountsRequested)'
];
