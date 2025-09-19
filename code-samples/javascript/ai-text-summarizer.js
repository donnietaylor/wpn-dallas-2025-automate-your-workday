/**
 * AI Text Summarizer
 * 
 * This script demonstrates how to use AI to automatically summarize
 * long text documents for quick review and processing.
 * 
 * Requirements:
 * - openai npm package
 * - dotenv npm package
 * 
 * Usage:
 *   node ai-text-summarizer.js
 */

require('dotenv').config();
const OpenAI = require('openai');

class TextSummarizer {
    constructor(apiKey = null) {
        this.client = new OpenAI({
            apiKey: apiKey || process.env.OPENAI_API_KEY
        });
        
        this.summaryTypes = {
            BRIEF: 'brief',
            DETAILED: 'detailed',
            BULLET_POINTS: 'bullet_points',
            KEY_INSIGHTS: 'key_insights'
        };
    }

    /**
     * Summarize text using AI
     * @param {string} text - The text to summarize
     * @param {string} summaryType - Type of summary to generate
     * @param {number} maxLength - Maximum length of summary
     * @returns {Promise<Object>} Summary result
     */
    async summarizeText(text, summaryType = 'brief', maxLength = 150) {
        try {
            const prompt = this._createSummaryPrompt(text, summaryType, maxLength);
            
            const response = await this.client.chat.completions.create({
                model: 'gpt-3.5-turbo',
                messages: [
                    { 
                        role: 'system', 
                        content: 'You are an expert at creating clear, concise summaries.' 
                    },
                    { role: 'user', content: prompt }
                ],
                max_tokens: Math.min(maxLength * 2, 500),
                temperature: 0.3
            });

            const summary = response.choices[0].message.content.trim();
            
            return {
                success: true,
                summary: summary,
                originalLength: text.length,
                summaryLength: summary.length,
                compressionRatio: (summary.length / text.length).toFixed(2),
                summaryType: summaryType
            };

        } catch (error) {
            return {
                success: false,
                error: error.message,
                summary: null,
                originalLength: text.length,
                summaryLength: 0,
                compressionRatio: 0,
                summaryType: summaryType
            };
        }
    }

    /**
     * Summarize multiple documents in batch
     * @param {Array} documents - Array of text documents
     * @param {string} summaryType - Type of summary to generate
     * @returns {Promise<Array>} Array of summary results
     */
    async summarizeBatch(documents, summaryType = 'brief') {
        const results = [];
        
        for (let i = 0; i < documents.length; i++) {
            console.log(`Processing document ${i + 1}/${documents.length}...`);
            
            const result = await this.summarizeText(
                documents[i].content || documents[i], 
                summaryType
            );
            
            if (documents[i].title) {
                result.title = documents[i].title;
            }
            
            results.push(result);
            
            // Add small delay to avoid rate limiting
            await this._delay(500);
        }
        
        return results;
    }

    /**
     * Extract key topics from text
     * @param {string} text - The text to analyze
     * @returns {Promise<Object>} Topics and themes
     */
    async extractTopics(text) {
        try {
            const prompt = `
Please analyze the following text and extract the main topics and themes:

${text.substring(0, 2000)}${text.length > 2000 ? '...' : ''}

Respond in the following format:
Main Topics: [comma-separated list]
Key Themes: [comma-separated list]
Sentiment: [positive/negative/neutral]
Urgency Level: [low/medium/high]
`;

            const response = await this.client.chat.completions.create({
                model: 'gpt-3.5-turbo',
                messages: [
                    { role: 'system', content: 'You are an expert text analyst.' },
                    { role: 'user', content: prompt }
                ],
                max_tokens: 200,
                temperature: 0.2
            });

            const analysis = response.choices[0].message.content.trim();
            return this._parseTopicAnalysis(analysis);

        } catch (error) {
            return {
                success: false,
                error: error.message,
                topics: [],
                themes: [],
                sentiment: 'unknown',
                urgency: 'unknown'
            };
        }
    }

    _createSummaryPrompt(text, summaryType, maxLength) {
        const typeInstructions = {
            brief: `Create a brief, concise summary in ${maxLength} words or less.`,
            detailed: `Create a detailed summary that captures all key points in ${maxLength} words or less.`,
            bullet_points: `Create a bullet-point summary with the main points in ${maxLength} words or less.`,
            key_insights: `Extract the key insights and actionable items in ${maxLength} words or less.`
        };

        return `
${typeInstructions[summaryType] || typeInstructions.brief}

Text to summarize:
${text.substring(0, 3000)}${text.length > 3000 ? '...' : ''}
`;
    }

    _parseTopicAnalysis(analysis) {
        try {
            const lines = analysis.split('\n');
            const result = {
                success: true,
                topics: [],
                themes: [],
                sentiment: 'neutral',
                urgency: 'low'
            };

            lines.forEach(line => {
                if (line.startsWith('Main Topics:')) {
                    result.topics = line.split(':')[1].split(',').map(t => t.trim());
                } else if (line.startsWith('Key Themes:')) {
                    result.themes = line.split(':')[1].split(',').map(t => t.trim());
                } else if (line.startsWith('Sentiment:')) {
                    result.sentiment = line.split(':')[1].trim().toLowerCase();
                } else if (line.startsWith('Urgency Level:')) {
                    result.urgency = line.split(':')[1].trim().toLowerCase();
                }
            });

            return result;
        } catch (error) {
            return {
                success: false,
                error: `Failed to parse analysis: ${error.message}`,
                topics: [],
                themes: [],
                sentiment: 'unknown',
                urgency: 'unknown'
            };
        }
    }

    _delay(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

// Example usage
async function main() {
    console.log('🤖 AI Text Summarizer Demo');
    console.log('='.repeat(50));

    const summarizer = new TextSummarizer();

    // Sample document
    const sampleText = `
    The quarterly business review meeting revealed several important trends in our market performance. 
    Sales figures for Q3 showed a 15% increase compared to the previous quarter, with particularly strong 
    performance in the technology and healthcare sectors. Our new product line contributed significantly 
    to this growth, accounting for approximately 30% of total revenue.

    However, we also identified some challenges that need immediate attention. Customer acquisition costs 
    have increased by 8% due to increased competition and higher advertising rates. Additionally, our 
    customer support team has reported a 12% increase in support tickets, primarily related to the new 
    product features.

    The engineering team has successfully delivered three major feature updates this quarter, but technical 
    debt is becoming a concern. We need to allocate more resources to refactoring and code optimization 
    in Q4 to maintain system performance and reliability.

    Looking ahead, market research indicates strong demand for AI-powered features in our industry. We 
    should consider investing in machine learning capabilities to stay competitive. The board has approved 
    a preliminary budget for hiring two additional data scientists and one ML engineer.

    Action items from this meeting include: updating our customer onboarding process, implementing new 
    support automation tools, beginning the technical debt reduction project, and starting recruitment 
    for the AI team positions.
    `;

    try {
        // Test different summary types
        const summaryTypes = ['brief', 'bullet_points', 'key_insights'];
        
        for (const type of summaryTypes) {
            console.log(`\n📄 ${type.toUpperCase().replace('_', ' ')} SUMMARY:`);
            console.log('-'.repeat(30));
            
            const result = await summarizer.summarizeText(sampleText, type, 100);
            
            if (result.success) {
                console.log(result.summary);
                console.log(`\n📊 Stats: ${result.originalLength} → ${result.summaryLength} chars (${result.compressionRatio}x compression)`);
            } else {
                console.log(`❌ Error: ${result.error}`);
            }
        }

        // Extract topics
        console.log('\n🔍 TOPIC ANALYSIS:');
        console.log('-'.repeat(30));
        
        const topicAnalysis = await summarizer.extractTopics(sampleText);
        
        if (topicAnalysis.success) {
            console.log(`📋 Topics: ${topicAnalysis.topics.join(', ')}`);
            console.log(`🎯 Themes: ${topicAnalysis.themes.join(', ')}`);
            console.log(`😊 Sentiment: ${topicAnalysis.sentiment}`);
            console.log(`⚡ Urgency: ${topicAnalysis.urgency}`);
        } else {
            console.log(`❌ Error: ${topicAnalysis.error}`);
        }

    } catch (error) {
        console.error('❌ Demo failed:', error.message);
    }
}

// Run the demo if this file is executed directly
if (require.main === module) {
    main();
}

module.exports = TextSummarizer;