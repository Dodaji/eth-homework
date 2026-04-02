// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Script.sol";
import "../src/SimpleVoting.sol";

/// @title DeploySimpleVoting
/// @notice Sepolia 테스트넷 배포 스크립트
/// @dev 실행 전 .env 파일에 PRIVATE_KEY, SEPOLIA_RPC_URL 를 설정하세요.
///      forge script week-06/dev/script/DeploySimpleVoting.s.sol \
///        --rpc-url $SEPOLIA_RPC_URL \
///        --private-key $PRIVATE_KEY \
///        --broadcast -vvvv
contract DeploySimpleVoting is Script {
    function run() external {
        // 초기 후보자 목록 설정
        string[] memory initialCandidates = new string[](3);
        initialCandidates[0] = "Alice";
        initialCandidates[1] = "Bob";
        initialCandidates[2] = "Charlie";

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        SimpleVoting voting = new SimpleVoting(initialCandidates);

        vm.stopBroadcast();

        console.log("SimpleVoting deployed at:", address(voting));
        console.log("Initial candidates: Alice, Bob, Charlie");
        console.log("Owner:", vm.addr(deployerPrivateKey));
    }
}
