'use client';

import { useState } from 'react';
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { useReadContract, useWriteContract, useWaitForTransactionReceipt } from 'wagmi';

// 배포 후 여기에 컨트랙트 주소를 입력하세요.
const CONTRACT_ADDRESS = "0x3731fF0256B73AC5623F0048f1f2A720113e2059";

const GuestbookABI = [
  {"inputs":[{"internalType":"string","name":"_message","type":"string"}],"name":"addEntry","outputs":[],"stateMutability":"nonpayable","type":"function"},
  {"inputs":[],"name":"getEntries","outputs":[{"components":[{"internalType":"address","name":"author","type":"address"},{"internalType":"string","name":"message","type":"string"},{"internalType":"uint256","name":"timestamp","type":"uint256"}],"internalType":"struct Guestbook.Entry[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"}
] as const;

export default function Home() {
  const [message, setMessage] = useState('');

  // 1. 컨트랙트 상태 읽기 (메시지 목록 가져오기)
  const { data: entries, refetch } = useReadContract({
    address: CONTRACT_ADDRESS as `0x${string}`,
    abi: GuestbookABI,
    functionName: 'getEntries',
  });

  // 2. 컨트랙트 상태 쓰기 (메시지 추가하기)
  const { data: hash, writeContract, isPending: isWritePending, error } = useWriteContract();

  // 3. 트랜잭션 대기 상태 확인
  const { isLoading: isConfirming, isSuccess: isConfirmed } = useWaitForTransactionReceipt({
    hash,
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!message.trim()) return;
    
    writeContract({
      address: CONTRACT_ADDRESS as `0x${string}`,
      abi: GuestbookABI,
      functionName: 'addEntry',
      args: [message],
    });
  };

  return (
    <main className="min-h-screen p-8 bg-gray-50">
      <div className="max-w-2xl mx-auto space-y-8">
        <header className="flex justify-between items-center bg-white p-6 rounded-xl shadow-sm">
          <h1 className="text-2xl font-bold text-gray-800">📖 Guestbook DApp</h1>
          <ConnectButton />
        </header>

        <section className="bg-white p-6 rounded-xl shadow-sm">
          <h2 className="text-xl font-semibold mb-4">Leave a message</h2>
          <form onSubmit={handleSubmit} className="space-y-4">
            <textarea
              className="w-full p-4 border rounded-lg resize-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
              rows={3}
              placeholder="Write something nice..."
              value={message}
              onChange={(e) => setMessage(e.target.value)}
            />
            <button
              type="submit"
              disabled={isWritePending || isConfirming || !message.trim()}
              className="px-6 py-2 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              {isWritePending ? 'Signing...' : isConfirming ? 'Confirming...' : 'Post Message'}
            </button>
          </form>

          {/* 에러 처리 및 사용자 피드백 */}
          {error && (
            <div className="mt-4 p-4 text-red-700 bg-red-100 rounded-lg text-sm">
              Error: {(error as any).shortMessage || error.message}
            </div>
          )}
          {isConfirmed && (
            <div className="mt-4 p-4 text-green-700 bg-green-100 rounded-lg text-sm">
              Message posted successfully!
            </div>
          )}
        </section>

        <section className="bg-white p-6 rounded-xl shadow-sm">
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-xl font-semibold">Messages</h2>
            <button 
              onClick={() => refetch()}
              className="text-sm text-blue-600 hover:text-blue-800"
            >
              Refresh
            </button>
          </div>
          
          <div className="space-y-4">
            {entries && (entries as any[]).length > 0 ? (
              [...(entries as any[])].reverse().map((entry, i) => (
                <div key={i} className="p-4 border border-gray-100 rounded-lg bg-gray-50">
                  <div className="text-gray-800 mb-2">{entry.message}</div>
                  <div className="flex justify-between text-xs text-gray-500">
                    <span className="truncate w-1/2" title={entry.author}>
                      By: {entry.author}
                    </span>
                    <span>
                      {new Date(Number(entry.timestamp) * 1000).toLocaleString()}
                    </span>
                  </div>
                </div>
              ))
            ) : (
              <p className="text-gray-500 text-center py-8">No messages yet. Be the first!</p>
            )}
          </div>
        </section>
      </div>
    </main>
  );
}
