const String address = "0x69b2907b11841c3a6d16a26c5C8B96D1FcfBe2ce";

const scabi = <String>[
  'function addTask(string task)',
  'function getTaskCount() view returns (uint256)',
  'event TasksAdded(address _from, string task)',

  // testing
  'function fetchProposals() view returns (tuple[](uint256 id, address proposalCreator, string proposalName, uint256 createdAt, bool status, uint256 voteFor, uint256 voteAgainst, bool isAccepted))',
  'function fetchCompanyInformation() view returns (tuple(string, companyInformation, address founder, string symbol, uint256 senderShares, uint256 totalShares))'
];
