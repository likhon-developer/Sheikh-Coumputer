import React, { useState } from 'react';
import { Button } from './button';
import { Textarea } from './textarea';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './card';
import { Badge } from './badge';
import { 
  Globe, 
  Code, 
  BarChart3, 
  FileText, 
  Image, 
  Sparkles,
  Send,
  Loader2
} from 'lucide-react';
import '../../styles/App.css';

export const FanushPanel = () => {
  const [input, setInput] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [messages, setMessages] = useState([]);

  const capabilities = [
    { icon: Globe, label: 'Browser Automation', color: 'bg-blue-500' },
    { icon: Code, label: 'Code Generation', color: 'bg-green-500' },
    { icon: BarChart3, label: 'Data Analysis', color: 'bg-purple-500' },
    { icon: FileText, label: 'Document Generation', color: 'bg-red-500' },
    { icon: Image, label: 'Image Generation', color: 'bg-orange-500' },
    { icon: Sparkles, label: 'AI Assistant', color: 'bg-pink-500' }
  ];

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!input.trim()) return;

    setIsLoading(true);
    const userMessage = { role: 'user', content: input };
    setMessages(prev => [...prev, userMessage]);
    setInput('');

    try {
      const response = await fetch('/api/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: input }),
      });

      const data = await response.json();
      const assistantMessage = { role: 'assistant', content: data.response };
      setMessages(prev => [...prev, assistantMessage]);
    } catch (error) {
      console.error('Error:', error);
      const errorMessage = { role: 'assistant', content: 'Sorry, I encountered an error. Please try again.' };
      setMessages(prev => [...prev, errorMessage]);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-3">
              <div className="w-10 h-10 bg-gradient-to-br from-blue-600 to-purple-600 rounded-xl flex items-center justify-center">
                <Sparkles className="text-white w-6 h-6" />
              </div>
              <div>
                <h1 className="text-xl font-bold text-gray-900 dark:text-white">Fanush</h1>
                <p className="text-sm text-gray-500 dark:text-gray-400">Powered by Gemini</p>
              </div>
            </div>
            <nav className="hidden md:flex items-center space-x-6">
              <a href="#" className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white transition-colors">Features</a>
              <a href="#" className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white transition-colors">Examples</a>
              <a href="#" className="text-gray-600 hover:text-gray-900 dark:text-gray-300 dark:hover:text-white transition-colors">Community</a>
              <Button variant="outline" size="sm">Sign in</Button>
              <Button size="sm" className="bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700">Get Started</Button>
            </nav>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="container mx-auto px-4 py-12">
        <div className="max-w-4xl mx-auto">
          {/* Hero Section */}
          <div className="text-center mb-12">
            <div className="inline-flex items-center px-4 py-2 bg-blue-50 dark:bg-blue-900/20 rounded-full mb-6">
              <Sparkles className="w-4 h-4 text-blue-600 mr-2" />
              <span className="text-sm font-medium text-blue-700 dark:text-blue-300">AI-Powered Assistant</span>
            </div>
            <h1 className="text-5xl font-bold text-gray-900 dark:text-white mb-4">
              Hello, I'm <span className="bg-gradient-to-r from-blue-600 to-purple-600 bg-clip-text text-transparent">Fanush</span>
            </h1>
            <p className="text-xl text-gray-600 dark:text-gray-300 mb-8">What can I help you create today?</p>
            
            {/* Input Form */}
            <form onSubmit={handleSubmit} className="mb-8">
              <div className="relative">
                <Textarea
                  value={input}
                  onChange={(e) => setInput(e.target.value)}
                  placeholder="Describe what you'd like me to help you with..."
                  className="min-h-[120px] pr-12 text-lg resize-none border-2 border-gray-200 dark:border-gray-700 focus:border-blue-500 dark:focus:border-blue-400 rounded-xl"
                  disabled={isLoading}
                />
                <Button
                  type="submit"
                  size="sm"
                  className="absolute bottom-3 right-3 bg-gradient-to-r from-blue-600 to-purple-600 hover:from-blue-700 hover:to-purple-700"
                  disabled={isLoading || !input.trim()}
                >
                  {isLoading ? (
                    <Loader2 className="h-4 w-4 animate-spin" />
                  ) : (
                    <Send className="h-4 w-4" />
                  )}
                </Button>
              </div>
            </form>

            {/* Capability Buttons */}
            <div className="flex flex-wrap justify-center gap-3 mb-12">
              {capabilities.map((capability, index) => (
                <Button
                  key={index}
                  variant="outline"
                  className="flex items-center space-x-2 px-4 py-2 hover:shadow-md transition-all duration-200 hover:scale-105"
                >
                  <div className={`w-6 h-6 rounded ${capability.color} flex items-center justify-center`}>
                    <capability.icon className="h-4 w-4 text-white" />
                  </div>
                  <span>{capability.label}</span>
                </Button>
              ))}
            </div>
          </div>

          {/* Chat Messages */}
          {messages.length > 0 && (
            <div className="space-y-6 mb-8">
              {messages.map((message, index) => (
                <Card key={index} className={`${message.role === 'user' ? 'ml-auto max-w-2xl bg-blue-50 dark:bg-blue-900/20' : 'mr-auto max-w-2xl'} shadow-sm hover:shadow-md transition-shadow`}>
                  <CardContent className="p-6">
                    <div className="flex items-start space-x-4">
                      <div className={`w-8 h-8 rounded-full flex items-center justify-center ${
                        message.role === 'user' ? 'bg-blue-600' : 'bg-gradient-to-br from-blue-600 to-purple-600'
                      }`}>
                        <span className="text-white font-bold text-sm">
                          {message.role === 'user' ? 'U' : 'F'}
                        </span>
                      </div>
                      <div className="flex-1">
                        <p className="text-gray-900 dark:text-gray-100 leading-relaxed">{message.content}</p>
                      </div>
                    </div>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}

          {/* Community Examples */}
          <div className="text-center">
            <p className="text-sm text-gray-500 dark:text-gray-400 mb-6">
              Explore what others have created with Fanush
            </p>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {[
                "AI-Powered Data Visualization Dashboard",
                "Automated Web Scraping Script", 
                "Interactive React Component Library",
                "Smart Document Generator",
                "Custom API Integration Tool",
                "Responsive Landing Page Design"
              ].map((example, index) => (
                <Card key={index} className="hover:shadow-lg transition-all duration-200 hover:scale-105 cursor-pointer group">
                  <CardContent className="p-4">
                    <div className="flex items-center space-x-2 mb-2">
                      <div className="w-2 h-2 bg-green-500 rounded-full"></div>
                      <Badge variant="secondary" className="text-xs">Generated</Badge>
                    </div>
                    <p className="text-sm text-gray-700 dark:text-gray-300 group-hover:text-gray-900 dark:group-hover:text-white transition-colors">{example}</p>
                  </CardContent>
                </Card>
              ))}
            </div>
          </div>
        </div>
      </main>

      {/* Footer */}
      <footer className="border-t bg-white/50 backdrop-blur-sm dark:bg-slate-900/50 mt-20">
        <div className="container mx-auto px-4 py-8">
          <div className="text-center text-gray-500 dark:text-gray-400">
            <p className="mb-2">Fanush - Your AI-Powered Assistant</p>
            <p className="text-sm">Built with ❤️ using React, Flask, and Google Gemini</p>
          </div>
        </div>
      </footer>
    </div>
  );
};
