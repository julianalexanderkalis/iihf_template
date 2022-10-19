// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";

/**
    This code is a template smart contract that does implement functionality for a ToDo list.
    It provides general functions such as adding and deleting tasks, receiving tasks and updating
    the status of a single task.
 */

/**
 * @title SportsAnalysis Smart Contract
 * @dev Implements an access control structure for player-player analysis
 */
contract SportsAnalysis {

    using Counters for Counters.Counter;
    Counters.Counter private _scoutAccessRequestId;

    // AccessRequest structure
    struct ScoutAccessRequest {
        uint id;
        address requestSender;
        address[] accountsRequested;
        bool[] requestAccepted;
        uint256 createdAt;
    }

    mapping(address => uint256[]) public athleteAccessRequests;

    ScoutAccessRequest[] public accessRequest;

    event AccessRequestAdded(address sender, address[] accountsRequested);

    /**
     * @dev Function to generate an accessRequest
     * @param accountsRequested List of addresses than the request sender wants to have access to
     */
    function generateAccessRequest(address[] calldata accountsRequested) public {

        /* create acceptedList as in memory to populate and later update whether athletes have 
        approved the request or not*/
        bool[] memory acceptedList = new bool[](accountsRequested.length);

        for (uint i = 0; i < accountsRequested.length; i++){
            acceptedList[i] = false;

            // add request to athleteAccessRequest
            athleteAccessRequests[accountsRequested[i]].push(_scoutAccessRequestId.current());

        }

        // push new request
        accessRequest.push(ScoutAccessRequest({
            id: _scoutAccessRequestId.current(),
            requestSender: msg.sender,
            accountsRequested: accountsRequested,
            requestAccepted: acceptedList,
            createdAt: block.timestamp
        }));

        // add a log
        emit AccessRequestAdded(msg.sender, accountsRequested);
        // increase id by one
        _scoutAccessRequestId.increment();

    }


    /**
     * @dev Function to list ones accessRequests
     */
    function viewAccessRequests() external view returns(ScoutAccessRequest[] memory list) {
        
        // require that the athlete has current access requests
        require(athleteAccessRequests[msg.sender].length > 0, "This account does not have any requests");

        // build in-memory tuple of access requests
        ScoutAccessRequest[] memory athleteRequests = new ScoutAccessRequest[](athleteAccessRequests[msg.sender].length);

        // loop over ID's and add these access requests to in memory list
        for (uint i = 0; i < athleteAccessRequests[msg.sender].length; i++) {
            uint id = athleteAccessRequests[msg.sender][i];
            athleteRequests[i] = accessRequest[id];
        }
        // return
        return athleteRequests;
    }
}
