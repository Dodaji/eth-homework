// SPDX-License-Identifier: MIT
pragma solidity >=0.8.26;

import "forge-std/Test.sol";
import "../src/Guestbook.sol";

contract GuestbookTest is Test {
    Guestbook public guestbook;
    address public user1;
    address public user2;

    event EntryAdded(address indexed author, string message, uint256 timestamp);

    function setUp() public {
        guestbook = new Guestbook();
        user1 = address(0x1);
        user2 = address(0x2);
    }

    function testAddEntry() public {
        vm.prank(user1);
        guestbook.addEntry("Hello World");
        
        assertEq(guestbook.getEntriesCount(), 1);
        
        Guestbook.Entry[] memory entries = guestbook.getEntries();
        assertEq(entries.length, 1);
        assertEq(entries[0].author, user1);
        assertEq(entries[0].message, "Hello World");
    }

    function testAddMultipleEntries() public {
        vm.prank(user1);
        guestbook.addEntry("First Message");
        
        vm.prank(user2);
        guestbook.addEntry("Second Message");
        
        assertEq(guestbook.getEntriesCount(), 2);
        assertEq(guestbook.userEntryCount(user1), 1);
        assertEq(guestbook.userEntryCount(user2), 1);
    }

    function testRevertWhenMessageEmpty() public {
        vm.prank(user1);
        vm.expectRevert(Guestbook.MessageEmpty.selector);
        guestbook.addEntry("");
    }

    function testEmitEvent() public {
        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit EntryAdded(user1, "Event Test", block.timestamp);
        guestbook.addEntry("Event Test");
    }

    function testUserEntryCount() public {
        vm.startPrank(user1);
        guestbook.addEntry("Msg 1");
        guestbook.addEntry("Msg 2");
        vm.stopPrank();

        assertEq(guestbook.userEntryCount(user1), 2);
        assertEq(guestbook.userEntryCount(user2), 0);
    }
}
