import Head from 'next/head';
import { FanushPanel } from '../components/ui/FanushPanel';
import styles from '../styles/Home.module.css';

export default function Home() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Fanush - AI-Powered Assistant</title>
        <meta name="description" content="Fanush - Your AI-Powered Assistant" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className={styles.main}>
        <FanushPanel />
      </main>

      <footer className={styles.footer}>
        <p>Built with ❤️ using React, Flask, and Google Gemini</p>
      </footer>
    </div>
  );
}