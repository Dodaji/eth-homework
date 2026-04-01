// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Test.sol";
import "../src/SimpleVoting.sol";

contract SimpleVotingTest is Test {
    SimpleVoting public voting;
    address public owner = address(0x1);
    address public user1 = address(0x2);
    address public user2 = address(0x3);

    function setUp() public {
        // 컨트랙트 배포 시 owner를 지정하여 초기 후보자 셋업
        vm.prank(owner);
        string[] memory initialCandidates = new string[](2);
        initialCandidates[0] = "Alice";
        initialCandidates[1] = "Bob";
        voting = new SimpleVoting(initialCandidates);
    }

    // 1. 초기 셋업 검증 (Checklist 1/5)
    function test_InitialState_CandidatesSettedUp() public view {
        assertEq(voting.getCandidatesCount(), 2);
        
        (string memory name1, uint256 voteCount1) = voting.getCandidate(0);
        assertEq(name1, "Alice");
        assertEq(voteCount1, 0);

        (string memory name2, uint256 voteCount2) = voting.getCandidate(1);
        assertEq(name2, "Bob");
        assertEq(voteCount2, 0);
    }

    // 2. 정상 투표 기능 검증 (Checklist 2/5)
    function test_Vote_IncreasesVoteCount() public {
        vm.prank(user1);
        voting.vote(0); // Alice에게 투표

        (, uint256 voteCount) = voting.getCandidate(0);
        assertEq(voteCount, 1);
        assertTrue(voting.hasVoted(user1));
    }

    // 3. 중복 투표 방지 검증 (Checklist 3/5)
    function test_RevertWhen_VoteMultipleTimes() public {
        vm.prank(user1);
        voting.vote(0); 

        vm.prank(user1);
        vm.expectRevert("You have already voted");
        voting.vote(1); 
    }

    // 4. 유효하지 않은 후보 투표 방지 검증 (Checklist 4/5)
    function test_RevertWhen_VoteInvalidCandidateId() public {
        vm.prank(user2);
        vm.expectRevert("Invalid candidate ID");
        voting.vote(999); 
    }

    // 5. 관리자(Owner)가 새로운 후보를 추가 기능 검증 (Checklist 5/5)
    function test_AddCandidate_ByOwner() public {
        vm.prank(owner);
        voting.addCandidate("Charlie");

        assertEq(voting.getCandidatesCount(), 3);
        (string memory name, ) = voting.getCandidate(2);
        assertEq(name, "Charlie");
    }

    // 6. 비관리자가 후보 추가 시 방어 검증 (추가 테스트)
    function test_RevertWhen_AddCandidateByNonOwner() public {
        vm.prank(user1);
        vm.expectRevert("Only owner can perform this action");
        voting.addCandidate("Hacker");
    }
}
