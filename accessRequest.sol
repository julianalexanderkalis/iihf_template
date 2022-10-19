// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

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

    // AccessRequest structure
    struct ScoutAccessRequest {
        address requestSender;
        address[] accountsRequested;
        bool[] requestAccepted;
        uint256 createdAt;
    }

    ScoutAccessRequest[] private accessRequest;

    event AccessRequestAdded(address sender, address[] accountsRequested);

    /**
     * @dev Function to generate an accessRequest
     * @param accountsRequested List of addresses than the request sender wants to have access to
     */
    function generateAccessRequest(address[] calldata accountsRequested) external {

        bool[] memory acceptedList = new bool[](accountsRequested.length);

        for (uint i = 0; i < accountsRequested.length; i++){
            acceptedList[i] = false;
        }

        accessRequest.push(ScoutAccessRequest({
            requestSender: msg.sender,
            accountsRequested: accountsRequested,
            requestAccepted: acceptedList,
            createdAt: block.timestamp
        }));

        emit AccessRequestAdded(msg.sender, accountsRequested);

    }

    /**
     * @dev Function to get a task from a list
     * @param _taskIndex uint of the task ID in the list
     */
    // function getTask(uint256 _taskIndex) external view returns (Task memory) {
    //     Task storage task = Users[msg.sender][_taskIndex];
    //     return task;
    // }

    /**
     * @dev Function to update a task status
     * @param _taskIndex uint256 of the task ID in the list
     * @param _status bool of the new status
     */
    // function updateStatus(uint256 _taskIndex, bool _status) external {
    //     Users[msg.sender][_taskIndex].isDone = _status;
    // }

    /**
     * @dev Function to delete a task from a list
     * @param _taskIndex uint256 ID of the task to delete
     */
    // function deleteTask(uint256 _taskIndex) external {
    //     delete Users[msg.sender][_taskIndex];
    // }

    /**
     * @dev Function to get number of all tasks
     */
    // function getTaskCount() external view returns (uint256) {
    //     return Users[msg.sender].length;
    // }
}
