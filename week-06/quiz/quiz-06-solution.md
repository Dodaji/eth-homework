# Week 6 Quiz: Beacon Chain/Finality + Final Project Integration

**제출 방법:** 이 파일을 복사하여 답변을 작성한 후, PR로 제출하세요.
**평가 기준:** 개념 이해도 중심 - 6주간 배운 내용을 **통합**하여 설명하세요.

---

## 문제 1: Beacon Chain 역할 (객관식)

Beacon Chain의 **주요 역할**은 무엇인가요?

**보기:**
A) 스마트 컨트랙트를 실행하고 상태를 관리한다
B) 검증자를 관리하고 합의를 조정하며 블록 최종성을 결정한다
C) 트랜잭션 수수료를 계산하고 분배한다
D) 사용자의 지갑을 생성하고 개인키를 관리한다

**답변:**
정답: B
Beacon Chain은 이더리움 네트워크 2.0 병합(The Merge) 이후 도입된 "합의 계층(Consensus Layer)"의 코어(심장)입니다. 트랜잭션 자체의 연산이나 스마트 컨트랙트 상태 변경 등 실질적인 코드 처리는 "실행 계층(Execution Layer)"에 전적으로 맡기고, Beacon Chain은 오로지 PoS 환경에서 활성 검증자(Validator) 풀을 관리하고 무작위로 블록 제안자/증명자를 배정하며 트리에 타당성 투표를 조율하여 체인의 최종성(Finality)을 달성하는 합의 도출 역할에만 집중합니다.

---

## 문제 2: Finality 개념 (객관식)

이더리움에서 **Finality(최종성)**가 달성되면 어떤 상태인가요?

**보기:**
A) 트랜잭션이 mempool에 들어간 상태
B) 블록이 체인에 추가되었지만 아직 재조직(reorg)될 수 있는 상태
C) 전체 검증자의 1/3 이상이 슬래싱되지 않는 한 절대 변경되지 않는 상태
D) 24시간이 지나서 트랜잭션이 만료된 상태

**답변:**
정답: C
Finality(최종성)가 달성된 장부는 어떠한 분기(포크) 상황에서도 영구적으로 기록되어 과거로 롤백(Reorg)하거나 뒤집을 수 없는 상태가 됨을 의미합니다. 이더리움 알고리즘(Casper FFG)에서 이를 뒤집으려면 막대한 스테이킹 예치 자산을 보유한 전체 활성 검증자 집단 중 무려 1/3 이상을 희생(슬래싱 당함)시켜야 하므로 공격 비용이 천문학적이 되어 현실적으로 완전 무결함이 보장되는 체계입니다.

---

## 문제 3: 왜 Finality가 중요한가 (단답형)

거래소나 dApp 개발자에게 **Finality**가 왜 중요한가요?

**답변:**
1) 문제 발생: 만약 입금된 트랜잭션이 Finality에 무사히 도달하기 전에 임시로 결제 완료 처리를 내버렸는데, 네트워크가 분기되거나 해킹되어 발생한 재조직(Reorg)으로 인해 해당 입금 트랜잭션 내역만 블록에서 홀연히 사라진다면(고아 블록), 거래소는 존재하지 않는 허위 가상 자산을 고객에게 이미 현금이나 타 코인으로 내어준 셈이 되어 막대한 금전 및 이중 지불 손실 피해를 독박 쓰게 됩니다.
2) 해결 방식: Finality(최종성) 도달 여부만 체인에서 확인하고 나서야 확정 처리 기준을 두면, 어떠한 상황에서도 이미 거래 완료된 내역이 롤백되어 지워질 수학적 위험이 없어지므로 가장 안전하고 안심할 수 있는 확실한 금융 서비스를 구축할 수 있습니다.
3) 소요 시간: 이더리움 메인넷 기준으로 평균적으로 약 2개의 Epoch 턴이 필요하여 대략 12분 ~ 15분이 지나면 완벽한 Finality가 부여됩니다.

---

## 문제 4: 포크 선택 규칙 (단답형)

이더리움은 **Casper FFG**와 **LMD-GHOST** 두 가지 메커니즘을 결합합니다.
각각의 역할은 무엇이며, **왜** 둘 다 필요한가요?

**답변:**
1) Casper FFG의 역할: 긴 호흡 단위(Epoch)마다 마일스톤인 특정 체크포인트(방어선) 블록을 설정하고, 검증자 다수결의 압도적 투표로 장부가 영구적으로 뒤집히지 않게 도장을 찍어주는 **최종성(Finality)** 부여를 담보합니다.
2) LMD-GHOST의 역할: 짧은 대기 호흡 단위(Slot, 12초)마다 수많은 네트워크 분기가 발생했을 때, 가장 최신(Latest)으로 투표 지분 가중치가 쏠린 메인 체인의 머리(Head) 쪽을 임시로나마 신속 정확하게 택하며 쫓아 나가도록 가이드해주는 민첩한 가지치기 나침반 역할을 합니다.
3) 왜 둘 다 필요한가: LMD-GHOST만 쓰면 체인이 빠르게 이어지긴 하겠지만 블록이 영원히 확정(불변성)되지 않아 악의적 체인 재조직 공격/롤백 위협에 벌벌 떨어야 하며, 반대로 Casper FFG만 쓰면 최종성은 달성되겠지만 에포크 주기로 너무 느려서 그 빈틈의 12분간 체인이 어떻게 분기되고 누가 진짜 머리인지 길을 못 찾아 심각한 정체와 대혼란이 오게 됩니다. 이들은 완벽히 상호 보완적인 유기적 결합을 이룹니다.

---

## 문제 5: dApp 아키텍처 설계 (코드/아키텍처 문제)

당신은 "간단한 투표 dApp"을 만들려고 합니다.
다음 요구사항을 읽고 **컴포넌트 구조**와 **사용할 hook**들을 설계하세요.

**답변:**

```
1) 컴포넌트 구조 (어떤 컴포넌트가 필요한가):
- App(최상위 루트)
- WalletConnectHeader (지갑 연결 버튼 전담 헤더)
- VotingDashboard (현재 투표 찬반 수 현황판)
- ActionControls (유저가 찬성/반대 투표를 진행하는 버튼 컨테이너 구역)

2) 각 컴포넌트에서 사용할 wagmi/RainbowKit hook:
   - 지갑 연결: [RainbowKit] ConnectButton
   - 투표 현황 조회: [wagmi] useReadContract (yesVotes, noVotes 각각의 배열 데이터 조회 및 리패치)
   - 투표 실행: [wagmi] useWriteContract (voteYes, voteNo 스마트 컨트랙트 함수 서명)
   - 트랜잭션 확인: [wagmi] useWaitForTransactionReceipt (제출된 트랜잭션 해시를 기반으로 isSuccess 영수증 구독)

3) Provider 계층 구조:
<WagmiProvider>
  <QueryClientProvider>
    <RainbowKitProvider>
      <App />
    </RainbowKitProvider>
  </QueryClientProvider>
</WagmiProvider>
```

**왜 이렇게 설계했나요:**
관심사(디자인과 로직)를 분리해 컴포넌트별로 역할을 나누었습니다.
데이터 흐름 측면에선, 하위에서 `useWriteContract`를 통해 생성된 블록 트랜잭션 영수증을 `useWaitForTransactionReceipt`로 대기하다가 완료(isSuccess)가 감지되면, 현황판 역할을 하는 컨테이너의 `useReadContract`가 갖는 재호출(refetch) 기능만 핀포인트로 트리거 시켜 가장 신속하고 즉각적인 렌더링 피드백이 일어나도록 설계했습니다.

---

## 문제 6: 컨트랙트-프론트엔드 연동 (빈칸 채우기)

다음 코드의 빈칸을 채워서 투표 컨트랙트와 프론트엔드를 연동하세요:

**React 컴포넌트:**
```typescript
import { useReadContract, useWriteContract, useWaitForTransactionReceipt } from 'wagmi';

const votingABI = [ ... ] as const;

function VotingApp() {
  // 찬성 투표 수 조회
  const { data: yesCount, refetch: refetchYes } = useReadContract({
    address: '0x1234...5678',
    abi: votingABI,
    functionName: 'yesVotes',
  });

  // 반대 투표 수 조회
  const { data: noCount, refetch: refetchNo } = useReadContract({
    address: '0x1234...5678',
    abi: votingABI,
    functionName: 'noVotes',
  });

  // 투표 실행
  const { writeContract, data: hash, isPending } = useWriteContract();

  // 트랜잭션 확인 대기
  const { isLoading: isConfirming, isSuccess } = useWaitForTransactionReceipt({
    hash,
  });

  // 트랜잭션 성공 시 데이터 새로고침
  useEffect(() => {
    if (isSuccess) {
      refetchYes();
      refetchNo();
    }
  }, [isSuccess, refetchYes, refetchNo]);

  const handleVoteYes = () => {
    writeContract({
      address: '0x1234...5678',
      abi: votingABI,
      functionName: 'voteYes',
    });
  };

  return (
    <div>
      <h2>현재 투표 현황</h2>
      <p>찬성: {yesCount?.toString()}</p>
      <p>반대: {noCount?.toString()}</p>

      <button onClick={handleVoteYes} disabled={isPending || isConfirming}>
        {isPending ? '서명 중...' : isConfirming ? '확인 중...' : '찬성 투표'}
      </button>

      {isSuccess && <p>투표 완료!</p>}
    </div>
  );
}
```

**데이터 흐름을 설명하세요:**
1) 사용자가 UI에서 "찬성 투표" 핸들러 버튼을 클릭합니다.
2) `writeContract` 훅을 매개로 인코딩된 스마트 컨트랙트 타겟팅 정보가 지갑인 메타마스크에 서명 팝업으로 올라와 대기합니다 (이때 UI는 `isPending` 서명 중... 으로 변화).
3) 사용자 승인 후 트랜잭션이 배포되면 고유 `hash`가 발행되어 `isConfirming` (채굴 확인 중) 상태로 변하고 메인넷 멤풀에서 채굴되기를 기다립니다.
4) 네트워크상에서 채굴되어 블록 편입이 정상 확인되면 영수증이 발행되며 `isSuccess`가 true로 변합니다.
5) 이때 주입해둔 `useEffect`가 트리거 되어 `refetchYes()` 명령을 백그라운드로 실행하게 되고, 최신화된 투표 배열 수치값이 다시금 패칭되어 곧바로 {yesCount?.toString()} DOM 화면에 반영됩니다.

---

## 문제 7: 트랜잭션 흐름 디버깅 (취약점 찾기)

다음 코드에서 **문제점**을 찾고 수정하세요. 사용자가 투표를 해도 화면이 업데이트되지 않습니다.

**1) 발견한 문제점:**
투표(트랜잭션)가 성공적으로 메인넷에서 완료(`isSuccess`)되었더라도, `useReadContract`가 이미 과거 초기에 로딩하고 캐싱해 두었던 오래된 찬성 수량(`voteCount`)을 버리고, 새로고침 해 다시금 능동적으로 외부 서버(API)에 요청해 수치를 업데이트하라는 로직(`refetch` 트리거)이 단 하나도 없어서 캐시된 예전 데이터만 머물기 때문입니다.

**2) 올바른 수정 방법:**
```typescript
// GOOD CODE - 수정된 버전을 작성하세요
import { useEffect } from 'react';

function BrokenVoting() {
  const { data: voteCount, refetch } = useReadContract({
    address: '0x...',
    abi: votingABI,
    functionName: 'yesVotes',
  });

  const { writeContract, data: hash } = useWriteContract();

  const { isSuccess } = useWaitForTransactionReceipt({ hash });

  // 화면 자동 업데이트를 위한 리패치 반영
  useEffect(() => {
    if (isSuccess) {
      refetch();
    }
  }, [isSuccess, refetch]);

  const handleVote = () => {
    writeContract({
      address: '0x...',
      abi: votingABI,
      functionName: 'voteYes',
    });
  };

  return (
    <div>
      <p>찬성: {voteCount?.toString()}</p>
      <button onClick={handleVote}>투표</button>
      {isSuccess && <p>투표 완료!</p>}
    </div>
  );
}
```

**3) refetch가 필요한 이유:**
블록체인 네트워크 데이터 저장소와 웹 프론트엔드 React의 DOM 상태(Client State)는 실시간으로 이어져 웹소켓처럼 반응하는 동기형 데이터가 아닙니다. 블록체인에서 State 장부가 변경되었다면, 클라이언트 측에서 그 사실이 일어났음을 캐치하고 다시 RPC 통신을 열어 "변경된 최신 장부 상태를 패칭(가져오기)해 줘"라고 강제 트리거(`refetch`) 해주어야만 비로소 View 와 동기화의 결속이 일어나기 때문입니다.

---

## 문제 8: Beacon Chain 구조 (다이어그램 해석)

다음 다이어그램은 이더리움의 두 계층 구조를 보여줍니다:

**질문:**

1) **합의 계층(CL)**과 **실행 계층(EL)**의 역할 차이는 무엇인가요?
- CL(합의 계층): 사용자 트랜잭션의 연산은 일절 수행하지 않으며, 단지 검증자(Validator) 노드들을 지휘, 통제하고, 무작위로 블록 제안자/증명자를 할당하여 블록의 합의 모델과 전체 체인의 최종성 보장을 관리하는 블록체인 뼈대의 컨트롤타워 역할입니다.
- EL(실행 계층): 실질적인 사용자들의 트랜잭션 바이트코드를 받아 멤풀에 저장하고, EVM 연산을 통해 스마트 컨트랙트 상태(Balance 등)를 장부 정보상 수정하며 블록을 물리적으로 처리 구축해 내는 실무적 행동 대 역할입니다.

2) **Engine API**를 통해 두 계층이 주고받는 정보는 무엇인가요?
- 검증과 합의에 쓰일 새로운 투표 블록 데이터 덩어리(Payload), 검증된 트랜잭션들의 상태 연산 결과 통보, 합의 계층에서 정한 현재 가장 최신인 체인의 메인 Head(머리) 정보 등 두뇌와 팔다리를 매개하는 가장 긴밀하고 본질적인 동기화 핵심 정보들을 상호 교환합니다.

3) 사용자가 트랜잭션을 전송하면 CL과 EL에서 각각 어떤 일이 일어나나요?
- 먼저 트랜잭션은 EL에 도달해 멤풀에 쌓이게 됩니다. 여기서 EL 내의 EVM은 해당 트랜잭션이 유효한지(가스, 서명 여부) 사전 검사를 마쳐 놓습니다.
- 곧이어 CL에서 정해진 슬롯 타임이 되면 권한을 받은 블록 제안자(Proposer)가 EL에게 "그동안 묶어놓은 유효 트랜잭션들을 넘겨"라고 지시하며 묶음(Payload)을 받아 거푸집을 완성합니다.
- 받아들인 블록은 다시 CL로 넘어가 타 증명자(Attester)들의 광범위한 투표를 통해 안전하게 합의되고, 그제야 장부에 EL이 실질 편입 연산을 모두 정상적으로 마쳐 성공화시킵니다.

---

## 문제 9: Slot/Epoch 관계 (다이어그램 해석)

다음 다이어그램은 Slot과 Epoch의 관계를 보여줍니다:

**질문:**

1) 1 Slot은 몇 초이고, 1 Epoch은 몇 개의 Slot으로 구성되나요?
- 1개의 슬롯은 **12초**의 고정 간격을 가지며, 1개의 큰 에포크 턴은 총 **32개의 슬롯**으로 구성됩니다(따라서 1 에포크는 6.4분이 소요됩니다).

2) **Checkpoint**는 언제 발생하며 어떤 역할을 하나요?
- 각 Epoch가 교체되고 도래하는 가장 첫 번째 시작 지점(마일스톤 블록)에 발생합니다. 여러 에포크가 시작되는 이 검문소를 기준으로 이전에 쌓였던 전체 체인의 히스토리 덩어리를 되짚어 투표하고 영원히 뒤집히지 못하게 확정시키는 FFG 도장(최종성, Finality 트리거 지점) 역할을 합니다. 

3) **Finality**가 달성되려면 몇 Epoch이 필요하고, 시간으로는 약 몇 분인가요?
- 안전하게 Justified를 거쳐 Finalized가 되기까지는 정상적이라면 최소 2개의 완성된 Epoch를 넘겨야 하며, 시간으로는 평균 약 **12분에서 15분** 정도가 전면 소요됩니다.

---

## 문제 10: dApp 전체 아키텍처 (다이어그램 해석)

다음 다이어그램은 dApp의 전체 아키텍처를 보여줍니다:

**질문:**

1) 사용자가 **"투표하기" 버튼**을 클릭하면, UI에서 스마트 컨트랙트까지 데이터가 어떤 경로로 전달되나요?
- React 버튼 UI(onClick) -> 프론트엔드 RainbowKit지갑/WAGMI (`useWriteContract`) -> 지갑 메타마스크 전자 서명 승인 팝업 -> 외부 RPC Provider 파이프라인 (Alchemy/Infura) 발송 -> 해당 RPC의 메인넷 네트워크 Full Node 멤풀 수신 -> 실행 계층의 EVM 트랜잭션 스케줄러를 통한 컨트랙트 바이트코드 연산 및 실제 State 상태 반영 경로로 뻗어 나갑니다.

2) **RPC Provider**(Alchemy/Infura)의 역할은 무엇인가요? 없다면 어떤 문제가 생기나요?
- 방대하고 복잡한 이더리움 블록체인 풀 노드 인프라를 직접 구동하지 않고도, 가볍고 친숙한 HTTP나 WebSocket API 호출만으로 블록체인 네트워크와 데이터를 교환하고 읽고 쓰게 해주는 일종의 "소통 중개/관문 서버" 역할입니다. 이들이 없다면 탈중앙 앱을 서비스하려는 1인 개발자는 자신의 물리적 서버 뒷단에 수십 수백 기가 이상의 진짜 메인 이더리움 노드를 밤낮없이 평생 동기화시켜 운영 비용을 태워놓고 그 서버랑만 직접 연결해야 하는 치명적 허들이 생깁니다.

3) 6주간 배운 내용을 종합하여, 트랜잭션이 **전송 -> 실행 -> 블록 포함 -> Finality**까지 거치는 전체 흐름을 설명하세요.
1. 전송 단계: 프론트(WAGMI)에서 생성한 데이터 명세서(ABI)를 바탕으로 사용자는 Private Key인 메타마스크 등으로 트랜잭션 무결성을 전자 증명 서명(Sign)하여 RPC를 통해 이더리움 실행 계층(EL) 노드의 Mempool 구간에 밀어 발송 대기시킵니다.
2. 실행 단계: 노드(EL)는 이 트랜잭션의 논스(Nonce)나 서명(EC) 보안 로직, 가스 수수료가 합당한지 검열을 마친 뒤 임시 실행하여 State 변화를 예약 및 저장(Effect)해 둡니다. 
3. 블록 포함 단계: 합의 계층(CL) Beacon Chain에 의해 이번 슬롯에 지정 배정된 Proposer가 멤풀 정보를 모아 블록 페이로드를 생성해 세상에 제안하고, 이를 다른 밸리데이터(Attester)들이 LMD-GHOST 규칙 아래에서 검증 및 투표해 지위를 인정받음으로써, 트랜잭션은 결국 정규 가닥을 잡은 가장 무거운 블록 체인 내부에 완전히 포함됩니다(isSuccess 달성). 
4. Finality 단계: 블록에 포함되어 처리가 끝났어도, 그 시간에서 대략 12~15분이 흘러 2번의 큰 턴(2 Epochs) Checkpoint를 넘기며 Casper FFG 알고리즘 판별하에 전체 노드 지분의 절대적 2/3 다수결의 락이 채워지면, 비로소 어떠한 네트워크 롤백(Reorg)이나 재조직 공격에서도 장부가 절대 지워지지 않는 "Finality(절대 확정성/종결)"에 도달하여 긴 여정을 마칩니다.
