# SimpleVoting - 간단한 1인 1표 투표 시스템

## 프로젝트 소개

**SimpleVoting**은 이더리움 스마트 컨트랙트를 이용한 온체인 투표 시스템입니다.

- 관리자(Owner)가 후보자를 등록합니다.
- 각 사용자는 지갑 주소당 1번만 투표할 수 있습니다 **(1인 1표)**.
- 모든 투표 결과는 블록체인에 투명하게 기록됩니다.

---

## 기술 스택

| 레이어       | 기술                                   |
|------------|---------------------------------------|
| Smart Contract | Solidity 0.8.26, Foundry (forge) |
| 프론트엔드 (가이드) | Next.js, wagmi, RainbowKit        |
| 테스트 네트워크   | Sepolia Testnet                    |

---

## 컨트랙트 기능

### 상태 변수
| 변수 | 설명 |
|-----|------|
| `candidates` | 후보자 이름 목록 (string 배열) |
| `votes` | 후보자별 득표 수 (mapping) |
| `hasVoted` | 투표 여부 관리 (mapping) |
| `owner` | 관리자 주소 |

### 함수
| 함수 | 권한 | 설명 |
|-----|------|------|
| `vote(candidateId)` | 모든 사용자 | 특정 후보에게 1표 투표 |
| `addCandidate(name)` | Owner만 | 새 후보자 추가 |
| `getCandidatesCount()` | Public | 전체 후보자 수 반환 |
| `getCandidate(id)` | Public | 후보자 이름 및 득표 수 반환 |

### 이벤트
- `CandidateAdded(candidateId, name)` - 후보자 추가 시 발생
- `Voted(voter, candidateId)` - 투표 시 발생

---

## 설치 및 실행

### 사전 준비
- [Foundry](https://book.getfoundry.sh/getting-started/installation) 설치

### 테스트 실행

```bash
# 저장소 최상단 경로에서 실행
forge test --match-path "week-06/dev/test/*.sol" -vvv
```

### Sepolia 배포

1. `.env` 파일 설정:
```bash
cp .env.example .env
# 아래 항목을 .env에 입력
# PRIVATE_KEY=0x...
# SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/YOUR_KEY
```

2. 배포 실행:
```bash
forge script week-06/dev/script/DeploySimpleVoting.s.sol \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast -vvvv
```

---

## 배포된 컨트랙트 주소 (Sepolia)

> 📌 배포 완료 후 주소를 여기에 기재하세요.

| 네트워크 | 컨트랙트 주소 |
|---------|------------|
| Sepolia | `TBD` |

---

## 프론트엔드 연동 안내 (wagmi)

```tsx
// ABI 일부 예시
const votingABI = [
  { name: 'vote', type: 'function', stateMutability: 'nonpayable', inputs: [{ name: '_candidateId', type: 'uint256' }], outputs: [] },
  { name: 'getCandidatesCount', type: 'function', stateMutability: 'view', inputs: [], outputs: [{ type: 'uint256' }] },
  { name: 'getCandidate', type: 'function', stateMutability: 'view', inputs: [{ name: '_candidateId', type: 'uint256' }], outputs: [{ name: 'name', type: 'string' }, { name: 'voteCount', type: 'uint256' }] },
] as const;

// 컨트랙트 읽기 (후보자 수)
const { data: count } = useReadContract({ address: CONTRACT_ADDRESS, abi: votingABI, functionName: 'getCandidatesCount' });

// 컨트랙트 쓰기 (투표)
const { writeContract } = useWriteContract();
const handleVote = (candidateId: number) => {
  writeContract({ address: CONTRACT_ADDRESS, abi: votingABI, functionName: 'vote', args: [BigInt(candidateId)] });
};
```

---

## 체크리스트

### Technical Checklist (기술 요구사항)

#### Smart Contract
- [x] Solidity 0.8.26 이상 사용
- [x] 최소 1개 이상의 상태 변수 (`candidates`, `votes`, `hasVoted`, `owner`)
- [x] 최소 2개 이상의 public/external 함수 (`vote`, `addCandidate`, `getCandidatesCount`, `getCandidate`)
- [x] 모든 상태 변경 함수에 이벤트 발생 (`Voted`, `CandidateAdded`)
- [x] Foundry 테스트 작성 (총 6개 테스트)
- [x] CEI 패턴 적용 (Check → Effect → Interaction 순서)

#### Frontend (가이드 코드 기준)
- [x] wagmi `useReadContract`로 컨트랙트 상태 읽기
- [x] wagmi `useWriteContract`로 컨트랙트 상태 쓰기
- [ ] Next.js App Router 사용 (프론트엔드 미구현)
- [ ] RainbowKit 지갑 연결 (프론트엔드 미구현)

#### Deployment
- [ ] Sepolia 배포 (배포 스크립트 작성 완료, 실제 배포 미완)
- [ ] 컨트랙트 주소 기재 (배포 후 업데이트 필요)
