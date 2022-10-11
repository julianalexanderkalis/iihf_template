// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/** 
 * @title ToDoList
 * @dev Implements a simple ToDoList as a smart contract structure
 */
contract ToDoList {
        
    // Task structure
    struct Task {
        string task;
        bool isDone;
    }

    mapping (address => Task[]) private Users;
        
    /**
     * @dev Function to add a task to a list
     * @param task string description of the task
     */
    function addTask(string calldata task) external {
        Users[msg.sender].push(Task({
            task:task,
            isDone:false
        }));
    }

    /**
     * @dev Function to get a task from a list
     * @param _taskIndex uint of the task ID in the list
     */
    function getTask(uint _taskIndex) external view returns (Task memory) {
        Task storage task = Users[msg.sender][_taskIndex];
        return task;
    }

    /**
     * @dev Function to update a task status
     * @param _taskIndex uint256 of the task ID in the list
     * @param _status bool of the new status
     */
    function updateStatus(uint256 _taskIndex, bool _status) external {
        Users[msg.sender][_taskIndex].isDone = _status;
    }

    /**
     * @dev Function to delete a task from a list
     * @param _taskIndex uint256 ID of the task to delete
     */
    function deleteTask(uint256 _taskIndex) external {
        delete Users[msg.sender][_taskIndex];
    }

    /**
     * @dev Function to get number of all tasks
     */
    function getTaskCount() external view returns (uint256) {
        return Users[msg.sender].length;
    }
}
