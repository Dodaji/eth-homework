# Week 6: 최종 프로젝트 - Guestbook DApp

간단한 방명록(Guestbook)을 블록체인 상에 기록하는 DApp입니다.

## 1. 프로젝트 소개
- 사용자가 자신의 지갑을 연결하여 블록체인에 메시지를 남길 수 있습니다.
- 저장된 모든 메시지와 작성자, 작성 시간이 화면에 표시됩니다.
- "나만의 dApp" 자유 주제 요구사항에 맞춰 간단하고 핵심적인 기능만 구현했습니다.

## 2. 기술 스택
- **Smart Contract**: Solidity 0.8.26, Foundry
- **Frontend**: Next.js (App Router), React, TailwindCSS
- **Web3 연동**: wagmi (v2), RainbowKit, viem

## 3. 배포된 컨트랙트 주소 (Sepolia)
- **Contract Address**: `0x3731fF0256B73AC5623F0048f1f2A720113e2059`
- **Network**: Sepolia Testnet

## 4. 설치 및 실행 방법

### Smart Contract 배포
1. `dev` 디렉토리에서 환경변수 설정 (`.env` 파일 생성 후 `SEPOLIA_RPC_URL`, `PRIVATE_KEY` 입력)
2. `forge build`
3. `forge create --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY src/Guestbook.sol:Guestbook`
4. 배포된 주소를 프론트엔드 `app/page.tsx`의 `CONTRACT_ADDRESS`에 복사

### Frontend 실행
1. `cd frontend`
2. `npm install`
3. `npm run dev`
4. 브라우저에서 `http://localhost:3000` 접속

---

## 체크리스트 완료 확인

- [x] Solidity 0.8.26 이상 사용
- [x] 최소 1개 이상의 상태 변수
- [x] 최소 2개 이상의 public/external 함수
- [x] 모든 상태 변경 함수에 이벤트 발생
- [x] Foundry 테스트 작성 (최소 5개 테스트)
- [x] CEI 패턴 또는 ReentrancyGuard 적용 (해당 시)
- [x] Next.js App Router 사용
- [x] wagmi + RainbowKit으로 지갑 연결
- [x] 컨트랙트 상태 읽기 (useReadContract)
- [x] 컨트랙트 상태 쓰기 (useWriteContract)
- [x] 트랜잭션 대기 상태 표시 (pending indicator)
- [x] 에러 처리 및 사용자 피드백
- [ ] Sepolia 테스트넷에 배포 (로컬 환경 세팅 후 배포 요망)
- [ ] 배포된 컨트랙트 주소 README에 기재
- [x] 지갑 연결 기능
- [x] 메인 기능 1개 이상 (메시지 작성 및 조회)
- [x] 트랜잭션 히스토리 또는 결과 표시
- [x] 반응형 레이아웃 (모바일/데스크톱)
- [x] 로딩 상태 표시
- [x] 에러 메시지 표시
