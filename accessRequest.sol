// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";

/**
    This code is a template smart contract that does implement functionality for the AccessRequest schema.
    It provides general functions such as creating and fetching accessRequest, accepting them or 
    executing them.
 */

/**
 * @title SportsAnalysis Smart Contract
 * @dev Implements an access control structure for player-player analysis
 */
contract SportsAnalysis {
    // Counter variable to use as ID for the scoutAccessRequests
    using Counters for Counters.Counter;
    Counters.Counter private _scoutAccessRequestId;

    // AccessRequest structure
    struct ScoutAccessRequest {
        uint256 id;
        address requestSender;
        address[] accountsRequested;
        bool[] requestAccepted;
        uint256 createdAt;
        string analysisType;
    }

    struct Ranking {
        uint256 a_one;
        uint256 a_two;
        uint256 a_three;
        uint256 a_four;
        uint256 a_five;
    }

    // maps list of ints (IDs of accessRequests) to a users wallet address
    mapping(address => uint256[]) public athleteAccessRequests;

    // map of athlete addresses to number of accessRequests
    mapping(address => uint256) public athleteRanking;

    ScoutAccessRequest[] public accessRequest;

    // event object, basically used for logging, bit unnecessary for the hackathon
    event AccessRequestAdded(address sender, address[] accountsRequested);

    /**
     * @dev Function to generate an accessRequest
     * @param accountsRequested List of addresses than the request sender wants to have access to
     */
    function generateAccessRequest(address[] calldata accountsRequested)
        public
    {
        /* create acceptedList as in memory to populate and later update whether athletes have 
        approved the request or not*/
        bool[] memory acceptedList = new bool[](accountsRequested.length);

        for (uint256 i = 0; i < accountsRequested.length; i++) {
            acceptedList[i] = false;

            // add request to athleteAccessRequest
            athleteAccessRequests[accountsRequested[i]].push(
                _scoutAccessRequestId.current()
            );
        }

        // push new request
        accessRequest.push(
            ScoutAccessRequest({
                id: _scoutAccessRequestId.current(),
                requestSender: msg.sender,
                accountsRequested: accountsRequested,
                requestAccepted: acceptedList,
                createdAt: block.timestamp,
                analysisType: "Match winning goals"
            })
        );

        // add a log
        emit AccessRequestAdded(msg.sender, accountsRequested);
        // increase id by one
        _scoutAccessRequestId.increment();
    }

    /**
     * @dev Function to list ones accessRequests (for a scout)
     */
    function viewAccessRequestsScout()
        external
        view
        returns (ScoutAccessRequest[] memory list)
    {
        uint256 c = 0;
        // loop over the access request list to determine length
        for (uint256 i = 0; i < accessRequest.length; i++) {
            if (accessRequest[i].requestSender == msg.sender) {
                c += 1;
            }
        }

        // build in-memory tuple of access requests
        ScoutAccessRequest[] memory scoutRequests = new ScoutAccessRequest[](c);

        uint256 ic = 0;
        // loop over ID's and add these access requests to in memory list
        for (uint256 i = 0; i < accessRequest.length; i++) {
            if (accessRequest[i].requestSender == msg.sender) {
                scoutRequests[ic] = accessRequest[i];
                ic += 1;
            }
        }
        // return
        return scoutRequests;
    }

    /**
     * @dev Function to list ones accessRequests (for an athlete)
     */
    function viewAccessRequests()
        external
        view
        returns (ScoutAccessRequest[] memory list)
    {
        // require that the athlete has current access requests
        require(
            athleteAccessRequests[msg.sender].length > 0,
            "This account does not have any requests"
        );

        // build in-memory tuple of access requests
        ScoutAccessRequest[] memory athleteRequests = new ScoutAccessRequest[](
            athleteAccessRequests[msg.sender].length
        );

        // loop over ID's and add these access requests to in memory list
        for (uint256 i = 0; i < athleteAccessRequests[msg.sender].length; i++) {
            uint256 id = athleteAccessRequests[msg.sender][i];
            athleteRequests[i] = accessRequest[id];
        }
        // return
        return athleteRequests;
    }

    /**
     * @dev Function to approve accessRequest
     * @param accessRequestId Id value of the accessRequest
     */
    function approveAccessRequest(uint256 accessRequestId) external {
        // loop over addresses in accessRequest.accountsRequested, if match then update requestAccepted
        for (
            uint256 i = 0;
            i < accessRequest[accessRequestId].accountsRequested.length;
            i++
        ) {
            if (
                accessRequest[accessRequestId].accountsRequested[i] ==
                msg.sender
            ) {
                require(
                    accessRequest[accessRequestId].requestAccepted[i] == false,
                    "User already approved access request"
                );
                accessRequest[accessRequestId].requestAccepted[i] = true;
                // increase view count for athlete
                athleteRanking[msg.sender] += 1; 
            }
        }
    }

    /**
     * @dev Function that lets the scout execute the accessRequest -> do the analysis
     */
    function executeAccessRequest(uint256 accessRequestId)
        external
        view
        returns (address[] memory accForAnalysis)
    {
        require(
            block.timestamp >= accessRequest[accessRequestId].createdAt,
            "Athletes can still accept or decline this accessRequest"
        );

        uint256 nAcc = 0;
        for (
            uint256 i = 0;
            i < accessRequest[accessRequestId].requestAccepted.length;
            i++
        ) {
            if (accessRequest[accessRequestId].requestAccepted[i] == true) {
                nAcc += 1;
            }
        }

        address[] memory athletes = new address[](nAcc);
        uint256 counter = 0;
        for (
            uint256 i = 0;
            i < accessRequest[accessRequestId].requestAccepted.length;
            i++
        ) {
            if (accessRequest[accessRequestId].requestAccepted[i] == true) {
                athletes[counter] = accessRequest[accessRequestId]
                    .accountsRequested[i];
                counter += 1;
            }
        }

        return athletes;
    }

    /*
    @dev returns a list of athletes wallets and their rankings
    */
    function returnStats() external view returns (Ranking[] memory list){

        address[] memory athletes = new address[](5);
        athletes[0] = 0x3953aE615bE1bD9379B29e87f4BB2f832C2ffeF2;
        athletes[1] = 0x534b6237D8dCAb93ad08bB40d87F9D2Ec0625c90;
        athletes[2] = 0xB7307f388ebFFFff418E1c381b47F67b57Ed5eD4;
        athletes[3] = 0xFD01FfFF3dCF6f70107cc39a2f4bF4AC7Af82192;
        athletes[4] = 0x1797f7ca4D9478721a68299c640780DD1d20f611;

        uint256[] memory rankings = new uint256[](athletes.length);
        for (uint i = 0; i < athletes.length; i++) {
            rankings[i] = athleteRanking[athletes[i]];
        }
        Ranking[] memory ranking = new Ranking[](1);

        Ranking memory t = Ranking({a_one : rankings[0] + 1,
        a_two : rankings[1]+1, a_three : rankings[2]+1, a_four : rankings[3]+1, a_five : rankings[4]+1});

        ranking[0] = t;
        return ranking;
    }

}

