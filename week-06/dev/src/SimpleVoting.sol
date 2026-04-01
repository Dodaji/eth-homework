// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @title SimpleVoting
/// @notice 간단한 1인 1표 투표 시스템
contract SimpleVoting {
    // ============================================
    // 상태 변수
    // ============================================
    
    // 투표 후보자 목록
    string[] public candidates;
    
    // 각 후보자가 받은 투표 수
    mapping(uint256 => uint256) public votes;
    
    // 투표 여부 (1인 1표 방지)
    mapping(address => bool) public hasVoted;
    
    // 관리자 주소
    address public owner;

    // ============================================
    // 이벤트
    // ============================================

    event CandidateAdded(uint256 indexed candidateId, string name);
    event Voted(address indexed voter, uint256 indexed candidateId);

    // ============================================
    // 제어자 (Modifiers)
    // ============================================

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // ============================================
    // 초기화
    // ============================================

    constructor(string[] memory _candidates) {
        owner = msg.sender;
        for (uint256 i = 0; i < _candidates.length; i++) {
            candidates.push(_candidates[i]);
            emit CandidateAdded(i, _candidates[i]);
        }
    }

    // ============================================
    // 외부 함수
    // ============================================

    /// @notice 투표하기
    /// @param _candidateId 투표할 후보자 ID (인덱스)
    function vote(uint256 _candidateId) external {
        require(!hasVoted[msg.sender], "You have already voted");
        require(_candidateId < candidates.length, "Invalid candidate ID");

        hasVoted[msg.sender] = true;
        votes[_candidateId] += 1;

        emit Voted(msg.sender, _candidateId);
    }

    /// @notice 새로운 후보자 추가
    /// @param _name 후보자 이름
    function addCandidate(string memory _name) external onlyOwner {
        candidates.push(_name);
        emit CandidateAdded(candidates.length - 1, _name);
    }

    // ============================================
    // View 함수
    // ============================================

    /// @notice 후보자 총 인원 수 반환
    function getCandidatesCount() external view returns (uint256) {
        return candidates.length;
    }

    /// @notice 특정 후보자 정보 및 득표 수 반환
    function getCandidate(uint256 _candidateId) external view returns (string memory name, uint256 voteCount) {
        require(_candidateId < candidates.length, "Invalid candidate ID");
        name = candidates[_candidateId];
        voteCount = votes[_candidateId];
    }
}
