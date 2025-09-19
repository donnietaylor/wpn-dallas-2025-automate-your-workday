#!/usr/bin/env python3
"""
AI Email Classifier

This script demonstrates how to use AI to automatically classify emails
into categories for better organization and workflow automation.

Requirements:
- openai
- python-dotenv

Usage:
    python ai_email_classifier.py
"""

import os
from typing import List, Dict
from dotenv import load_dotenv
import openai

# Load environment variables
load_dotenv()

class EmailClassifier:
    """AI-powered email classification system."""
    
    def __init__(self, api_key: str = None):
        """Initialize the email classifier.
        
        Args:
            api_key: OpenAI API key (optional, can use environment variable)
        """
        self.client = openai.OpenAI(
            api_key=api_key or os.getenv('OPENAI_API_KEY')
        )
        
        # Predefined categories
        self.categories = [
            "urgent",
            "meeting_request", 
            "project_update",
            "administrative",
            "customer_inquiry",
            "marketing",
            "spam",
            "personal"
        ]
    
    def classify_email(self, subject: str, body: str) -> Dict[str, any]:
        """Classify an email into predefined categories.
        
        Args:
            subject: Email subject line
            body: Email body content
            
        Returns:
            Dictionary with classification results
        """
        try:
            # Create the prompt for classification
            prompt = self._create_classification_prompt(subject, body)
            
            # Call OpenAI API
            response = self.client.chat.completions.create(
                model="gpt-3.5-turbo",
                messages=[
                    {"role": "system", "content": "You are an expert email classifier."},
                    {"role": "user", "content": prompt}
                ],
                max_tokens=150,
                temperature=0.3
            )
            
            # Parse the response
            classification = response.choices[0].message.content.strip()
            
            return self._parse_classification_response(classification)
            
        except Exception as e:
            return {
                "success": False,
                "error": str(e),
                "category": "unknown",
                "confidence": 0.0,
                "reasoning": "Classification failed due to error"
            }
    
    def _create_classification_prompt(self, subject: str, body: str) -> str:
        """Create the classification prompt for the AI model."""
        categories_str = ", ".join(self.categories)
        
        prompt = f"""
Please classify the following email into one of these categories: {categories_str}

Email Subject: {subject}
Email Body: {body[:500]}{'...' if len(body) > 500 else ''}

Respond in the following format:
Category: [category_name]
Confidence: [0.0-1.0]
Reasoning: [brief explanation]
"""
        return prompt
    
    def _parse_classification_response(self, response: str) -> Dict[str, any]:
        """Parse the AI response into structured data."""
        try:
            lines = response.strip().split('\n')
            result = {
                "success": True,
                "category": "unknown",
                "confidence": 0.0,
                "reasoning": ""
            }
            
            for line in lines:
                if line.startswith("Category:"):
                    result["category"] = line.split(":", 1)[1].strip().lower()
                elif line.startswith("Confidence:"):
                    conf_str = line.split(":", 1)[1].strip()
                    try:
                        result["confidence"] = float(conf_str)
                    except ValueError:
                        result["confidence"] = 0.5
                elif line.startswith("Reasoning:"):
                    result["reasoning"] = line.split(":", 1)[1].strip()
            
            return result
            
        except Exception as e:
            return {
                "success": False,
                "error": f"Failed to parse response: {str(e)}",
                "category": "unknown",
                "confidence": 0.0,
                "reasoning": "Response parsing failed"
            }
    
    def classify_batch(self, emails: List[Dict[str, str]]) -> List[Dict[str, any]]:
        """Classify multiple emails in batch.
        
        Args:
            emails: List of dictionaries with 'subject' and 'body' keys
            
        Returns:
            List of classification results
        """
        results = []
        for email in emails:
            result = self.classify_email(
                email.get('subject', ''), 
                email.get('body', '')
            )
            result['original_subject'] = email.get('subject', '')
            results.append(result)
        
        return results


def main():
    """Example usage of the EmailClassifier."""
    
    # Sample emails for demonstration
    sample_emails = [
        {
            "subject": "URGENT: Server down - need immediate attention",
            "body": "Our main server has crashed and customers cannot access the website. This needs immediate attention as it's affecting our revenue."
        },
        {
            "subject": "Meeting invitation: Project kickoff next Tuesday",
            "body": "Hi team, I'd like to schedule our project kickoff meeting for next Tuesday at 2 PM. Please let me know if you're available."
        },
        {
            "subject": "Weekly project status update",
            "body": "Here's our weekly update on the mobile app project. We've completed 3 features this week and are on track for the milestone."
        },
        {
            "subject": "Congratulations! You've won $1,000,000!",
            "body": "Click here to claim your prize! This is definitely not spam and totally legitimate."
        }
    ]
    
    # Initialize classifier
    classifier = EmailClassifier()
    
    print("🤖 AI Email Classifier Demo")
    print("=" * 50)
    
    # Classify each email
    for i, email in enumerate(sample_emails, 1):
        print(f"\n📧 Email {i}:")
        print(f"Subject: {email['subject']}")
        print(f"Body: {email['body'][:100]}...")
        
        result = classifier.classify_email(email['subject'], email['body'])
        
        if result['success']:
            print(f"✅ Category: {result['category']}")
            print(f"📊 Confidence: {result['confidence']:.2f}")
            print(f"💭 Reasoning: {result['reasoning']}")
        else:
            print(f"❌ Error: {result['error']}")
        
        print("-" * 50)
    
    # Batch classification example
    print("\n🔄 Batch Classification:")
    batch_results = classifier.classify_batch(sample_emails)
    
    for result in batch_results:
        if result['success']:
            print(f"'{result['original_subject'][:30]}...' → {result['category']} ({result['confidence']:.2f})")


if __name__ == "__main__":
    main()