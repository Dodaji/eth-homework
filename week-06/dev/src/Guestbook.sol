// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;

contract Guestbook {
    struct Entry {
        address author;
        string message;
        uint256 timestamp;
    }

    Entry[] public entries;
    mapping(address => uint256) public userEntryCount;

    event EntryAdded(address indexed author, string message, uint256 timestamp);

    error MessageEmpty();

    function addEntry(string calldata _message) external {
        if (bytes(_message).length == 0) {
            revert MessageEmpty();
        }

        entries.push(Entry({
            author: msg.sender,
            message: _message,
            timestamp: block.timestamp
        }));

        userEntryCount[msg.sender]++;

        emit EntryAdded(msg.sender, _message, block.timestamp);
    }

    function getEntries() external view returns (Entry[] memory) {
        return entries;
    }

    function getEntriesCount() external view returns (uint256) {
        return entries.length;
    }
}
