import './globals.css';
import { Providers } from './Providers';

export const metadata = {
  title: 'Guestbook DApp',
  description: 'A simple Guestbook DApp on Sepolia',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="ko">
      <body>
        <Providers>
          {children}
        </Providers>
      </body>
    </html>
  );
}
