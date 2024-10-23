import os
from openai import OpenAI


client = OpenAI()

class AI_Character(object):
    def __init__(self, name, tagline, description, backstory):
        self.model = "gpt-4"            # "gpt-3.5-turbo-1106" # gpt-3.5-turbo-1106 | gpt-4-0125-preview
        self.name = name
        self.tagline = tagline
        self.description = description
        self.backstory = backstory
        self.character_prompt = f"""
        You are an AI embodying the character of {name}, who may be a real person or a fictional character. 
        Fully assume this persona based on the following information and any additional knowledge you have about this character:
        Name: {name}
        Tagline: {tagline}
        Self-description: {description}
        Backstory: {backstory}
        
        As this character, you are calling a user to remind them about a task. Your call should:
        1. Start with a greeting that mentions the user's name, in a way typical for your character
        2. Remind them that it's now time to complete the task, using language and references consistent with your character
        3. Provide encouragement to complete the task, in your character's unique style
        4. End with a brief farewell that fits your persona

        Maintain your character's personality, speech patterns, catchphrases, and knowledge throughout the interaction. 
        If you're a real person or known character, incorporate relevant details from your public persona or fictional background.
        Keep the entire message concise, as if it's a quick phone call, but make it unmistakably in your character's voice.
        """
        self.conversation = []
        self.conversation.append(
            {"role": "system", "content": self.character_prompt})

    def generate_ai_reminder_call(self, user_name, task, scheduled_time):
        print(f"Generating reminder call for {user_name} about the task: {task}")
        prompt = f"""As {self.name}, create a brief reminder message for {user_name}. It's currently {scheduled_time}, and it's time for them to do this task: {task}.
        Your message should:
        1. Greet {user_name} in your typical style
        2. Specifically mention that it's time to {task}
        3. Provide brief encouragement to get the task done
        4. Say a quick goodbye as if you're ending a phone call

        Keep it concise and natural. 
        Don't include any sound effects or actions. Focus on the specific task of {task}. 
        Use your character's voice, but don't overdo it with too many catchphrases or references.
        """

        self.conversation.append({"role": "user", "content": prompt})
        
        print("Sending request to OpenAI...")
        response = client.chat.completions.create(
            model=self.model,
            messages=self.conversation,
            temperature=0.9
        )
        ai_response = response.choices[0].message.content

        # Print token usage
        print(f"Prompt tokens: {response.usage.prompt_tokens}")
        print(f"Completion tokens: {response.usage.completion_tokens}")
        print(f"Total tokens: {response.usage.total_tokens}")

        print("Received response from OpenAI.")
        return ai_response

    def reset_conversation(self):
        self.conversation = [{"role": "system", "content": self.character_prompt}]


if __name__ == "__main__":
    # Create an instance of AI_Character
    print("Creating AI Character...")
    nicki = AI_Character(
        name="Nicki Minaj",
        tagline="""You wanna know what scares people? Success. When you don't make moves and when you don't climb up the ladder, 
        everybody loves you because you're not competition.""",
        description="""I'm Nicki Minaj, the queen of rap, a fearless trendsetter, and a voice for women who aren't afraid to own their power. 
        My bars are sharp, my style is iconic, and I bring something new every time I step on the scene. 
        I've broken records, dominated charts, and redefined what it means to be a female artist in the game. 
        I do it all while staying true to myself—unapologetically bold, creative, and always evolving. 
        I'm here to inspire others to be their best, and I do it with style, confidence, and a little bit of attitude.""",
        backstory="""Nicki Minaj, born Onika Tanya Maraj on December 8, 1982, in Trinidad and Tobago, is a globally renowned rapper, singer, songwriter, 
        and actress. She moved to Queens, New York, as a child and began her music career in the mid-2000s. Known for her sharp 
        lyricism, distinctive voice, and vibrant persona, she gained widespread fame with her debut album 
        Pink Friday (2010), which produced hits like "Super Bass." Over the years, Nicki has become one of the best-selling 
        female rappers, breaking numerous records and earning accolades for her contributions to hip-hop and pop. Her dynamic 
        style, colorful alter-egos, and unapologetic confidence have made her a cultural icon."""
    )

    # Define user name and task
    user_name = "John"
    task = "study"
    scheduled_time = "Monday at 4:00 PM"

    # Generate the reminder call
    print("\nGenerating reminder call...")
    response = nicki.generate_ai_reminder_call(user_name, task, scheduled_time)

    # Print the response
    print("\nAI-generated reminder call:")
    print(response)