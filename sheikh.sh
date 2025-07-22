bash
#!/bin/bash

# Define colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}
 ________  ___  ___  _______   ___  ___  __    ___  ___     
|\   ____\|\  \|\  \|\  ___ \ |\  \|\  \|\  \ |\  \|\  \    
\ \  \___|\ \  \\\  \ \   __/|\ \  \ \  \/  /|\ \  \\\  \   
 \ \_____  \ \   __  \ \  \_|/_\ \  \ \   ___  \ \   __  \  
  \|____|\  \ \  \ \  \ \  \_|\ \ \  \ \  \\ \  \ \  \ \  \ 
    ____\_\  \ \__\ \__\ \_______\ \__\ \__\\ \__\ \__\ \__\
   |\_________\|__|\|__|\|_______|\|__|\|__| \|__|\|__|\|__|
   \|_________|                                             
                                                            
                                                            
${BLUE}
  COMPUTER - AI Automation from Bangladesh
  Your magic setup script for Termux!
${NC}"

echo -e "${YELLOW}----------------------------------------------------${NC}"
echo -e "${YELLOW}This script sets up the Sheikh Computer project structure on Termux.${NC}"
echo -e "${RED}WARNING: Full browser automation (worker_server) CANNOT run directly on Termux.${NC}"
echo -e "${RED}         You will need an EXTERNAL server for the worker!${NC}"
echo -e "${YELLOW}----------------------------------------------------${NC}"
echo ""

read -p "Press Enter to start setup..."

# --- 1. Basic Termux Package Installation ---
echo -e "${BLUE}1. Updating Termux packages...${NC}"
pkg update -y && pkg upgrade -y
pkg install -y git python nodejs-lts npm
echo -e "${GREEN}   Termux basic packages installed.${NC}"
echo ""

# --- 2. Create Project Directory Structure ---
echo -e "${BLUE}2. Creating Sheikh Computer project directory structure...${NC}"

PROJECT_ROOT="sheikh-computer"
mkdir -p "$PROJECT_ROOT"
cd "$PROJECT_ROOT"

# Use 'echo' and 'mkdir -p' to build the tree
echo -e "${YELLOW}   Creating root level files...${NC}"
echo '# Python' > .gitignore
echo '__pycache__/' >> .gitignore
echo '*.pyc' >> .gitignore
echo '*.pyo' >> .gitignore
echo '*.pyd' >> .gitignore
echo '.Python' >> .gitignore
echo '.venv' >> .gitignore
echo 'env/' >> .gitignore
echo 'venv/' >> .gitignore
echo '*.egg-info/' >> .gitignore
echo '.pytest_cache/' >> .gitignore
echo '.coverage' >> .gitignore
echo 'htmlcov/' >> .gitignore
echo '.tox/' >> .gitignore
echo '# Node.js' >> .gitignore
echo 'node_modules/' >> .gitignore
echo '.next/' >> .gitignore
echo 'out/' >> .gitignore
echo '# Environment Variables' >> .gitignore
echo '.env' >> .gitignore
echo '.env.local' >> .gitignore
echo '.env.development.local' >> .gitignore
echo '.env.test.local' >> .gitignore
echo '.env.production.local' >> .gitignore
echo '# Logs and Session Data' >> .gitignore
echo 'logs/' >> .gitignore
echo 'storage/' >> .gitignore
echo '*.log' >> .gitignore
echo '*.sqlite' >> .gitignore
echo '*.db' >> .gitignore
echo '# Docker' >> .gitignore
echo 'docker-compose.yaml' >> .gitignore
echo 'Dockerfile' >> .gitignore
echo '.dockerignore' >> .gitignore
echo '# IDEs' >> .gitignore
echo '.idea/' >> .gitignore
echo '.vscode/' >> .gitignore
echo '*.swp' >> .gitignore
echo '*.bak' >> .gitignore
echo '*.swo' >> .gitignore
echo '# Vercel' >> .gitignore
echo '.vercel/' >> .gitignore
echo ".gitignore created."

echo -e "# Rename this file to .env for local development" > .env.example
echo "" >> .env.example
echo "# GOOGLE GEMINI API KEY (for LLM interactions)" >> .env.example
echo "# Get yours from https://makersuite.google.com/" >> .env.example
echo 'GOOGLE_API_KEY="YOUR_GOOGLE_GEMINI_API_KEY"' >> .env.example
echo "" >> .env.example
echo "# REDIS CONNECTION URL (for task queue and state management)" >> .env.example
echo "# For local Termux Redis (if installed manually):" >> .env.example
echo "# REDIS_URL=\"redis://127.0.0.1:6379/0\"" >> .env.example
echo "# For cloud Redis (e.g., Upstash):" >> .env.example
echo '# REDIS_URL="rediss://:<PASSWORD>@<HOST>:<PORT>"' >> .env.example
echo 'REDIS_URL="redis://127.0.0.1:6379/0"' >> .env.example # Default for Termux local Redis if installed
echo "" >> .env.example
echo "# BROWSERLESS.IO TOKEN (for cloud browser automation)" >> .env.example
echo "# Get yours from https://browserless.io/" >> .env.example
echo "# This is required for the EXTERNAL WORKER. Not used on Termux for actual browsing." >> .env.example
echo 'BROWSERLESS_TOKEN="YOUR_BROWSERLESS_IO_TOKEN"' >> .env.example
echo "" >> .env.example
echo "# API SERVER URL (for worker to connect to the FastAPI backend)" >> .env.example
echo "# For local Termux API server:" >> .env.example
echo 'API_SERVER_URL="http://127.0.0.1:8000"' >> .env.example
echo "# For Vercel deployment of API (if worker is external):" >> .env.example
echo '# API_SERVER_URL="https://your-sheikh-computer-api.vercel.app"' >> .env.example
echo "" >> .env.example
echo "# WORKER CONFIGURATION (for the worker_server/main.py)" >> .env.example
echo "TASK_POLLING_INTERVAL=2" >> .env.example
echo "MAX_CONCURRENT_TASKS=3" >> .env.example
echo ".env.example created."

echo '{' > vercel.json
echo '  "version": 2,' >> vercel.json
echo '  "builds": [' >> vercel.json
echo '    {' >> vercel.json
echo '      "src": "nextjs-app/package.json",' >> vercel.json
echo '      "use": "@vercel/next"' >> vercel.json
echo '    },' >> vercel.json
echo '    {' >> vercel.json
echo '      "src": "api_server/main.py",' >> vercel.json
echo '      "use": "@vercel/python"' >> vercel.json
echo '    }' >> vercel.json
echo '  ],' >> vercel.json
echo '  "routes": [' >> vercel.json
echo '    {' >> vercel.json
echo '      "src": "/api/(.*)",' >> vercel.json
echo '      "dest": "api_server/main.py"' >> vercel.json
echo '    },' >> vercel.json
echo '    {' >> vercel.json
echo '      "src": "/(.*)",' >> vercel.json
echo '      "dest": "nextjs-app/$1"' >> vercel.json
echo '    }' >> vercel.json
echo '  ],' >> vercel.json
echo '  "env": {' >> vercel.json
echo '    "REDIS_URL": "@redis_url",' >> vercel.json
echo '    "GOOGLE_API_KEY": "@google_api_key",' >> vercel.json
echo '    "PYTHONUNBUFFERED": "1"' >> vercel.json
echo '  }' >> vercel.json
echo '}' >> vercel.json
echo "vercel.json created."

echo -e "${YELLOW}   Creating subdirectories...${NC}"
mkdir -p nextjs-app/public
mkdir -p nextjs-app/src/app/api
mkdir -p nextjs-app/src/components
mkdir -p sheikh_core
mkdir -p api_server
mkdir -p worker_server
mkdir -p cli
mkdir -p bin
mkdir -p logs
mkdir -p storage
echo -e "${GREEN}   Directory structure created.${NC}"
echo ""

# --- 3. Populate Files ---
echo -e "${BLUE}3. Populating project files...${NC}"

# nextjs-app files
echo -e "${YELLOW}   Populating nextjs-app/...${NC}"
echo '{
  "name": "sheikh-computer-frontend",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint"
  },
  "dependencies": {
    "next": "14.0.4",
    "react": "^18",
    "react-dom": "^18",
    "swr": "^2.2.4"
  },
  "devDependencies": {
    "eslint": "^8",
    "eslint-config-next": "14.0.4",
    "autoprefixer": "^10.0.1",
    "postcss": "^8",
    "tailwindcss": "^3.3.0"
  }
}' > nextjs-app/package.json
echo '/** @type {import("tailwindcss").Config} */
const { fontFamily } = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["var(--font-inter)", ...fontFamily.sans],
        mono: ["var(--font-source-code-pro)", ...fontFamily.mono],
      },
      colors: {
        primary: {
          DEFAULT: "rgb(29, 78, 216)", // blue-700
          50: "rgb(239, 246, 255)",   // blue-50
          100: "rgb(219, 234, 254)",  // blue-100
          200: "rgb(191, 219, 254)",  // blue-200
          300: "rgb(147, 197, 253)",  // blue-300
          400: "rgb(96, 165, 250)",   // blue-400
          500: "rgb(59, 130, 246)",   // blue-500
          600: "rgb(37, 99, 235)",    // blue-600
          700: "rgb(29, 78, 216)",    // blue-700 (accent)
          800: "rgb(30, 64, 175)",    // blue-800
          900: "rgb(20, 52, 166)",    // blue-900
        },
        gray: {
          DEFAULT: "rgb(107, 114, 128)", // gray-500
          50: "rgb(249, 250, 251)",    // gray-50 (light background)
          100: "rgb(243, 244, 246)",   // gray-100 (dashboard background)
          200: "rgb(229, 231, 235)",
          300: "rgb(209, 213, 219)",
          400: "rgb(156, 163, 175)",
          500: "rgb(107, 114, 128)",
          600: "rgb(75, 85, 99)",
          700: "rgb(55, 65, 81)",      // gray-700 (text)
          800: "rgb(31, 41, 55)",      // gray-800 (text)
          900: "rgb(17, 24, 39)",
        },
        green: {
          DEFAULT: "rgb(34, 197, 94)",  // green-500
          100: "rgb(220, 252, 231)",   // green-100 (status background)
          800: "rgb(22, 101, 52)",     // green-800 (status text)
        },
        red: {
          DEFAULT: "rgb(239, 68, 68)",  // red-500
          100: "rgb(254, 226, 226)",   // red-100 (status background)
          800: "rgb(153, 27, 27)",     // red-800 (status text)
        },
        yellow: {
          DEFAULT: "rgb(250, 204, 21)", // yellow-500
          100: "rgb(255, 251, 235)",   // yellow-100 (status background)
          800: "rgb(146, 64, 14)",     // yellow-800 (status text)
        },
      },
    },
  },
  plugins: [],
};' > nextjs-app/tailwind.config.js
echo 'module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
};' > nextjs-app/postcss.config.js
echo '@tailwind base;
@tailwind components;
@tailwind utilities;

/* Custom fonts imported from Google Fonts */
/* Ensure you add these links to your nextjs-app/src/app/layout.js */
/*
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap");
@import url("https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@400;500;600&display=swap");
*/
' > nextjs-app/src/app/globals.css
echo 'import "../globals.css";
import { Inter, Source_Code_Pro } from "next/font/google";

// Define fonts with variable names for Tailwind CSS
const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter", // Variable for body and headline font
  display: "swap",
});

const sourceCodePro = Source_Code_Pro({
  subsets: ["latin"],
  variable: "--font-source-code-pro", // Variable for code font
  display: "swap",
});

export const metadata = {
  title: "Sheikh Computer Dashboard",
  description: "AI-Powered Browser Automation Platform from Bangladesh",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en" className={`${inter.variable} ${sourceCodePro.variable}`}>
      <body className="font-sans">{children}</body>
    </html>
  );
}' > nextjs-app/src/app/layout.js
echo '\'use client\';

import TaskForm from "../components/TaskForm";
import TaskList from "../components/TaskList";
import { useState } from "react";

export default function Home() {
  const [refreshKey, setRefreshKey] = useState(0);

  const handleTaskSubmitted = () => {
    setRefreshKey((prev) => prev + 1); // Increment key to force TaskList re-fetch
  };

  return (
    <div className="min-h-screen bg-gray-100 py-10 font-sans">
      <header className="text-center mb-10">
        <h1 className="text-5xl font-extrabold text-primary-700 mb-3">
          Sheikh Computer
        </h1>
        <p className="text-xl text-gray-700">
          Intelligent Browser Automation Platform for Real-World Problem Solving
        </p>
      </header>

      <main className="container mx-auto px-4">
        <TaskForm onTaskSubmitted={handleTaskSubmitted} />
        <TaskList refreshKey={refreshKey} />
      </main>

      <footer className="mt-12 text-center text-gray-500 text-sm">
        Built with Browser-Use, Gemini AI, Next.js, FastAPI, and Redis.
      </footer>
    </div>
  );
}' > nextjs-app/src/app/page.js
echo '\'use client\';

import { useState } from "react";

export default function TaskForm({
  onTaskSubmitted,
  browserConfigs = ["primary_desktop", "mobile_usa", "stealth_desktop"],
}) {
  const [description, setDescription] = useState("");
  const [browserConfig, setBrowserConfig] = useState("primary_desktop");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState(null);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError(null);
    setIsSubmitting(true);

    try {
      const response = await fetch("/api/tasks", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          description: description,
          browser_config_name: browserConfig,
          priority: "medium", // Default for now, can be exposed in UI
          initial_actions: [], // Default for now
        }),
      });

      if (!response.ok) {
        const errorData = await response.json();
        throw new Error(errorData.detail || "Failed to submit task");
      }

      const result = await response.json();
      alert(`Task submitted! Task ID: ${result.id}`);
      setDescription("");
      onTaskSubmitted(); // Notify parent to refresh task list
    } catch (err) {
      setError(err.message);
      console.error("Error submitting task:", err);
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <form
      onSubmit={handleSubmit}
      className="p-6 bg-white shadow rounded-lg max-w-md mx-auto md:max-w-lg lg:max-w-xl"
    >
      <h2 className="text-2xl font-bold mb-4 text-gray-800">Submit New Task</h2>
      <div className="mb-4">
        <label
          htmlFor="description"
          className="block text-gray-700 text-sm font-bold mb-2"
        >
          Task Description:
        </label>
        <textarea
          id="description"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
          placeholder="e.g., 'Research latest AI developments from Google, Microsoft, and OpenAI websites.'"
          className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline resize-y"
          rows="4"
          required
        />
      </div>
      <div className="mb-4">
        <label
          htmlFor="browserConfig"
          className="block text-gray-700 text-sm font-bold mb-2"
        >
          Browser Configuration:
        </label>
        <select
          id="browserConfig"
          value={browserConfig}
          onChange={(e) => setBrowserConfig(e.target.value)}
          className="shadow border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        >
          {browserConfigs.map((config) => (
            <option key={config} value={config}>
              {config}
            </option>
          ))}
        </select>
      </div>
      <button
        type="submit"
        disabled={isSubmitting}
        className="bg-primary-600 hover:bg-primary-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline disabled:opacity-50 transition-colors duration-200"
      >
        {isSubmitting ? "Submitting..." : "Start Automation"}
      </button>
      {error && (
        <p className="text-red-500 text-xs italic mt-2">Error: {error}</p>
      )}
    </form>
  );
}' > nextjs-app/src/components/TaskForm.jsx
echo '\'use client\';

import useSWR from "swr";
import { useEffect, useState } from "react";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faCheckCircle,
  faTimesCircle,
  faSyncAlt,
  faHourglassHalf,
  faPauseCircle,
  faGlobe,
  faExternalLinkAlt,
  faCamera,
  faCode,
} from "@fortawesome/free-solid-svg-icons"; // Example icons

const fetcher = (url) => fetch(url).then((res) => res.json());

export default function TaskList({ refreshKey }) {
  const [tasks, setTasks] = useState([]);
  const { data, error, isLoading } = useSWR("/api/tasks", fetcher, {
    refreshInterval: 5000, // Poll every 5 seconds for updates
  });

  useEffect(() => {
    if (data) {
      setTasks(data);
    }
  }, [data]);

  // Force re-fetch when refreshKey changes (e.g., new task submitted)
  useEffect(() => {
    if (refreshKey > 0) {
      // SWR"s refreshInterval will handle it, but you could explicitly revalidate
      // mutate("/api/tasks");
    }
  }, [refreshKey]);

  if (error)
    return (
      <div className="text-red-800 bg-red-100 p-4 rounded-lg">
        Failed to load tasks: {error.message}
      </div>
    );
  if (isLoading)
    return (
      <div className="text-gray-600 bg-gray-50 p-4 rounded-lg">
        <FontAwesomeIcon icon={faSyncAlt} spin className="mr-2" /> Loading
        tasks...
      </div>
    );
  if (!tasks || tasks.length === 0)
    return (
      <div className="text-gray-600 bg-gray-50 p-4 rounded-lg">
        No tasks submitted yet. Submit a task using the form above.
      </div>
    );

  const getStatusColorClass = (status) => {
    switch (status) {
      case "completed":
        return "bg-green-100 text-green-800";
      case "failed":
        return "bg-red-100 text-red-800";
      case "running":
        return "bg-blue-100 text-blue-800 animate-pulse";
      case "queued":
        return "bg-gray-100 text-gray-800";
      case "paused":
        return "bg-yellow-100 text-yellow-800";
      default:
        return "bg-gray-100 text-gray-700";
    }
  };

  const getStatusIcon = (status) => {
    switch (status) {
      case "completed":
        return faCheckCircle;
      case "failed":
        return faTimesCircle;
      case "running":
        return faSyncAlt;
      case "queued":
        return faHourglassHalf;
      case "paused":
        return faPauseCircle;
      default:
        return faHourglassHalf;
    }
  };

  return (
    <div className="mt-8 p-6 bg-white shadow rounded-lg max-w-4xl mx-auto md:max-w-5xl lg:max-w-6xl">
      <h2 className="text-2xl font-bold mb-4 text-gray-800">Recent Tasks</h2>
      <ul className="space-y-4">
        {tasks.map((task) => (
          <li
            key={task.id}
            className="border-b border-gray-200 pb-4 last:border-b-0 last:pb-0"
          >
            <div className="flex flex-col md:flex-row justify-between items-start md:items-center mb-2">
              <div className="flex items-center mb-2 md:mb-0">
                <FontAwesomeIcon
                  icon={getStatusIcon(task.status)}
                  className={`mr-2 ${
                    task.status === "running" ? "text-blue-600 animate-spin" : ""
                  } ${task.status === "completed" ? "text-green-600" : ""} ${
                    task.status === "failed" ? "text-red-600" : ""
                  }`}
                />
                <span className="font-semibold text-lg text-gray-900">
                  {task.description}
                </span>
              </div>
              <span
                className={`px-3 py-1 rounded-full text-sm font-medium ${getStatusColorClass(
                  task.status
                )}`}
              >
                {task.status.toUpperCase()}
              </span>
            </div>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-2 text-gray-700 text-sm">
              <p>
                <span className="font-semibold">Task ID:</span>{" "}
                <span className="font-mono text-gray-600 text-xs">
                  {task.id.substring(0, 8)}...
                </span>
              </p>
              <p>
                <span className="font-semibold">Config:</span>{" "}
                {task.browser_config_name}
              </p>
              <p>
                <span className="font-semibold">Submitted:</span>{" "}
                {new Date(task.created_at).toLocaleString()}
              </p>
              {task.status === "running" && task.last_attempt_at && (
                <p>
                  <span className="font-semibold">Started:</span>{" "}
                  {new Date(task.last_attempt_at).toLocaleString()}
                </p>
              )}
              {task.status === "completed" && task.execution_time > 0 && (
                <p>
                  <span className="font-semibold">Completed in:</span>{" "}
                  {task.execution_time.toFixed(2)}s
                </p>
              )}
              {task.current_retries > 0 && (
                <p className="text-yellow-700">
                  <span className="font-semibold">Retries:</span>{" "}
                  {task.current_retries}/{task.max_retries}
                </p>
              )}
            </div>

            {task.error && (
              <div className="mt-3 text-red-800 text-sm bg-red-50 p-3 rounded-lg font-mono overflow-x-auto">
                <h4 className="font-semibold mb-1">
                  <FontAwesomeIcon icon={faTimesCircle} className="mr-1" />{" "}
                  Error Details:
                </h4>
                <pre className="whitespace-pre-wrap text-xs">{task.error}</pre>
              </div>
            )}

            {task.result_content && task.result_content.final_result && (
              <div className="mt-3 text-gray-800 text-sm bg-gray-50 p-3 rounded-lg overflow-x-auto">
                <h4 className="font-semibold mb-1">
                  <FontAwesomeIcon icon={faCode} className="mr-1" /> Final Result:
                </h4>
                <pre className="whitespace-pre-wrap text-xs font-mono max-h-48">
                  {JSON.stringify(task.result_content.final_result, null, 2)}
                </pre>
              </div>
            )}

            {task.result_content &&
              task.result_content.urls_visited &&
              task.result_content.urls_visited.length > 0 && (
                <div className="mt-3 text-gray-800 text-sm bg-gray-50 p-3 rounded-lg">
                  <h4 className="font-semibold mb-1">
                    <FontAwesomeIcon icon={faGlobe} className="mr-1" /> Visited
                    URLs:
                  </h4>
                  <ul className="list-disc list-inside text-xs space-y-1">
                    {task.result_content.urls_visited.map((url, index) => (
                      <li key={index}>
                        <a
                          href={url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-primary-600 hover:underline flex items-center break-all"
                        >
                          {url}{" "}
                          <FontAwesomeIcon
                            icon={faExternalLinkAlt}
                            className="ml-1 text-xs"
                          />
                        </a>
                      </li>
                    ))}
                  </ul>
                </div>
              )}

            {task.result_content &&
              task.result_content.screenshots &&
              task.result_content.screenshots.length > 0 && (
                <div className="mt-3 text-gray-800 text-sm bg-gray-50 p-3 rounded-lg">
                  <h4 className="font-semibold mb-1">
                    <FontAwesomeIcon icon={faCamera} className="mr-1" /> Screenshots:
                  </h4>
                  <div className="flex flex-wrap gap-2 mt-2">
                    {task.result_content.screenshots.map((imgBase64, index) => (
                      <img
                        key={index}
                        src={`data:image/png;base64,${imgBase64}`}
                        alt={`Screenshot ${index}`}
                        className="w-24 h-auto border border-gray-300 rounded shadow-sm cursor-pointer transition-transform hover:scale-105"
                        onClick={() =>
                          window.open(`data:image/png;base64,${imgBase64}`, "_blank")
                        }
                      />
                    ))}
                  </div>
                </div>
              )}
          </li>
        ))}
      </ul>
    </div>
  );
}' > nextjs-app/src/components/TaskList.jsx
echo '/** @type {import("next").NextConfig} */
const nextConfig = {};

module.exports = nextConfig;' > nextjs-app/next.config.js
echo '/* eslint-disable @next/next/no-img-element */' > nextjs-app/public/favicon.ico # Placeholder, normally a binary file
echo -e "${GREEN}   nextjs-app/ populated.${NC}"
echo ""

# sheikh_core files
echo -e "${YELLOW}   Populating sheikh_core/...${NC}"
echo '# sheikh_core/__init__.py
from .sheikh_computer import SheikhComputer
from .models import TaskStatus, TaskPriority, BrowserConfig, TaskResultContent, Task, NewTaskRequest, TaskUpdate
' > sheikh_core/__init__.py
echo '# sheikh_core/models.py
from datetime import datetime, timezone
from enum import Enum
from typing import Dict, List, Optional, Any
from pydantic import BaseModel, Field
from dataclasses import dataclass

class TaskStatus(Enum):
    QUEUED = "queued"     # Task is submitted, waiting to be picked by worker
    RUNNING = "running"   # Worker has picked up and is executing
    COMPLETED = "completed"
    FAILED = "failed"
    PAUSED = "paused"     # Not yet implemented in core logic, but good for future UI

class TaskPriority(Enum):
    LOW = 1
    MEDIUM = 2
    HIGH = 3
    CRITICAL = 4

@dataclass
class BrowserConfig:
    """Configuration for browser sessions"""
    name: str
    timezone_id: str
    device_type: str = "desktop"
    stealth: bool = True
    headless: bool = False
    viewport: Optional[Dict[str, int]] = None
    user_data_dir: Optional[str] = None
    storage_state: Optional[str] = None
    allowed_domains: Optional[List[str]] = None
    executable_path: Optional[str] = None

class TaskResultContent(BaseModel):
    """Result content extracted from a task"""
    final_result: Optional[Any] = None
    screenshots: List[str] = Field(default_factory=list) # Base64 encoded images or URLs
    urls_visited: List[str] = Field(default_factory=list)
    extracted_content: Dict[str, Any] = Field(default_factory=dict)

class Task(BaseModel):
    """Task definition and its current state"""
    id: str
    description: str
    browser_config_name: str # Name of the browser config to use (e.g., "primary_desktop")
    priority: TaskPriority = TaskPriority.MEDIUM
    max_retries: int = 3
    timeout: int = 300  # 5 minutes
    initial_actions: List[Dict[str, Any]] = Field(default_factory=list)
    output_model: Optional[str] = None
    custom_prompt: Optional[str] = None
    created_at: datetime = Field(default_factory=lambda: datetime.now(timezone.utc))
    scheduled_at: Optional[datetime] = None
    dependencies: List[str] = Field(default_factory=list)
    
    # Task execution state
    status: TaskStatus = TaskStatus.QUEUED
    current_retries: int = 0
    last_attempt_at: Optional[datetime] = None
    
    # Task results
    execution_time: float = 0.0
    error: Optional[str] = None
    result_content: TaskResultContent = Field(default_factory=TaskResultContent)

# For API input (when creating a task, ID is generated by server)
class NewTaskRequest(BaseModel):
    description: str
    browser_config_name: str = "primary_desktop"
    priority: TaskPriority = TaskPriority.MEDIUM
    max_retries: int = 3
    timeout: int = 300
    initial_actions: List[Dict[str, Any]] = Field(default_factory=list)
    output_model: Optional[str] = None
    custom_prompt: Optional[str] = None
    scheduled_at: Optional[datetime] = None
    dependencies: List[str] = Field(default_factory=list)

# For Worker to update Task (can update partial fields)
class TaskUpdate(BaseModel):
    status: Optional[TaskStatus] = None
    current_retries: Optional[int] = None
    last_attempt_at: Optional[datetime] = None
    execution_time: Optional[float] = None
    error: Optional[str] = None
    result_content: Optional[TaskResultContent] = None
' > sheikh_core/models.py
echo '# sheikh_core/sheikh_computer.py
import asyncio
import json
import logging
import os
from datetime import datetime, timezone
from pathlib import Path
from typing import Dict, List, Optional, Any
import uuid

from browser_use import Agent, BrowserSession
from browser_use.browser import BrowserProfile
from browser_use.llm import ChatGoogle
from playwright.async_api import async_playwright # For Browserless connection
from dotenv import load_dotenv

from .models import TaskStatus, TaskResultContent, Task, BrowserConfig

# Load environment variables (for GOOGLE_API_KEY, BROWSERLESS_TOKEN)
load_dotenv()

class SheikhComputer:
    """Main Sheikh Computer automation platform core logic"""
    
    def __init__(self, config_path: str = "sheikh_config.json"):
        self.config_path = Path(config_path)
        self.browser_configs: Dict[str, BrowserConfig] = {}
        self.browser_sessions: Dict[str, BrowserSession] = {} # Active sessions cache
        self.llm = None
        self.planner_llm = None
        self.browserless_token: Optional[str] = os.getenv("BROWSERLESS_TOKEN")
        
        self._setup_logging()
        self._load_config()
        self._initialize_llms()
    
    def _setup_logging(self):
        """Setup logging configuration"""
        log_dir = Path("logs")
        log_dir.mkdir(exist_ok=True)
        logging.basicConfig(
            level=logging.INFO,
            format="%(asctime)s - SheikhComputer - %(levelname)s - %(message)s",
            handlers=[
                logging.FileHandler(log_dir / "sheikh_computer_core.log"),
                logging.StreamHandler()
            ]
        )
        self.logger = logging.getLogger(__name__)
    
    def _load_config(self):
        """Load configuration from file, or create default"""
        if self.config_path.exists():
            with open(self.config_path, "r") as f:
                config_data = json.load(f)
            for name, config_dict in config_data.get("browsers", {}).items():
                try:
                    self.browser_configs[name] = BrowserConfig(name=name, **config_dict)
                except Exception as e:
                    self.logger.error(f"Error loading browser config \"{name}\": {e}")
        else:
            self._create_default_config()
    
    def _create_default_config(self):
        """Create default browser configurations and save them"""
        default_configs = {
            "primary_desktop": BrowserConfig(
                name="primary_desktop",
                timezone_id="UTC",
                device_type="desktop",
                stealth=True,
                headless=True,
                viewport={"width": 1920, "height": 1080},
                storage_state="storage/primary_auth.json"
            ),
            "mobile_usa": BrowserConfig(
                name="mobile_usa",
                timezone_id="America/New_York",
                device_type="iPhone 13", # Playwright preset
                stealth=True,
                headless=True,
                storage_state="storage/mobile_auth.json"
            ),
            "stealth_desktop": BrowserConfig(
                name="stealth_desktop",
                timezone_id="UTC",
                device_type="desktop",
                stealth=True,
                headless=True, # Truly headless for server automation
                viewport={"width": 1366, "height": 768},
                user_data_dir=None # Incognito-like session
            )
        }
        self.browser_configs = default_configs
        self._save_config()
        self.logger.info("Created and saved default browser configurations.")
    
    def _save_config(self):
        """Save current browser configurations to file"""
        config_data = {
            "browsers": {
                name: config.__dict__ # Directly dump dataclass attributes
                for name, config in self.browser_configs.items()
            }
        }
        Path("storage").mkdir(exist_ok=True) # Ensure storage directory exists
        with open(self.config_path, "w") as f:
            json.dump(config_data, f, indent=2)
    
    def _initialize_llms(self):
        """Initialize language models (Gemini)"""
        google_api_key = os.getenv("GOOGLE_API_KEY")
        if not google_api_key:
            self.logger.warning("GOOGLE_API_KEY not found. LLM functionality may be limited.")
        
        try:
            self.llm = ChatGoogle(model="gemini-1.5-pro-latest") # Using a more capable model
            self.planner_llm = ChatGoogle(model="gemini-1.5-pro-latest")
            self.logger.info("LLMs initialized successfully.")
        except Exception as e:
            self.logger.error(f"Failed to initialize LLMs: {e}. Check GOOGLE_API_KEY.")
            raise

    async def create_browser_session(self, config_name: str) -> BrowserSession:
        """Create a browser session, potentially via Browserless.io"""
        if config_name not in self.browser_configs:
            raise ValueError(f"Unknown browser configuration: {config_name}")
        
        config = self.browser_configs[config_name]
        
        browser_connect_url = None
        if self.browserless_token:
            browser_connect_url = f"wss://chrome.browserless.io?token={self.browserless_token}"
            self.logger.info(f"Connecting to Browserless.io for config: {config_name}")
        else:
            self.logger.warning(f"BROWSERLESS_TOKEN not set. Running Playwright locally for config: {config_name}. Ensure Playwright browsers are installed.")

        profile_kwargs = {
            "stealth": config.stealth,
            "timezone_id": config.timezone_id,
            "headless": config.headless,
            "browser_connect_url": browser_connect_url # Pass to BrowserProfile
        }
        
        if config.viewport: profile_kwargs["viewport"] = config.viewport
        if config.user_data_dir: profile_kwargs["user_data_dir"] = config.user_data_dir
        if config.allowed_domains: profile_kwargs["allowed_domains"] = config.allowed_domains
        if config.executable_path: profile_kwargs["executable_path"] = config.executable_path

        if config.storage_state:
            storage_path = Path(config.storage_state)
            storage_path.parent.mkdir(exist_ok=True)
            profile_kwargs["storage_state"] = config.storage_state
        
        if config.device_type != "desktop":
            from playwright.sync_api import sync_playwright
            with sync_playwright() as p:
                if config.device_type in p.devices:
                    profile_kwargs.update(p.devices[config.device_type])
                else:
                    self.logger.warning(f"Playwright device \"{config.device_type}\" not found. Using default desktop profile.")

        browser_profile = BrowserProfile(**profile_kwargs)
        session = BrowserSession(browser_profile=browser_profile, timezone_id=config.timezone_id)
        
        await session.start()
        self.browser_sessions[config_name] = session
        self.logger.info(f"Started browser session for config: {config_name}")
        return session
    
    async def execute_task(self, task: Task) -> TaskResultContent:
        """Executes a single browser automation task using Agent"""
        
        if task.browser_config_name not in self.browser_configs:
            raise ValueError(f"Browser configuration \"{task.browser_config_name}\" not found.")
        
        session = None
        try:
            if task.browser_config_name in self.browser_sessions:
                session = self.browser_sessions[task.browser_config_name]
                self.logger.info(f"Re-using existing browser session for config: {task.browser_config_name}")
            else:
                session = await self.create_browser_session(task.browser_config_name)
            
            agent = Agent(
                task=task.description,
                llm=self.llm,
                planner_llm=self.planner_llm,
                browser_session=session,
                use_vision=True, # Leverage Gemini"s vision capabilities
                save_conversation_path=f"logs/conversation_{task.id}"
            )
            
            for action in task.initial_actions:
                action_type = list(action.keys())[0]
                action_args = action[action_type]
                if hasattr(agent, action_type) and callable(getattr(agent, action_type)):
                    await getattr(agent, action_type)(**action_args)
                else:
                    self.logger.warning(f"Initial action \"{action_type}\" not found or not callable on Agent. Skipping.")
            
            if task.custom_prompt:
                agent.override_system_message = task.custom_prompt

            self.logger.info(f"Agent starting for task {task.id}...")
            history = await asyncio.wait_for(agent.run(), timeout=task.timeout)
            self.logger.info(f"Agent finished for task {task.id}.")

            result_content = TaskResultContent(
                final_result=history.final_result(),
                screenshots=history.screenshots(),
                urls_visited=history.urls(),
                extracted_content=history.extracted_content()
            )
            return result_content

        except asyncio.TimeoutError:
            self.logger.error(f"Task {task.id} timed out after {task.timeout} seconds.")
            raise
        except Exception as e:
            self.logger.error(f"Error during task {task.id} execution: {e}", exc_info=True)
            raise
        finally:
            pass

    async def close_all_sessions(self):
        """Gracefully close all active browser sessions."""
        for config_name, session in list(self.browser_sessions.items()):
            try:
                config = self.browser_configs.get(config_name)
                if config and config.storage_state:
                    await session.save_storage_state(config.storage_state)
                await session.close()
                self.logger.info(f"Closed browser session for config: {config_name}")
            except Exception as e:
                self.logger.error(f"Failed to close session for config {config_name}: {e}")
            finally:
                del self.browser_sessions[config_name]
' > sheikh_core/sheikh_computer.py
echo -e "${GREEN}   sheikh_core/ populated.${NC}"
echo ""

# api_server files
echo -e "${YELLOW}   Populating api_server/...${NC}"
echo 'fastapi
uvicorn[standard]
redis
pydantic
python-dotenv
' > api_server/requirements.txt
echo '# api_server/main.py
import json
import os
import uuid
from datetime import datetime, timezone
from typing import List, Optional

import redis
from fastapi import FastAPI, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from pydantic import ValidationError

# Import models from the shared sheikh_core package
from sheikh_core.models import NewTaskRequest, Task, TaskStatus, TaskUpdate

app = FastAPI(
    title="Sheikh Computer API Gateway",
    description="API for submitting and monitoring browser automation tasks.",
    version="1.0.0"
)

# Initialize Redis connection
REDIS_URL = os.getenv("REDIS_URL")
if not REDIS_URL:
    raise ValueError("REDIS_URL environment variable is not set. Cannot connect to Redis.")
try:
    r = redis.Redis.from_url(REDIS_URL, decode_responses=True) # decode_responses=True for string outputs
    r.ping() # Test connection
    print("Connected to Redis successfully!")
except redis.exceptions.ConnectionError as e:
    print(f"ERROR: Could not connect to Redis at {REDIS_URL}: {e}")
    raise

# CORS middleware for frontend access (adjust origins as needed)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/", include_in_schema=False)
async def root():
    return {"message": "Welcome to Sheikh Computer API Gateway! Visit /docs for API documentation."}

@app.post("/api/tasks", response_model=Task, status_code=status.HTTP_202_ACCEPTED)
async def create_task(new_task_request: NewTaskRequest):
    """
    Submits a new browser automation task to the queue.
    """
    task_id = str(uuid.uuid4())
    current_time = datetime.now(timezone.utc)

    task = Task(
        id=task_id,
        description=new_task_request.description,
        browser_config_name=new_task_request.browser_config_name,
        priority=new_task_request.priority,
        max_retries=new_task_request.max_retries,
        timeout=new_task_request.timeout,
        initial_actions=new_task_request.initial_actions,
        output_model=new_task_request.output_model,
        custom_prompt=new_task_request.custom_prompt,
        created_at=current_time,
        scheduled_at=new_task_request.scheduled_at,
        dependencies=new_task_request.dependencies,
        status=TaskStatus.QUEUED # Initial status
    )

    try:
        task_json = task.model_dump_json()
        r.set(f"task:{task_id}", task_json)
        
        r.rpush("sheikh_computer:task_queue", task_id)

        print(f"Task {task_id} received and queued in Redis.")
        return task
    except Exception as e:
        print(f"Error queuing task {task_id} in Redis: {e}")
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Failed to queue task: {e}"
        )

@app.get("/api/tasks", response_model=List[Task])
async def get_all_tasks():
    """
    Retrieves a list of all submitted tasks.
    """
    keys = r.keys("task:*")
    tasks_data = []
    if keys:
        task_jsons = r.mget(keys)
        for task_json in task_jsons:
            if task_json:
                try:
                    tasks_data.append(Task.model_validate_json(task_json))
                except (json.JSONDecodeError, ValidationError) as e:
                    print(f"Error parsing task data from Redis: {task_json}, Error: {e}")
    
    sorted_tasks = sorted(tasks_data, key=lambda t: t.created_at, reverse=True)
    return sorted_tasks

@app.get("/api/tasks/{task_id}", response_model=Task)
async def get_task_status(task_id: str):
    """
    Retrieves the status and details of a specific task.
    """
    task_json = r.get(f"task:{task_id}")
    if not task_json:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Task not found")
    
    try:
        return Task.model_validate_json(task_json)
    except ValidationError as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"Invalid task data in store: {e}")

@app.put("/api/tasks/{task_id}", response_model=Task)
async def update_task_state(task_id: str, task_update: TaskUpdate):
    """
    (Internal/Worker-facing) Updates the status and details of a task.
    """
    task_json = r.get(f"task:{task_id}")
    if not task_json:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Task not found")
    
    try:
        current_task = Task.model_validate_json(task_json)
        updated_data = task_update.model_dump(exclude_unset=True, mode="json")
        
        for key, value in updated_data.items():
            if key == "status":
                current_task.status = TaskStatus(value)
            elif key == "result_content":
                if isinstance(value, dict):
                    current_task.result_content = TaskResultContent(**value)
                elif value is None:
                    current_task.result_content = None
            elif key == "last_attempt_at":
                current_task.last_attempt_at = datetime.fromisoformat(value) if value else None
            else:
                setattr(current_task, key, value)

        r.set(f"task:{task_id}", current_task.model_dump_json())
        print(f"Task {task_id} state updated by worker to {current_task.status.value}")
        return current_task
    except (json.JSONDecodeError, ValidationError) as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"Error processing update: {e}")
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"An unexpected error occurred: {e}")
' > api_server/main.py
echo -e "${GREEN}   api_server/ populated.${NC}"
echo ""

# worker_server files (only minimal setup for Termux, actual worker needs external server)
echo -e "${YELLOW}   Populating worker_server/... (Note: This is for external deployment)${NC}"
echo 'sheikh_core @ file:../sheikh_core
redis
pydantic
python-dotenv
httpx
browser-use
' > worker_server/requirements.txt
echo '# worker_server/main.py
# This worker is NOT intended to run directly on Termux.
# It requires a full Linux environment with Playwright browser binaries.
# Deploy this on a dedicated VM, server, or cloud container service (e.g., AWS EC2, DigitalOcean, Fly.io).

import asyncio
import httpx
import logging
import os
import redis
from datetime import datetime, timezone
from typing import Dict, Optional

from sheikh_core import SheikhComputer, TaskStatus, TaskPriority, Task, TaskUpdate, TaskResultContent

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - WORKER - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler("logs/sheikh_worker.log"),
        logging.StreamHandler()
    ]
)
logger = logging.getLogger(__name__)

API_SERVER_URL = os.getenv("API_SERVER_URL", "http://localhost:8000")
TASK_POLLING_INTERVAL = int(os.getenv("TASK_POLLING_INTERVAL", 2))
MAX_CONCURRENT_TASKS = int(os.getenv("MAX_CONCURRENT_TASKS", 3))

sheikh_computer_core = SheikhComputer()
task_semaphore = asyncio.Semaphore(MAX_CONCURRENT_TASKS)
active_tasks_futures: Dict[str, asyncio.Task] = {}

REDIS_URL_WORKER = os.getenv("REDIS_URL")
if not REDIS_URL_WORKER:
    raise ValueError("REDIS_URL environment variable is not set for worker. Cannot connect to Redis.")
try:
    worker_redis_client = redis.Redis.from_url(REDIS_URL_WORKER, decode_responses=True)
    worker_redis_client.ping()
    logger.info("Worker successfully connected to Redis.")
except redis.exceptions.ConnectionError as e:
    logger.critical(f"Worker ERROR: Could not connect to Redis at {REDIS_URL_WORKER}: {e}")
    raise

async def get_next_task_from_queue() -> Optional[Task]:
    try:
        task_id_tuple = worker_redis_client.blpop("sheikh_computer:task_queue", timeout=TASK_POLLING_INTERVAL)
        if not task_id_tuple:
            return None
        
        task_id = task_id_tuple[1]
        
        task_json = worker_redis_client.get(f"task:{task_id}")
        if not task_json:
            logger.warning(f"Task ID {task_id} found in queue but not in task store. Skipping.")
            return None
        
        task = Task.model_validate_json(task_json)
        return task
    except Exception as e:
        logger.error(f"Error getting task from queue: {e}", exc_info=True)
        return None

async def update_task_state_api(task_id: str, update_data: TaskUpdate):
    try:
        async with httpx.AsyncClient() as client:
            response = await client.put(
                f"{API_SERVER_URL}/api/tasks/{task_id}",
                json=update_data.model_dump(mode="json", exclude_unset=True)
            )
            response.raise_for_status()
            logger.info(f"API: Task {task_id} state updated to {update_data.status.value}.")
    except httpx.HTTPStatusError as e:
        logger.error(f"API HTTP error updating task {task_id} state: {e.response.status_code} - {e.response.text}")
    except httpx.RequestError as e:
        logger.error(f"API Network error updating task {task_id} state: {e}")
    except Exception as e:
        logger.error(f"API Unexpected error updating task {task_id} state: {e}", exc_info=True)

async def process_single_task_wrapper(task: Task):
    async with task_semaphore:
        logger.info(f"Processing task {task.id} (Priority: {task.priority.name}, Retries: {task.current_retries})")
        start_time = datetime.now(timezone.utc)
        
        await update_task_state_api(task.id, TaskUpdate(status=TaskStatus.RUNNING, last_attempt_at=start_time))
        
        try:
            for dep_id in task.dependencies:
                try:
                    async with httpx.AsyncClient() as client:
                        dep_task_response = await client.get(f"{API_SERVER_URL}/api/tasks/{dep_id}")
                        dep_task_response.raise_for_status()
                        dep_task = Task.model_validate_json(dep_task_response.text)
                        if dep_task.status != TaskStatus.COMPLETED:
                            raise Exception(f"Dependency task {dep_id} not completed. Current status: {dep_task.status.value}")
                except httpx.HTTPStatusError as e:
                    if e.response.status_code == 404:
                        raise Exception(f"Dependency task {dep_id} not found.")
                    else:
                        raise
                except Exception as e:
                    raise Exception(f"Failed to check dependency {dep_id}: {e}")

            result_content = await sheikh_computer_core.execute_task(task)
            
            end_time = datetime.now(timezone.utc)
            execution_duration = (end_time - start_time).total_seconds()

            await update_task_state_api(
                task.id,
                TaskUpdate(
                    status=TaskStatus.COMPLETED,
                    execution_time=execution_duration,
                    result_content=result_content
                )
            )
            logger.info(f"Task {task.id} completed successfully in {execution_duration:.2f}s.")

        except Exception as e:
            end_time = datetime.now(timezone.utc)
            execution_duration = (end_time - start_time).total_seconds()
            
            task.current_retries += 1
            new_status = TaskStatus.FAILED
            error_message = f"Task execution failed: {e}"

            if task.current_retries < task.max_retries:
                logger.warning(f"Task {task.id} failed, retrying ({task.current_retries}/{task.max_retries}). Error: {error_message}")
                new_status = TaskStatus.QUEUED
                worker_redis_client.rpush("sheikh_computer:task_queue", task.id)
            else:
                logger.error(f"Task {task.id} permanently failed after {task.max_retries} retries. Error: {error_message}", exc_info=True)
                new_status = TaskStatus.FAILED
            
            await update_task_state_api(
                task.id,
                TaskUpdate(
                    status=new_status,
                    current_retries=task.current_retries,
                    execution_time=execution_duration,
                    error=error_message
                )
            )
        finally:
            if task.id in active_tasks_futures:
                del active_tasks_futures[task.id]

async def worker_main_loop():
    logger.info("Sheikh Computer Worker starting main loop...")
    while True:
        try:
            if task_semaphore.locked():
                logger.debug(f"Concurrency limit ({MAX_CONCURRENT_TASKS}) reached. Waiting for a task to finish.")
                await asyncio.sleep(1)
                continue
            
            task = await get_next_task_from_queue()
            
            if task:
                if task.id in active_tasks_futures:
                    logger.warning(f"Task {task.id} already in active_tasks_futures, skipping.")
                    continue
                
                if task.scheduled_at and datetime.now(timezone.utc) < task.scheduled_at:
                    logger.info(f"Task {task.id} is scheduled for future ({task.scheduled_at}). Requeuing for later.")
                    worker_redis_client.rpush("sheikh_computer:task_queue", task.id)
                    continue

                task_future = asyncio.create_task(process_single_task_wrapper(task))
                active_tasks_futures[task.id] = task_future
            else:
                logger.debug("No new tasks in queue after polling.")
            
            logger.info(f"Worker Status: Active Tasks: {len(active_tasks_futures)} (Available Capacity: {task_semaphore._value})")

        except Exception as e:
            logger.error(f"Error in worker main loop: {e}", exc_info=True)
        

if __name__ == "__main__":
    from pathlib import Path
    Path("logs").mkdir(exist_ok=True) # Ensure logs directory exists
    
    try:
        asyncio.run(worker_main_loop())
    except KeyboardInterrupt:
        logger.info("Worker gracefully shutting down...")
    except Exception as e:
        logger.critical(f"Worker crashed: {e}", exc_info=True)
    finally:
        asyncio.run(sheikh_computer_core.close_all_sessions())
        logger.info("All browser sessions closed. Worker stopped.")
' > worker_server/main.py
echo -e "${GREEN}   worker_server/ populated.${NC}"
echo ""

# cli files
echo -e "${YELLOW}   Populating cli/...${NC}"
echo 'sheikh_core @ file:../sheikh_core
redis
pydantic
python-dotenv
pyyaml
httpx
' > cli/requirements.txt
echo '#!/usr/bin/env python3
"""
Sheikh Computer CLI - Command Line Interface
Advanced browser automation with intelligent task management
"""

import argparse
import asyncio
import json
import sys
import time
import os
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import List, Optional
import yaml
import redis
import httpx # For making HTTP requests to the API server

# Import from sheikh_core directly
from sheikh_core import SheikhComputer, TaskPriority, TaskStatus, Task, NewTaskRequest, TaskUpdate, BrowserConfig

class SheikhCLI:
    """Command Line Interface for Sheikh Computer"""
    
    def __init__(self):
        self.sheikh = None # SheikhComputer instance, initialized later
        self.config_file = "sheikh_config.json" # SheikhComputer uses JSON config now
        
        # Initialize Redis client for CLI (same Redis as API/Worker)
        REDIS_URL_CLI = os.getenv("REDIS_URL")
        if not REDIS_URL_CLI:
            print("❌ REDIS_URL environment variable is not set. CLI cannot connect to Redis.")
            sys.exit(1)
        try:
            self.redis_client = redis.Redis.from_url(REDIS_URL_CLI, decode_responses=True)
            self.redis_client.ping() # Test connection
            print("CLI successfully connected to Redis.")
        except redis.exceptions.ConnectionError as e:
            print(f"❌ CLI ERROR: Could not connect to Redis at {REDIS_URL_CLI}: {e}")
            sys.exit(1)
    
    async def initialize(self):
        """Initialize Sheikh Computer instance"""
        try:
            self.sheikh = SheikhComputer(config_path=self.config_file)
            print("✨ Sheikh Computer core initialized successfully")
        except Exception as e:
            print(f"❌ Failed to initialize Sheikh Computer core: {e}")
            sys.exit(1)
    
    def create_parser(self) -> argparse.ArgumentParser:
        """Create argument parser for CLI"""
        parser = argparse.ArgumentParser(
            description="Sheikh Computer - Advanced Browser Automation Platform CLI",
            formatter_class=argparse.RawDescriptionHelpFormatter,
            epilog="""
Examples:
  sheikh task add "Check my Gmail inbox" --browser mobile_usa
  sheikh task run --task-id <id_prefix>
  sheikh schedule today --browsers mobile_usa,mobile_eu
  sheikh search "AI news" --regions primary_desktop,mobile_usa
  sheikh monitor "https://news.ycombinator.com" --interval 300 --continuous
  sheikh status
  sheikh config show
  sheikh results show --task-id <id_prefix>
  sheikh results export my_results.json --task-id <id_prefix>
            """
        )
        
        subparsers = parser.add_subparsers(dest="command", help="Available commands")
        
        # Task management commands
        task_parser = subparsers.add_parser("task", help="Task management")
        task_subparsers = task_parser.add_subparsers(dest="task_action", required=True)
        
        # Add task
        add_task = task_subparsers.add_parser("add", help="Add a new task")
        add_task.add_argument("description", help="Task description")
        add_task.add_argument("--browser", dest="browser_config_name", default="primary_desktop", 
                             help="Browser configuration to use (e.g., primary_desktop, mobile_usa)")
        add_task.add_argument("--priority", choices=["low", "medium", "high", "critical"],
                             default="medium", help="Task priority")
        add_task.add_argument("--timeout", type=int, default=300,
                             help="Task timeout in seconds")
        add_task.add_argument("--retries", type=int, default=3,
                             help="Maximum retry attempts")
        add_task.add_argument("--schedule", help="Schedule task (YYYY-MM-DD HH:MM Z, e.g., 2023-12-31 23:59 UTC)")
        add_task.add_argument("--actions", help="Path to a JSON file with initial actions")
        add_task.add_argument("--prompt", help="Path to a text file with custom system prompt")
        add_task.add_argument("--deps", help="Comma-separated task IDs this task depends on")
        
        # Run tasks (CLI will trigger worker by updating task status, or by pushing to a dedicated "run now" queue)
        run_task = task_subparsers.add_parser("run", help="(Local only) Trigger local execution of a specific task by ID for debugging.")
        run_task.add_argument("--task-id", required=True, help="Task ID to run immediately.")
        
        # List tasks
        list_tasks = task_subparsers.add_parser("list", help="List tasks and their statuses")
        list_tasks.add_argument("--status", choices=[s.value for s in TaskStatus],
                               default=None, help="Filter by task status")
        list_tasks.add_argument("--limit", type=int, default=10, help="Limit number of tasks displayed")
        
        # Cancel task
        cancel_task = task_subparsers.add_parser("cancel", help="Cancel a running or queued task")
        cancel_task.add_argument("task_id", help="Task ID to cancel")
        
        # Schedule commands (These will typically just add tasks to the main queue)
        schedule_parser = subparsers.add_parser("schedule", help="Add pre-defined schedule tasks")
        schedule_parser.add_argument("period", choices=["today", "tomorrow", "weekly"],
                                   help="Schedule period to fetch/add tasks for")
        schedule_parser.add_argument("--browsers", default="mobile_usa,mobile_eu",
                                   help="Comma-separated browser configs to use for schedule tasks")
        
        # Search commands
        search_parser = subparsers.add_parser("search", help="Perform multi-region web search")
        search_parser.add_argument("query", help="Search query")
        search_parser.add_argument("--regions", default="primary_desktop,mobile_usa",
                                 help="Comma-separated browser configs for regions")
        search_parser.add_argument("--analyze", action="store_true",
                                 help="Add an analysis task for search results")
        
        # Monitor commands
        monitor_parser = subparsers.add_parser("monitor", help="Set up continuous website monitoring")
        monitor_parser.add_argument("urls", nargs="+", help="URLs to monitor")
        monitor_parser.add_argument("--interval", type=int, default=300,
                                  help="Monitoring interval in seconds")
        monitor_parser.add_argument("--continuous", action="store_true",
                                  help="Run continuous monitoring locally (blocking)")
        
        # Status command
        status_parser = subparsers.add_parser("status", help="Show system status and queued tasks")
        status_parser.add_argument("--detailed", action="store_true",
                                 help="Show detailed status of active browser sessions and recent results")
        
        # Configuration commands
        config_parser = subparsers.add_parser("config", help="Manage Sheikh Computer configurations")
        config_subparsers = config_parser.add_subparsers(dest="config_action", required=True)
        
        config_subparsers.add_parser("show", help="Show current Sheikh Computer configuration (browser configs)")
        config_subparsers.add_parser("reset", help="Reset browser configurations to default (WARNING: This will overwrite sheikh_config.json)")
        
        add_browser_config = config_subparsers.add_parser("browser_add", help="Add/Update a custom browser configuration")
        add_browser_config.add_argument("--name", required=True, help="Name of the browser configuration")
        add_browser_config.add_argument("--timezone", default="UTC", help="Timezone ID (e.g., America/New_York)")
        add_browser_config.add_argument("--device", default="desktop", help="Device type (e.g., desktop, iPhone 13, Pixel 5)")
        add_browser_config.add_argument("--stealth", action="store_true", help="Enable stealth mode (anti-bot detection)")
        add_browser_config.add_argument("--headless", action="store_true", help="Run browser in headless mode (no UI)")
        add_browser_config.add_argument("--viewport", help="Viewport dimensions WxH (e.g., 1920x1080)")
        add_browser_config.add_argument("--user-data-dir", help="Path to user data directory for persistent sessions")
        add_browser_config.add_argument("--storage-state", help="Path to storage state JSON file for cookies/local storage")
        add_browser_config.add_argument("--allowed-domains", help="Comma-separated list of domains agent can access")
        add_browser_config.add_argument("--exec-path", help="Path to browser executable (e.g., /usr/bin/google-chrome)")
        
        remove_browser_config = config_subparsers.add_parser("browser_remove", help="Remove a custom browser configuration")
        remove_browser_config.add_argument("name", help="Name of the browser configuration to remove")

        # Results command
        results_parser = subparsers.add_parser("results", help="View and export task results")
        results_subparsers = results_parser.add_subparsers(dest="results_action", required=True)

        show_results = results_subparsers.add_parser("show", help="Show recent task results")
        show_results.add_argument("--task-id", help="Filter results by task ID prefix")
        show_results.add_argument("--limit", type=int, default=5, help="Limit number of results displayed")

        export_results = results_subparsers.add_parser("export", help="Export task results to a file")
        export_results.add_argument("output_file", help="Path to output file (e.g., results.json, results.yaml, results.csv)")
        export_results.add_argument("--task-id", help="Filter results by task ID prefix")
        export_results.add_argument("--format", choices=["json", "yaml", "csv"],
                                  help="Export format (default inferred from file extension)")
        
        # Interactive mode
        subparsers.add_parser("interactive", help="Start interactive mode")
        
        return parser
    
    # Helper to send task updates to API server
    async def _send_task_update(self, task_id: str, update_data: dict):
        api_url = os.getenv("API_SERVER_URL")
        if not api_url:
            print("❌ API_SERVER_URL is not set. Cannot update task status.")
            return

        try:
            async with httpx.AsyncClient() as client:
                response = await client.put(f"{api_url}/api/tasks/{task_id}", json=update_data)
                response.raise_for_status()
                print(f"✅ Task {task_id} status updated via API.")
        except httpx.HTTPStatusError as e:
            print(f"❌ API error updating task {task_id}: {e.response.status_code} - {e.response.text}")
        except httpx.RequestError as e:
            print(f"❌ Network error updating task {task_id}: {e}")
        except Exception as e:
            print(f"❌ Unexpected error updating task {task_id}: {e}")

    async def handle_task_add(self, args):
        """Handle task add command"""
        try:
            priority_map = {
                "low": TaskPriority.LOW,
                "medium": TaskPriority.MEDIUM,
                "high": TaskPriority.HIGH,
                "critical": TaskPriority.CRITICAL
            }
            
            initial_actions = []
            if args.actions:
                with open(args.actions, "r") as f:
                    initial_actions = json.load(f)
            
            custom_prompt = None
            if args.prompt:
                with open(args.prompt, "r") as f:
                    custom_prompt = f.read()
            
            scheduled_at = None
            if args.schedule:
                try:
                    scheduled_at = datetime.strptime(args.schedule, "%Y-%m-%d %H:%M %Z").replace(tzinfo=timezone.utc)
                except ValueError:
                    print("❌ Invalid schedule format. Use YYYY-MM-DD HH:MM Z (e.g., 2023-12-31 23:59 UTC)")
                    return

            dependencies = []
            if args.deps:
                dependencies = [dep.strip() for dep in args.deps.split(",") if dep.strip()]
            
            task_obj = NewTaskRequest(
                description=args.description,
                browser_config_name=args.browser_config_name,
                priority=priority_map[args.priority],
                initial_actions=initial_actions,
                custom_prompt=custom_prompt,
                scheduled_at=scheduled_at,
                max_retries=args.retries,
                timeout=args.timeout,
                dependencies=dependencies
            )

            api_url = os.getenv("API_SERVER_URL")
            if not api_url:
                print("❌ API_SERVER_URL is not set. Cannot add task.")
                return

            async with httpx.AsyncClient() as client:
                response = await client.post(f"{api_url}/api/tasks", json=task_obj.model_dump(mode="json"))
                response.raise_for_status()
                response_data = response.json()
                task_id = response_data["id"]
            
            print(f"✅ Task added successfully: {task_id}")
            print(f"   Description: {args.description}")
            print(f"   Browser: {args.browser_config_name}")
            print(f"   Priority: {args.priority}")
            print(f"   Status: QUEUED (awaiting worker execution)")
            
        except Exception as e:
            print(f"❌ Failed to add task: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")
    
    async def handle_task_run(self, args):
        """
        Handle task run command (direct execution via CLI for testing, NOT for production queue processing)
        This is primarily for development/debugging a specific task directly.
        The worker_server/main.py is responsible for running tasks from the queue.
        """
        if not args.task_id:
            print("❌ Please provide a task ID to run directly. For general queue processing, start the worker_server.")
            return

        print(f"⚠️  Running task {args.task_id} directly via CLI. This bypasses the main queue system and is for local testing/debugging only.")
        
        try:
            api_url = os.getenv("API_SERVER_URL")
            async with httpx.AsyncClient() as client:
                response = await client.get(f"{api_url}/api/tasks/{args.task_id}")
                response.raise_for_status()
                task = Task.model_validate_json(response.text)
            
            print(f"🚀 Executing task {task.id}: {task.description}")
            start_time = time.time()
            
            await self._send_task_update(task.id, {"status": TaskStatus.RUNNING.value, "last_attempt_at": datetime.now(timezone.utc).isoformat()})

            result_content = await self.sheikh.execute_task(task)
            
            execution_time = time.time() - start_time
            
            update_data = {
                "status": TaskStatus.COMPLETED.value,
                "execution_time": execution_time,
                "result_content": result_content.model_dump(mode="json")
            }
            await self._send_task_update(task.id, update_data)
            
            print(f"\n📊 Task {task.id} completed successfully in {execution_time:.2f}s")
            print(f"   Final Result: {result_content.final_result}")
            
        except Exception as e:
            execution_time = time.time() - start_time if "start_time" in locals() else 0.0
            error_msg = f"Failed to run task locally: {e}"
            await self._send_task_update(task.id, {"status": TaskStatus.FAILED.value, "error": error_msg, "execution_time": execution_time})
            print(f"❌ {error_msg}")
    
    async def handle_task_list(self, args):
        """Handle task list command"""
        try:
            api_url = os.getenv("API_SERVER_URL")
            async with httpx.AsyncClient() as client:
                response = await client.get(f"{api_url}/api/tasks")
                response.raise_for_status()
                all_tasks_data = response.json()
            
            tasks = []
            for task_data in all_tasks_data:
                try:
                    task = Task(**task_data)
                    if args.status is None or task.status.value == args.status:
                        tasks.append(task)
                except Exception as e:
                    print(f"⚠️  Skipping malformed task from API: {task_data}. Error: {e}")
            
            tasks.sort(key=lambda t: t.created_at, reverse=True)
            
            if not tasks:
                print("📋 No tasks found matching criteria.")
                return
            
            print(f"📋 Tasks ({len(tasks)} found, showing top {args.limit}):")
            for i, task in enumerate(tasks[:args.limit]):
                priority_emoji = {
                    TaskPriority.LOW: "🔵",
                    TaskPriority.MEDIUM: "🟡", 
                    TaskPriority.HIGH: "🟠",
                    TaskPriority.CRITICAL: "🔴"
                }.get(task.priority, "⚪")
                
                status_emoji = {
                    TaskStatus.QUEUED: "➡️",
                    TaskStatus.RUNNING: "🔄",
                    TaskStatus.COMPLETED: "✅",
                    TaskStatus.FAILED: "❌",
                    TaskStatus.PAUSED: "⏸️"
                }.get(task.status, "❓")

                created_time = task.created_at.strftime("%Y-%m-%d %H:%M")
                
                print(f"   {i+1}. {status_emoji} {priority_emoji} {task.id[:8]}... ")
                print(f"      Description: {task.description[:70]}...")
                print(f"      Status: {task.status.value.upper()} | Browser: {task.browser_config_name} | Created: {created_time}")
                if task.error:
                    print(f"      Error: {task.error[:60]}...")
                if task.scheduled_at:
                    print(f"      Scheduled: {task.scheduled_at.strftime('%Y-%m-%d %H:%M %Z')}")
                if task.dependencies:
                    print(f"      Dependencies: {', '.join([dep[:8] for dep in task.dependencies])}")
                if task.current_retries > 0:
                    print(f"      Retries: {task.current_retries}/{task.max_retries}")
                print("-" * 75)
                
        except Exception as e:
            print(f"❌ Failed to list tasks: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")
    
    async def handle_task_cancel(self, args):
        """Handle task cancel command"""
        print(f"Attempting to cancel task: {args.task_id}...")
        try:
            await self._send_task_update(args.task_id, {"status": TaskStatus.FAILED.value, "error": "Task cancelled by user."})
            self.redis_client.lrem("sheikh_computer:task_queue", 0, args.task_id)
            print(f"✅ Task {args.task_id} marked as CANCELLED.")
            print("Note: The running worker may take some time to stop processing this task if it already started.")
        except Exception as e:
            print(f"❌ Failed to cancel task {args.task_id}: {e}")

    async def handle_schedule(self, args):
        """Handle schedule command - adds tasks to queue"""
        try:
            browsers = [b.strip() for b in args.browsers.split(",") if b.strip()]
            
            tasks_to_add = []
            if args.period == "today":
                for browser in browsers:
                    tasks_to_add.append(NewTaskRequest(
                        description=f"Check today's calendar for {browser}",
                        browser_config_name=browser,
                        priority=TaskPriority.HIGH,
                        initial_actions=[{"go_to_url": {"url": "https://calendar.google.com", "new_tab": True}}]
                    ))
                print(f"📅 Adding 'today's schedule' tasks for {len(browsers)} browsers...")
            elif args.period == "tomorrow":
                tomorrow = datetime.now(timezone.utc) + timedelta(days=1)
                for browser in browsers:
                    tasks_to_add.append(NewTaskRequest(
                        description=f"Prepare tomorrow's briefing using {browser}",
                        browser_config_name=browser,
                        priority=TaskPriority.HIGH,
                        scheduled_at=tomorrow.replace(hour=9, minute=0, second=0, microsecond=0)
                    ))
                print(f"📅 Adding 'tomorrow's briefing' tasks for {len(browsers)} browsers...")
            elif args.period == "weekly":
                for browser in browsers:
                    tasks_to_add.append(NewTaskRequest(
                        description=f"Generate weekly market report using {browser}",
                        browser_config_name=browser,
                        priority=TaskPriority.MEDIUM,
                        scheduled_at=datetime.now(timezone.utc) + timedelta(days=7)
                    ))
                print(f"📅 Adding 'weekly report' tasks for {len(browsers)} browsers...")

            api_url = os.getenv("API_SERVER_URL")
            if not api_url:
                print("❌ API_SERVER_URL is not set. Cannot add schedule tasks.")
                return

            added_count = 0
            async with httpx.AsyncClient() as client:
                for task_req in tasks_to_add:
                    response = await client.post(f"{api_url}/api/tasks", json=task_req.model_dump(mode="json"))
                    response.raise_for_status()
                    added_count += 1
            
            print(f"✅ Added {added_count} schedule tasks to the queue.")
            print("   The worker will pick them up as scheduled.")
            
        except Exception as e:
            print(f"❌ Failed to handle schedule command: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")
    
    async def handle_search(self, args):
        """Handle search command - adds tasks to queue"""
        try:
            regions = [r.strip() for r in args.regions.split(",") if r.strip()]
            if not regions:
                print("❌ No regions specified for search.")
                return

            api_url = os.getenv("API_SERVER_URL")
            if not api_url:
                print("❌ API_SERVER_URL is not set. Cannot add search tasks.")
                return
                
            task_ids = []
            async with httpx.AsyncClient() as client:
                for region_config_name in regions:
                    search_task_req = NewTaskRequest(
                        description=f"Search for \"{args.query}\" in region \"{region_config_name}\"",
                        browser_config_name=region_config_name,
                        priority=TaskPriority.MEDIUM,
                        initial_actions=[
                            {"go_to_url": {"url": "https://www.google.com", "new_tab": True}},
                            {"type_text": {"text": args.query, "selector": "[name=\"q\"]"}},
                            {"press_key": {"key": "Enter"}}
                        ]
                    )
                    response = await client.post(f"{api_url}/api/tasks", json=search_task_req.model_dump(mode="json"))
                    response.raise_for_status()
                    task_ids.append(response.json()["id"])
            
            print(f"✅ Added {len(task_ids)} search tasks to the queue.")
            
            if args.analyze:
                analysis_prompt = f"""
                You are analyzing search results for the query: \"{args.query}\"
                
                Compare results across different regions (from tasks: {", ".join([tid[:8] for tid in task_ids])}...) and provide insights on:
                1. Regional differences in search results
                2. Common themes and trends
                3. Notable variations or biases
                4. Summary of key findings
                
                Provide a comprehensive analysis report.
                """
                analysis_task_req = NewTaskRequest(
                    description=f"Analyze search results for \"{args.query}\"",
                    browser_config_name="primary_desktop",
                    priority=TaskPriority.HIGH,
                    custom_prompt=analysis_prompt,
                    dependencies=task_ids
                )
                async with httpx.AsyncClient() as client:
                    response = await client.post(f"{api_url}/api/tasks", json=analysis_task_req.model_dump(mode="json"))
                    response.raise_for_status()
                    analysis_id = response.json()["id"]
                print(f"✅ Added analysis task {analysis_id[:8]}... (depends on previous search tasks)")
            
            print("   The worker will pick them up and execute.")
            
        except Exception as e:
            print(f"❌ Failed to create search tasks: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")
    
    async def handle_monitor(self, args):
        """Handle monitor command - adds tasks to queue or runs continuously"""
        try:
            if not args.urls:
                print("❌ No URLs provided for monitoring.")
                return

            api_url = os.getenv("API_SERVER_URL")
            if not api_url:
                print("❌ API_SERVER_URL is not set. Cannot add monitoring tasks.")
                return

            if args.continuous:
                print(f"🔄 Running continuous monitoring locally for {len(args.urls)} websites (interval: {args.interval}s)")
                print("   This will block your CLI. Press Ctrl+C to stop.")
                
                while True:
                    monitor_task_ids = []
                    async with httpx.AsyncClient() as client:
                        for i, website in enumerate(args.urls):
                            browser_configs_names = list(self.sheikh.browser_configs.keys())
                            if not browser_configs_names:
                                print("❌ No browser configurations found for monitoring.")
                                return
                            browser_config_name = browser_configs_names[i % len(browser_configs_names)]

                            monitor_task_req = NewTaskRequest(
                                description=f"Monitor {website} for changes (continuous)",
                                browser_config_name=browser_config_name,
                                priority=TaskPriority.LOW,
                                initial_actions=[
                                    {"go_to_url": {"url": website, "new_tab": True}},
                                    {"wait": {"time": 2}},
                                    {"scroll_down": {"amount": 1000}}
                                ]
                            )
                            response = await client.post(f"{api_url}/api/tasks", json=monitor_task_req.model_dump(mode="json"))
                            response.raise_for_status()
                            monitor_task_ids.append(response.json()["id"])
                    
                    print(f"✅ Added {len(monitor_task_ids)} monitoring tasks to queue for this cycle.")
                    print(f"⏳ Waiting {args.interval} seconds until next check...")
                    await asyncio.sleep(args.interval)
            else:
                task_ids = []
                async with httpx.AsyncClient() as client:
                    for i, website in enumerate(args.urls):
                        browser_configs_names = list(self.sheikh.browser_configs.keys())
                        if not browser_configs_names:
                            print("❌ No browser configurations found for monitoring.")
                            return
                        browser_config_name = browser_configs_names[i % len(browser_configs_names)]
                        
                        monitor_task_req = NewTaskRequest(
                            description=f"Monitor {website} for changes (one-time)",
                            browser_config_name=browser_config_name,
                            priority=TaskPriority.LOW,
                            initial_actions=[
                                {"go_to_url": {"url": website, "new_tab": True}},
                                {"wait": {"time": 2}},
                                {"scroll_down": {"amount": 1000}}
                            ]
                        )
                        response = await client.post(f"{api_url}/api/tasks", json=monitor_task_req.model_dump(mode="json"))
                        response.raise_for_status()
                        task_ids.append(response.json()["id"])
                print(f"✅ Added {len(task_ids)} one-time monitoring tasks to the queue.")
                print("   The worker will pick them up and execute.")
                
        except KeyboardInterrupt:
            print("\n⏹️  Monitoring stopped by user")
        except Exception as e:
            print(f"❌ Failed to setup monitoring: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")
    
    async def handle_status(self, args):
        """Handle status command"""
        try:
            api_url = os.getenv("API_SERVER_URL")
            async with httpx.AsyncClient() as client:
                response = await client.get(f"{api_url}/api/tasks")
                response.raise_for_status()
                all_tasks_data = response.json()
            
            queued_tasks = [t for t in all_tasks_data if Task(id="", **t).status == TaskStatus.QUEUED]
            running_tasks = [t for t in all_tasks_data if Task(id="", **t).status == TaskStatus.RUNNING]
            completed_tasks = [t for t in all_tasks_data if Task(id="", **t).status == TaskStatus.COMPLETED]
            failed_tasks = [t for t in all_tasks_data if Task(id="", **t).status == TaskStatus.FAILED]

            print("💻 Sheikh Computer System Status")
            print("=" * 40)
            print(f"🚀 Tasks Queued: {len(queued_tasks)}")
            print(f"🔄 Tasks Running: {len(running_tasks)}")
            print(f"✅ Tasks Completed: {len(completed_tasks)}")
            print(f"❌ Tasks Failed: {len(failed_tasks)}")
            print(f"Total Tasks in DB: {len(all_tasks_data)}")
            
            if args.detailed:
                print(f"\n🌐 Configured Browser Profiles:")
                if not self.sheikh.browser_configs:
                    print("   No browser configurations found.")
                for name, config in self.sheikh.browser_configs.items():
                    print(f"   - {name} ({'Headless' if config.headless else 'UI'}, {config.device_type}, {config.timezone_id})")
                
                if completed_tasks or failed_tasks:
                    recent_results_data = sorted([t for t in all_tasks_data if t["status"] in [TaskStatus.COMPLETED.value, TaskStatus.FAILED.value]], key=lambda t: t["created_at"], reverse=True)[:5]
                    
                    print(f"\n📊 Recent Task Results (last {len(recent_results_data)}):")
                    for task_data in recent_results_data:
                        try:
                            result_task = Task(**task_data)
                            status_emoji = "✅" if result_task.status == TaskStatus.COMPLETED else "❌"
                            print(f"   {status_emoji} {result_task.id[:8]}... : {result_task.description[:50]}...")
                            print(f"      Status: {result_task.status.value.upper()} | Time: {result_task.execution_time:.2f}s")
                            if result_task.error:
                                print(f"      Error: {result_task.error[:70]}...")
                            elif result_task.result_content and result_task.result_content.final_result:
                                print(f"      Result: {str(result_task.result_content.final_result)[:70]}...")
                        except Exception as e:
                            print(f"⚠️  Error parsing recent task data: {task_data}. Error: {e}")
                
        except Exception as e:
            print(f"❌ Failed to get status: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")
    
    async def handle_config_show(self):
        """Show current configuration"""
        try:
            print("⚙️  Sheikh Computer Configuration")
            print("=" * 40)
            
            if not self.sheikh.browser_configs:
                print("No browser configurations found. Use \"sheikh config browser_add\" to add some.")
                return

            for name, config in self.sheikh.browser_configs.items():
                print(f"\n🌐 Browser Config: {name}")
                print(f"   Timezone ID: {config.timezone_id}")
                print(f"   Device Type: {config.device_type}")
                print(f"   Stealth Mode: {'Yes' if config.stealth else 'No'}")
                print(f"   Headless Mode: {'Yes' if config.headless else 'No'}")
                if config.viewport:
                    print(f"   Viewport: {config.viewport['width']}x{config.viewport['height']}")
                if config.user_data_dir:
                    print(f"   User Data Dir: {config.user_data_dir}")
                if config.storage_state:
                    print(f"   Storage State: {config.storage_state}")
                if config.allowed_domains:
                    print(f"   Allowed Domains: {', '.join(config.allowed_domains)}")
                if config.executable_path:
                    print(f"   Executable Path: {config.executable_path}")
                    
        except Exception as e:
            print(f"❌ Failed to show configuration: {e}")

    async def handle_config_reset(self):
        """Reset configurations to default"""
        print("⚠️  WARNING: This will reset all browser configurations to default and overwrite your sheikh_config.json!")
        confirm = input("Are you sure you want to continue? (yes/no): ")
        if confirm.lower() == "yes":
            try:
                self.sheikh._create_default_config()
                print("✅ Browser configurations reset to default.")
            except Exception as e:
                print(f"❌ Failed to reset configurations: {e}")
        else:
            print("Action cancelled.")

    async def handle_browser_config_add(self, args):
        """Add/Update a custom browser configuration"""
        try:
            config_name = args.name
            viewport = None
            if args.viewport:
                try:
                    w, h = map(int, args.viewport.split("x"))
                    viewport = {"width": w, "height": h}
                except ValueError:
                    print("❌ Invalid viewport format. Use WxH (e.g., 1920x1080)")
                    return
            
            allowed_domains = None
            if args.allowed_domains:
                allowed_domains = [d.strip() for d in args.allowed_domains.split(",") if d.strip()]

            new_config = BrowserConfig(
                name=config_name,
                timezone_id=args.timezone,
                device_type=args.device,
                stealth=args.stealth,
                headless=args.headless,
                viewport=viewport,
                user_data_dir=args.user_data_dir,
                storage_state=args.storage_state,
                allowed_domains=allowed_domains,
                executable_path=args.exec_path
            )
            
            self.sheikh.browser_configs[config_name] = new_config
            self.sheikh._save_config()
            print(f"✅ Browser configuration \"{config_name}\" added/updated successfully.")
        except Exception as e:
            print(f"❌ Failed to add/update browser configuration: {e}")

    async def handle_browser_config_remove(self, args):
        """Remove a custom browser configuration"""
        try:
            config_name = args.name
            if config_name in self.sheikh.browser_configs:
                del self.sheikh.browser_configs[config_name]
                self.sheikh._save_config()
                print(f"✅ Browser configuration \"{config_name}\" removed successfully.")
            else:
                print(f"❌ Browser configuration \"{config_name}\" not found.")
        except Exception as e:
            print(f"❌ Failed to remove browser configuration: {e}")
    
    async def handle_results_show(self, args):
        """Show recent task results"""
        try:
            api_url = os.getenv("API_SERVER_URL")
            async with httpx.AsyncClient() as client:
                response = await client.get(f"{api_url}/api/tasks")
                response.raise_for_status()
                all_tasks_data = response.json()
            
            results_to_show = []
            for task_data in all_tasks_data:
                try:
                    task = Task(**task_data)
                    if task.status in [TaskStatus.COMPLETED, TaskStatus.FAILED]:
                        if args.task_id is None or task.id.startswith(args.task_id):
                            results_to_show.append(task)
                except Exception as e:
                    print(f"⚠️  Skipping malformed result from API: {task_data}. Error: {e}")
            
            results_to_show.sort(key=lambda t: t.created_at, reverse=True)
            results_to_show = results_to_show[:args.limit]

            if not results_to_show:
                print("📊 No results found matching criteria.")
                return
            
            print(f"📊 Task Results ({len(results_to_show)} found, showing top {args.limit}):")
            print("=" * 50)
            
            for result_task in results_to_show:
                status_emoji = "✅" if result_task.status == TaskStatus.COMPLETED else "❌"
                print(f"\n{status_emoji} Task: {result_task.id}")
                print(f"   Description: {result_task.description[:70]}...")
                print(f"   Status: {result_task.status.value.upper()}")
                print(f"   Time: {result_task.execution_time:.2f}s")
                
                if result_task.result_content:
                    if result_task.result_content.urls_visited:
                        print(f"   URLs visited: {len(result_task.result_content.urls_visited)}")
                        for url in result_task.result_content.urls_visited[:3]:
                            print(f"      • {url}")
                        if len(result_task.result_content.urls_visited) > 3:
                            print(f"      ... and {len(result_task.result_content.urls_visited) - 3} more")
                    
                    if result_task.result_content.screenshots:
                        print(f"   Screenshots: {len(result_task.result_content.screenshots)} taken (Base64 data not shown)")
                    
                    if result_task.error:
                        print(f"   ❌ Error: {result_task.error}")
                    elif result_task.result_content.final_result:
                        result_str = str(result_task.result_content.final_result)[:200]
                        print(f"   📄 Result: {result_str}...")
                print("-" * 75)
                
        except Exception as e:
            print(f"❌ Failed to show results: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")

    async def handle_results_export(self, args):
        """Export task results to file"""
        try:
            api_url = os.getenv("API_SERVER_URL")
            async with httpx.AsyncClient() as client:
                response = await client.get(f"{api_url}/api/tasks")
                response.raise_for_status()
                all_tasks_data = response.json()
            
            results_to_export = []
            for task_data in all_tasks_data:
                try:
                    task = Task(**task_data)
                    if task.status in [TaskStatus.COMPLETED, TaskStatus.FAILED]:
                        if args.task_id is None or task.id.startswith(args.task_id):
                            results_to_export.append(task)
                except Exception as e:
                    print(f"⚠️  Skipping malformed task for export: {task_data}. Error: {e}")

            if not results_to_export:
                print("📊 No results found for export.")
                return
            
            export_path = Path(args.output_file)
            export_format = args.format if args.format else export_path.suffix[1:]

            if export_format not in ["json", "yaml", "csv"]:
                print("❌ Invalid export format. Choose from \"json\", \"yaml\", \"csv\" or provide a file extension.")
                return

            export_data = []
            for task_result in results_to_export:
                flat_data = {
                    "task_id": task_result.id,
                    "description": task_result.description,
                    "status": task_result.status.value,
                    "priority": task_result.priority.value,
                    "execution_time": task_result.execution_time,
                    "error": task_result.error,
                    "created_at": task_result.created_at.isoformat(),
                    "browser_config_name": task_result.browser_config_name,
                    "final_result": str(task_result.result_content.final_result) if task_result.result_content and task_result.result_content.final_result else None,
                    "urls_visited_count": len(task_result.result_content.urls_visited) if task_result.result_content else 0,
                    "screenshots_count": len(task_result.result_content.screenshots) if task_result.result_content else 0,
                    "extracted_content_summary": json.dumps(task_result.result_content.extracted_content) if task_result.result_content and task_result.result_content.extracted_content else None
                }
                export_data.append(flat_data)
            
            if export_format == "json":
                with open(export_path, "w") as f:
                    json.dump(export_data, f, indent=2)
            elif export_format == "yaml":
                with open(export_path, "w") as f:
                    yaml.dump(export_data, f, default_flow_style=False)
            elif export_format == "csv":
                import csv
                with open(export_path, "w", newline="") as f:
                    if export_data:
                        fieldnames = export_data[0].keys()
                        writer = csv.DictWriter(f, fieldnames=fieldnames)
                        writer.writeheader()
                        writer.writerows(export_data)
            
            print(f"📁 Results exported to: {export_path}")
            
        except Exception as e:
            print(f"❌ Failed to export results: {e}")
            if isinstance(e, httpx.HTTPStatusError):
                print(f"   API response: {e.response.text}")
    
    async def interactive_mode(self):
        """Start interactive mode"""
        print("🎮 Sheikh Computer Interactive Mode")
        print("Type \"help\" for available commands, \"quit\" to exit")
        print("=" * 50)
        
        while True:
            try:
                command_line = input("\nsheikh> ").strip()
                if not command_line:
                    continue

                if command_line.lower() in ["quit", "exit", "q"]:
                    break
                elif command_line.lower() == "help":
                    print("""
Available commands (simplified for interactive mode):
  add <description> [--browser <name>] [--priority <level>] - Add a new task
  run <task_id>                                             - Locally run a specific task (for debugging)
  list [--status <status>] [--limit N]                      - List tasks
  cancel <task_id>                                          - Cancel a task
  status [--detailed]                                       - Show system status
  schedule <period> [--browsers <names>]                    - Add predefined schedule tasks
  search <query> [--regions <names>] [--analyze]            - Multi-region search
  monitor <url(s)> [--interval N] [--continuous]            - Website monitoring
  results show [--task-id <id>] [--limit N]                 - Show recent results
  results export <file> [--task-id <id>] [--format <fmt>]   - Export results
  config show                                               - Show browser configs
  config browser_add --name <name> --timezone <tz> ...      - Add/update browser config
  config browser_remove <name>                              - Remove browser config
  clear                                                     - Clear screen
  quit                                                      - Exit interactive mode
                    """)
                elif command_line.lower() == "clear":
                    os.system("clear" if os.name == "posix" else "cls")
                else:
                    parts = command_line.split()
                    if not parts: continue
                    
                    cmd = parts[0]
                    args_list = parts[1:]

                    if cmd == "add":
                        description_parts = []
                        browser = "primary_desktop"
                        priority = "medium"
                        
                        i = 0
                        while i < len(args_list):
                            if args_list[i] == "--browser" and i + 1 < len(args_list):
                                browser = args_list[i+1]
                                i += 2
                            elif args_list[i] == "--priority" and i + 1 < len(args_list):
                                priority = args_list[i+1]
                                i += 2
                            else:
                                description_parts.append(args_list[i])
                                i += 1
                        
                        description = " ".join(description_parts)
                        if description:
                            mock_args = argparse.Namespace(
                                description=description, 
                                browser_config_name=browser, 
                                priority=priority,
                                timeout=300, retries=3, schedule=None, actions=None, prompt=None, deps=None
                            )
                            await self.handle_task_add(mock_args)
                        else:
                            print("❌ Please provide a task description.")

                    elif cmd == "run" and len(args_list) >= 1:
                        mock_args = argparse.Namespace(task_id=args_list[0])
                        await self.handle_task_run(mock_args)
                    
                    elif cmd == "list":
                        mock_args = argparse.Namespace(status=None, limit=10)
                        if "--status" in args_list:
                            try:
                                status_idx = args_list.index("--status")
                                if status_idx + 1 < len(args_list):
                                    mock_args.status = args_list[status_idx+1]
                            except ValueError: pass
                        if "--limit" in args_list:
                            try:
                                limit_idx = args_list.index("--limit")
                                if limit_idx + 1 < len(args_list):
                                    mock_args.limit = int(args_list[limit_idx+1])
                            except ValueError: print("❌ Invalid limit value.")
                        await self.handle_task_list(mock_args)

                    elif cmd == "cancel" and len(args_list) >= 1:
                        mock_args = argparse.Namespace(task_id=args_list[0])
                        await self.handle_task_cancel(mock_args)

                    elif cmd == "status":
                        mock_args = argparse.Namespace(detailed="--detailed" in args_list)
                        await self.handle_status(mock_args)

                    elif cmd == "schedule" and len(args_list) >= 1:
                        mock_args = argparse.Namespace(period=args_list[0], browsers="mobile_usa,mobile_eu")
                        if "--browsers" in args_list:
                            try:
                                browsers_idx = args_list.index("--browsers")
                                if browsers_idx + 1 < len(args_list):
                                    mock_args.browsers = args_list[browsers_idx+1]
                            except ValueError: pass
                        await self.handle_schedule(mock_args)
                    
                    elif cmd == "search" and len(args_list) >= 1:
                        query_parts = []
                        regions = "primary_desktop,mobile_usa"
                        analyze = False

                        i = 0
                        while i < len(args_list):
                            if args_list[i] == "--regions" and i + 1 < len(args_list):
                                regions = args_list[i+1]
                                i += 2
                            elif args_list[i] == "--analyze":
                                analyze = True
                                i += 1
                            else:
                                query_parts.append(args_list[i])
                                i += 1
                        query = " ".join(query_parts)
                        if query:
                            mock_args = argparse.Namespace(query=query, regions=regions, analyze=analyze)
                            await self.handle_search(mock_args)
                        else:
                            print("❌ Please provide a search query.")

                    elif cmd == "monitor" and len(args_list) >= 1:
                        urls = []
                        interval = 300
                        continuous = False

                        i = 0
                        while i < len(args_list):
                            if args_list[i] == "--interval" and i + 1 < len(args_list):
                                try: interval = int(args_list[i+1])
                                except ValueError: print("❌ Invalid interval value."); return
                                i += 2
                            elif args_list[i] == "--continuous":
                                continuous = True
                                i += 1
                            else:
                                urls.append(args_list[i])
                                i += 1
                        
                        if urls:
                            mock_args = argparse.Namespace(urls=urls, interval=interval, continuous=continuous)
                            await self.handle_monitor(mock_args)
                        else:
                            print("❌ Please provide at least one URL to monitor.")

                    elif cmd == "results" and len(args_list) >= 1:
                        if args_list[0] == "show":
                            mock_args = argparse.Namespace(task_id=None, limit=5)
                            if "--task-id" in args_list:
                                try:
                                    task_id_idx = args_list.index("--task-id")
                                    if task_id_idx + 1 < len(args_list):
                                        mock_args.task_id = args_list[task_id_idx+1]
                                except ValueError: pass
                            if "--limit" in args_list:
                                try:
                                    limit_idx = args_list.index("--limit")
                                    if limit_idx + 1 < len(args_list):
                                        mock_args.limit = int(args_list[limit_idx+1])
                                except ValueError: print("❌ Invalid limit value."); return
                            await self.handle_results_show(mock_args)
                        elif args_list[0] == "export" and len(args_list) >= 2:
                            output_file = args_list[1]
                            mock_args = argparse.Namespace(output_file=output_file, task_id=None, format=None)
                            if "--task-id" in args_list:
                                try:
                                    task_id_idx = args_list.index("--task-id")
                                    if task_id_idx + 1 < len(args_list):
                                        mock_args.task_id = args_list[task_id_idx+1]
                                except ValueError: pass
                            if "--format" in args_list:
                                try:
                                    format_idx = args_list.index("--format")
                                    if format_idx + 1 < len(args_list):
                                        mock_args.format = args_list[format_idx+1]
                                except ValueError: pass
                            await self.handle_results_export(mock_args)
                        else:
                            print("❌ Invalid \"results\" command. Use \"results show\" or \"results export <file>\".")

                    elif cmd == "config":
                        if len(args_list) >= 1 and args_list[0] == "show":
                            await self.handle_config_show()
                        elif len(args_list) >= 1 and args_list[0] == "reset":
                            await self.handle_config_reset()
                        elif len(args_list) >= 1 and args_list[0] == "browser_add":
                            add_args_dict = {
                                "name": None, "timezone": "UTC", "device": "desktop",
                                "stealth": False, "headless": False, "viewport": None,
                                "user_data_dir": None, "storage_state": None,
                                "allowed_domains": None, "exec_path": None
                            }
                            i = 1
                            while i < len(args_list):
                                arg = args_list[i]
                                if arg == "--name": add_args_dict["name"] = args_list[i+1]; i+=2
                                elif arg == "--timezone": add_args_dict["timezone"] = args_list[i+1]; i+=2
                                elif arg == "--device": add_args_dict["device"] = args_list[i+1]; i+=2
                                elif arg == "--stealth": add_args_dict["stealth"] = True; i+=1
                                elif arg == "--headless": add_args_dict["headless"] = True; i+=1
                                elif arg == "--viewport": add_args_dict["viewport"] = args_list[i+1]; i+=2
                                elif arg == "--user-data-dir": add_args_dict["user_data_dir"] = args_list[i+1]; i+=2
                                elif arg == "--storage-state": add_args_dict["storage_state"] = args_list[i+1]; i+=2
                                elif arg == "--allowed-domains": add_args_dict["allowed_domains"] = args_list[i+1]; i+=2
                                elif arg == "--exec-path": add_args_dict["exec_path"] = args_list[i+1]; i+=2
                                else: print(f"❌ Unknown argument for browser_add: {arg}"); return
                            if add_args_dict["name"]:
                                mock_args = argparse.Namespace(**add_args_dict)
                                await self.handle_browser_config_add(mock_args)
                            else: print("❌ --name is required for browser_add.")
                        elif len(args_list) >= 1 and args_list[0] == "browser_remove" and len(args_list) >= 2:
                            mock_args = argparse.Namespace(name=args_list[1])
                            await self.handle_browser_config_remove(mock_args)
                        else:
                            print("❌ Invalid \"config\" command. Use \"config show\", \"config reset\", \"config browser_add\", or \"config browser_remove\".")

                    else:
                        print(f"❓ Unknown command: {command_line}")
                        print("Type \"help\" for available commands")
                    
            except KeyboardInterrupt:
                print("\n👋 Goodbye!")
                break
            except Exception as e:
                print(f"❌ Error: {e}")
                import traceback
                traceback.print_exc()
    
    async def run(self):
        """Main CLI entry point"""
        parser = self.create_parser()
        
        if len(sys.argv) == 1:
            parser.print_help()
            print("\nStarting interactive mode...")
            await self.initialize()
            await self.interactive_mode()
            return
        
        args = parser.parse_args()
        
        await self.initialize()
        
        try:
            if args.command == "task":
                if args.task_action == "add":
                    await self.handle_task_add(args)
                elif args.task_action == "run":
                    await self.handle_task_run(args)
                elif args.task_action == "list":
                    await self.handle_task_list(args)
                elif args.task_action == "cancel":
                    await self.handle_task_cancel(args)
                
            elif args.command == "schedule":
                await self.handle_schedule(args)
                
            elif args.command == "search":
                await self.handle_search(args)
                
            elif args.command == "monitor":
                await self.handle_monitor(args)
                
            elif args.command == "status":
                await self.handle_status(args)
                
            elif args.command == "config":
                if args.config_action == "show":
                    await self.handle_config_show()
                elif args.config_action == "reset":
                    await self.handle_config_reset()
                elif args.config_action == "browser_add":
                    await self.handle_browser_config_add(args)
                elif args.config_action == "browser_remove":
                    await self.handle_browser_config_remove(args)
                    
            elif args.command == "results":
                if args.results_action == "show":
                    await self.handle_results_show(args)
                elif args.results_action == "export":
                    await self.handle_results_export(args)
                
            elif args.command == "interactive":
                await self.interactive_mode()
                
        except Exception as e:
            print(f"❌ Command execution failed: {e}")
            import traceback
            traceback.print_exc()
            
        finally:
            if self.sheikh:
                await self.sheikh.close_all_sessions()

def main():
    cli = SheikhCLI()
    
    try:
        asyncio.run(cli.run())
    except KeyboardInterrupt:
        print("\n👋 Sheikh Computer CLI terminated by user.")
    except Exception as e:
        print(f"❌ Fatal error in CLI: {e}")
        sys.exit(1)

if __name__ == "__main__":
    from dotenv import load_dotenv
    load_dotenv()
    main()
' > cli/main.py
echo -e "${GREEN}   cli/ populated.${NC}"
echo ""

# bin files
echo -e "${YELLOW}   Populating bin/...${NC}"
echo '#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

echo "--- Setting up Sheikh Computer Development Environment ---"

if [ ! -f .env ]; then
  cp .env.example .env
  echo ".env file created. Please edit it with your API keys and Redis URL."
else
  echo ".env file already exists. Skipping creation."
fi

echo "--- Installing Python dependencies ---"
pip install pydantic python-dotenv

echo "  Installing api_server dependencies..."
pip install -r api_server/requirements.txt

echo "  Installing worker_server dependencies (NOTE: Playwright will try to download browser binaries. This section is for external worker deployment.)"
pip install -r worker_server/requirements.txt
# This command is for *external* worker only. Playwright itself is huge and unstable on Termux.
# python -m playwright install --with-deps chromium # Commented out for Termux direct setup

echo "  Installing cli dependencies..."
pip install -r cli/requirements.txt

echo "--- Setting up Next.js frontend dependencies ---"
cd nextjs-app
npm install
npx tailwindcss init -p # Initialize TailwindCSS config if not present
cd ..

echo "--- Creating necessary directories ---"
mkdir -p logs storage

echo "--- Setup complete! ---"
echo "Next steps:"
echo "1. Edit your .env file with actual API keys (GOOGLE_API_KEY, REDIS_URL, BROWSERLESS_TOKEN)."
echo "2. Run "bin/dev.sh" to start local development servers (API + Frontend)."
echo "3. For full automation, you MUST deploy the worker_server/main.py to an external Linux server."
echo "4. For Vercel deployment, ensure your secrets are set (vercel env add)."
' > bin/setup.sh
chmod +x bin/setup.sh

echo '#!/bin/bash
set -e

echo "--- Starting Sheikh Computer Local Development ---"

if [ -f .env ]; then
  export $(cat .env | xargs)
  echo "Loaded environment variables from .env"
else
  echo "WARNING: .env file not found. Ensure environment variables are set manually."
fi

echo "--- Starting Redis Stack server (Docker) ---"
if docker ps -a --format "{{.Names}}" | grep -q "sheikh_redis_stack"; then
  if docker ps --format "{{.Names}}" | grep -q "sheikh_redis_stack"; then
    echo "Redis Stack container "sheikh_redis_stack" is already running."
  else
    echo "Redis Stack container "sheikh_redis_stack" exists but is stopped. Starting it..."
    docker start sheikh_redis_stack
  fi
else
  echo "Creating and starting new Redis Stack container "sheikh_redis_stack"..."
  docker run -d --name sheikh_redis_stack -p 6379:6379 -p 8001:8001 redis/redis-stack-server:latest
fi
echo "Redis GUI available at http://localhost:8001"
echo "Waiting for Redis to be ready..."
sleep 5

echo "--- Starting API Server (FastAPI) ---"
nohup uvicorn api_server.main:app --reload --host 0.0.0.0 --port 8000 > logs/api_server.log 2>&1 &
API_SERVER_PID=$!
echo "API Server started on http://localhost:8000 (PID: $API_SERVER_PID). Logs in logs/api_server.log"
sleep 2

echo "--- Starting Next.js Frontend Development Server ---"
cd nextjs-app
nohup npm run dev > ../logs/nextjs.log 2>&1 & # Redirect logs to root logs dir
NEXTJS_PID=$!
echo "Next.js Frontend started (PID: $NEXTJS_PID). Likely on http://localhost:3000. Logs in logs/nextjs.log"
cd ..

echo ""
echo -e "${GREEN}--- Development environment fully launched ---${NC}"
echo -e "${BLUE}Frontend: ${PURPLE}http://localhost:3000${NC}"
echo -e "${BLUE}API:      ${PURPLE}http://localhost:8000${NC}"
echo -e "${BLUE}Redis GUI:${PURPLE}http://localhost:8001${NC}"
echo ""
echo -e "${RED}REMINDER: The browser automation WORKER (worker_server) must run on an EXTERNAL server!${NC}"
echo -e "          The API and Frontend on Termux will connect to it once it's deployed."
echo ""
echo "To stop all processes: press Ctrl+C in this terminal."
echo "To stop Redis only: "docker stop sheikh_redis_stack""
echo "To remove Redis container: "docker rm sheikh_redis_stack""

trap "echo 'Shutting down...'; kill $API_SERVER_PID $NEXTJS_PID 2>/dev/null || true; docker stop sheikh_redis_stack 2>/dev/null || true; exit" INT TERM EXIT
wait
' > bin/dev.sh
chmod +x bin/dev.sh
echo -e "${GREEN}   bin/ populated.${NC}"
echo ""

# Final instructions
echo -e "${GREEN}----------------------------------------------------${NC}"
echo -e "${GREEN}Sheikh Computer setup complete on Termux!${NC}"
echo -e "${GREEN}Navigate into the 'sheikh-computer' directory:${NC}"
echo -e "cd sheikh-computer"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. ${PURPLE}Edit your .env file${YELLOW} with your actual ${BLUE}GOOGLE_API_KEY${YELLOW}, ${BLUE}REDIS_URL${YELLOW} (if not local), and ${BLUE}BROWSERLESS_TOKEN${YELLOW} (for the external worker).${NC}"
echo -e "2. If you want to run Redis locally in Termux (NO DOCKER):${NC}"
echo -e "   ${BLUE}pkg install redis${NC}"
echo -e "   ${BLUE}redis-server --daemonize yes${NC}"
echo -e "   Then ensure ${YELLOW}REDIS_URL='redis://127.0.0.1:6379/0'${NC} in your .env"
echo -e "   (Note: 'redis-server --daemonize yes' may not work on all Termux setups, try 'redis-server' alone in a new session)"
echo -e "3. ${PURPLE}Start the API and Frontend${YELLOW} using the dev script:${NC}"
echo -e "   ${GREEN}./bin/dev.sh${NC}"
echo -e "   (You may need to install ${BLUE}Font Awesome React components${NC} for full UI icons: ${BLUE}npm install @fortawesome/react-fontawesome @fortawesome/free-solid-svg-icons ${NC} in nextjs-app/)"
echo -e "4. ${RED}Crucially, deploy the 'worker_server' to a separate Linux server or cloud VM.${NC}"
echo -e "   Ensure its .env has the correct ${BLUE}API_SERVER_URL${NC} (your Termux/Vercel API URL) and ${BLUE}BROWSERLESS_TOKEN${NC}."
echo ""
echo -e "${BLUE}Remember to explore the CLI: ${NC}"
echo -e "${PURPLE}python cli/main.py --help${NC} or ${PURPLE}python cli/main.py interactive${NC}"
echo -e "${CYAN}----------------------------------------------------${NC}"

```
