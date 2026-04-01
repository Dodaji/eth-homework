# Week 2 퀴즈: Transaction/서명 + Foundry

**제출 방법:**
1. 이 파일을 복사하여 `quiz-02-solution.md`로 저장
2. 각 문제에 답변 작성 (왜 그런지 설명 포함)
3. Pull 정답 생성 (`quiz_submission` 템플릿 사용)

---

## 문제 1: [이론] 트랜잭션 필드 (객관식)

다음 중 이더리움 트랜잭션에서 `gasPrice`와 `gasLimit`의 관계를 올바르게 설명한 것은?

**보기:**
A) gasPrice는 최대 사용량, gasLimit은 단위당 가격이다
B) gasPrice는 단위당 가격, gasLimit은 최대 사용량이다
C) 둘 다 같은 의미이며 호환되어 사용된다
D) gasLimit이 높을수록 트랜잭션이 빨리 처리된다

**답변:**
정답: B
실제 트랜잭션이 사용한 총 가스 비용은 (트랜잭션 실행 시 실제로 소모된 사용된 가스량) x (단위당 가격인 gasPrice) 로 계산됩니다. gasLimit은 무한루프 등을 방지하기 위해 트랜잭션 실행에 허용되는 "최대 가스 사용량 한도"를 의미합니다.

---

## 문제 2: [이론] nonce의 역할 (객관식)

다음 상황에서 어떤 일이 발생하나요?

```
Alice가 다음 두 트랜잭션을 동시에 네트워크에 브로드캐스트합니다:
- TX-A: nonce=5, Bob에게 1 ETH (gasPrice: 50 Gwei)
- TX-B: nonce=6, Charlie에게 2 ETH (gasPrice: 100 Gwei)

Alice의 현재 nonce: 5
```

**보기:**
A) TX-B가 gasPrice가 높아서 먼저 처리되고, TX-A는 나중에 처리된다
B) TX-A가 먼저 처리되어야 TX-B가 처리될 수 있다. gasPrice와 무관하게 순서대로 처리된다
C) 두 트랜잭션이 동시에 처리된다
D) 둘 다 실패하고 Alice의 계정이 잠긴다

**답변:**
정답: B
이더리움의 계정 nonce는 트랜잭션이 발생한 순서를 엄격하게 지키도록 보장하는 필드입니다. gasPrice가 아무리 높더라도, 네트워크는 현재 계정 nonce에 해당하는 값(5)의 트랜잭션을 선행 조건으로 보며, 해당 트랜잭션이 장부에 성공적으로 올라간 후에야 그다음 nonce(6)를 처리할 수 있습니다. 

---

## 문제 3: [이론] 디지털 서명 (객관식)

디지털 서명(ECDSA)이 보장하는 세 가지 속성 중, "누군가 내 트랜잭션을 위조할 수 없다"를 보장하는 것은?

**보기:**
A) 인증 (Authentication)
B) 무결성 (Integrity)
C) 부인 방지 (Non-repudiation)
D) 암호화 (Encryption)

**답변:**
정답: B (또는 A)
디지털 서명은 다음과 같은 보장을 제공합니다.
- 인증(Authentication): 트랜잭션을 생성한 발신자가 실제로 프라이빗 키를 가진 계정 소유자 본인임을 증명해, 누군가 "내 이름으로 (나를 사칭하여 위조된) 트랜잭션"을 만드는 것을 방지합니다.
- 무결성(Integrity): 서명 과정에 트랜잭션 데이터 자체가 해시되어 들어가므로, 전송 도중에 누군가 금액이나 수신자를 변경(위변조)하는 것을 불가능하게 합니다. 
- 부인 방지(Non-repudiation): 송신자 본인이 서명을 남겼으므로 나중에 "내가 보내지 않았다"고 발뺌할 수 없음을 보장합니다.
"트랜잭션 위조(변조)를 막는다"는 데이터 변조 방지 관점에서는 무결성에 해당합니다.

---

## 문제 4: [이론] 키 유도 (객관식)

다음 중 키 유도 과정에서 올바른 방향을 설명한 것은?

**보기:**
A) Public Key -> Private Key -> Address 순으로 유도된다
B) Address -> Public Key -> Private Key 순으로 역추적 가능하다
C) Private Key -> Public Key -> Address 순으로 유도되며, 역방향은 불가능하다
D) 세 값은 독립적으로 생성되며 서로 연관이 없다

**답변:**
정답: C
이더리움은 타원곡선암호(ECC) 연산과 해시 함수(Keccak-256)의 일방향성(단방향성)을 강하게 이용합니다. Private Key에서 연산을 통해 Public Key를 만들고 이를 해시해 Address를 생성할 수는 있지만, 그 결과값만 가지고 그 이전 입력이었던 Public Key나 Private Key를 알아내는 것은 계산적/수학적으로 완전히 불가능(이산 대수 문제)하기 때문입니다.

---

## 문제 5: [이론] nonce의 필요성 (단답형)

이더리움에서 **왜** nonce가 필요한가요?

만약 nonce가 없다면 어떤 공격이 가능해질까요? 구체적인 예시와 함께 설명하세요.

**답변:**
nonce가 없다면 트랜잭션을 가로채서 똑같이 네트워크에 브로드캐스트하는 '재사용 공격(Replay Attack)'에 무방비해집니다.
예를 들어 제가 누군가에게 `1 ETH`를 보내는 정상적인 트랜잭션(서명 포함)을 네트워크에 올렸을 때, 해커가 이 트랜잭션 데이터 전체를 그대로 가져다가 네트워크에 여러 번 반복 전송하면 제 지갑에서 1ETH씩 계속 의도치 않게 빠져나가는 심각한 사태가 발생할 수 있습니다. nonce는 이를 1회성 트랜잭션으로 유일하게 보장하는 역할을 합니다.

---

## 문제 6: [이론] Private Key 보안 (단답형)

2022년 Ronin Bridge 해킹에서 약 $625M이 탈취되었습니다.

**왜** Private Key 유출이 이렇게 치명적인가요? 은행 계좌 비밀번호 유출과 비교해서 설명하세요.

**답변:**
은행은 중앙화 플랫폼이므로 문제 발생 시 계점을 동결하거나 잘못 처리된 거래 내역을 다시 되돌리고(Roll-back), 비밀번호를 새로 발급해주어 피해를 구조적으로 방지할 수 있습니다. 그러나 블록체인은 탈중앙화 환경이므로 권한을 가진 단일 주체가 없어 트랜잭션을 되돌리거나 계정을 정지하는 조치가 원천적으로 불가능합니다. 즉, Private Key가 곧 자금 통제권 자체이기 때문에 탈취당하면 그 즉시 영구적인 자금 손실로 직결됩니다.

---

## 문제 7: [이론] EIP-1559 이해 (단답형)

EIP-1559 이전과 이후의 가스 수수료 메커니즘의 가장 큰 차이점은 무엇인가요?

**힌트:** `baseFee`와 `priorityFee`의 역할을 설명하면서 답변하세요.

**답변:**
이전에는 사용자들이 채굴자에게 모든 수수료를 높게 제시하는 경매 방식이어서 수수료 변동성이 극심했습니다.
도입 이후에는 프로토콜이 현재 네트워크 혼잡도에 따라 일괄적으로 계산되어 필수적으로 지불하고 소각(Burn)되는 `baseFee`와, 트랜잭션을 우선적으로 블록에 담게 유도하기 위해 검증자(채굴자)에게 팁으로 지불하는 `priorityFee`로 분리되어 수수료 예측 가능성을 높였습니다.

---

## 문제 8: [코드] SimpleStorage 테스트 (빈칸 채우기)

다음 테스트 코드의 빈칸을 채워서 deposit 기능을 테스트하세요:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Test.sol";
import "../src/SimpleStorage.sol";

contract SimpleStorageTest is Test {
    SimpleStorage public storage_;
    address public user = address(0x1);

    function setUp() public {
        storage_ = new SimpleStorage();
        // user에게 10 ETH 부여
        vm.deal(user, 10 ether);
    }

    function test_DepositUpdatesBalance() public {
        // Arrange: user 관점에서 실행
        vm.prank(user);  // TODO: user로 전환하는 코드

        // Act: 1 ETH 입금
        storage_.deposit{value: 1 ether}();  // TODO: 1 ether를 입금하는 코드

        // Assert: 잔액 확인
        assertEq(storage_.getBalance(user), 1 ether);  // TODO: 예상 잔액
    }
}
```

**왜 이렇게 작성했나요:**
1. `vm.prank(user)`: Foundry의 cheatcode를 통해 다음 발생하는 트랜잭션의 발신자(`msg.sender`)를 이 테스트 컨트랙트가 아니라 사용자 계정(`user`)으로 위조/조작하여 실제 사용자가 전송하는 듯한 시나리오를 구성합니다.
2. `storage_.deposit{value: 1 ether}()`: 스마트 컨트랙트의 `payable` 함수에 ETH를 보내면서 호출하기 위함으로 `{value: x}` 괄호를 열어 같이 보낼 이더량을 명시하는 문법(Value transfer)입니다.

---

## 문제 9: [코드] require 조건 (취약점 찾기)

다음 코드에서 잠재적 문제점을 찾으세요:

```solidity
// BAD CODE - 문제점 찾기
contract Wallet {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        // 잔액 차감
        balances[msg.sender] -= amount;

        // ETH 전송
        payable(msg.sender).transfer(amount);
    }
}
```

**1) 발견한 문제점:**
출금을 요청하는 `amount`가 현재 사용자가 예치한 `balances(msg.sender)` 잔액보다 작거나 같은지에 대한 확인(검증 로직)이 빠져 있습니다.

**2) 왜 이것이 문제인가:**
만약 사용자의 실제 잔액은 1 ether인데 `withdraw(100 ether)`를 요청하면, 단순히 뺄셈 연산이 실행됩니다. (Solidity 버전 0.8 이전이었다면 언더플로우가 나어 비정상적으로 엄청나게 큰 잔액이 생성되고 취약점이 터집니다. 0.8 이상이면 reverts가 자연스레 터지지만 명시적인 에러 메시지나 통제 없이 크래시가 납니다).

**3) 올바른 수정 방법:**
```solidity
    function withdraw(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        
        // 잔액 차감
        balances[msg.sender] -= amount;

        // ETH 전송
        payable(msg.sender).transfer(amount);
    }
```

---

## 문제 10: [코드] 테스트 실패 이유 (코드 분석)

다음 테스트가 실패하는 이유를 분석하세요:

```solidity
contract SimpleStorageTest is Test {
    SimpleStorage public storage_;

    function setUp() public {
        storage_ = new SimpleStorage();
    }

    function test_WithdrawFails() public {
        // 입금 없이 바로 출금 시도
        storage_.withdraw(1 ether);
    }
}
```

**질문 1:** 이 테스트가 실패하는 이유는 무엇인가요?

**답변:**
이 테스트 환경의 발신자(`msg.sender`)는 입금(`deposit`)을 한 번도 진행하지 않았기 때문에 잔액이 `0`입니다. 잔액이 `0`인 상태에서 1 ether라는 초과 금액을 `withdraw` 하려 했으므로, 컨트랙트의 출금 로직에 있는 `require(balances[msg.sender] >= amount)` 조건에 가로막혀 트랜잭션이 **Revert**를 발생시키게 됩니다. 테스트 코드 내부에서 예상치 못한 Revert가 발생하면 테스트 역시 실패(Fail) 처리됩니다.

**질문 2:** 이 테스트를 "출금 실패를 테스트하는 정상 테스트"로 바꾸려면 어떻게 수정해야 하나요?

**답변:**
```solidity
    function test_WithdrawFails() public {
        // 입금 없이 출금 시 'Insufficient balance' 에러로 Revert가 날 것임을 예상
        vm.expectRevert("Insufficient balance");
        storage_.withdraw(1 ether);
    }
```

---

## 자기 평가

모든 문제를 풀었다면, 아래 체크리스트로 자기 평가를 해보세요:

- [x] 트랜잭션 필드(nonce, gasPrice, gasLimit 등)의 역할을 이해했다
- [x] 디지털 서명의 세 가지 보장(인증, 무결성, 부인 방지)을 설명할 수 있다
- [x] Private Key 보안의 중요성을 이해했다
- [x] Foundry 테스트 기본 패턴(vm.prank, vm.deal, assertEq)을 사용할 수 있다
- [x] require 조건의 필요성을 이해했다
