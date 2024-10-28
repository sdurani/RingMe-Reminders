import os
from openai import OpenAI
from flask import Flask

client = OpenAI()

class AI_Character(object):
    def __init__(self, name, tagline, description, backstory):
        self.model = "gpt-4"  # Choose the appropriate model
        self.name = name
        self.tagline = tagline
        self.description = description
        self.backstory = backstory

    def generate_ai_reminder_call(self, user_name, task, scheduled_time):
        print(f"Generating reminder call for {user_name} about the task: {task}")

        # Construct the character prompt and user prompt directly
        character_prompt = f"""
        You are an AI embodying the character of {self.name}. 
        Fully assume this persona based on the following information:
        Name: {self.name}
        Tagline: {self.tagline}
        Self-description: {self.description}
        Backstory: {self.backstory}

        As this character, you are calling a user to remind them about a task. Your call should:
        1. Start with a simple greeting that mentions the user's name.
        2. Remind them that it's now time to complete the task, using language and references consistent with your character but avoiding excessive flair.
        3. Provide a brief and direct encouragement to complete the task, in your character's unique style.
        4. End with a brief farewell that fits your persona.

        Keep the entire message short and natural, as if it's a quick phone call, but make it unmistakably in your character's voice.
        """

        prompt = f"""As {self.name}, create a brief reminder message for {user_name}. It's currently {scheduled_time}, and it's time for them to do this task: {task}.
        Your message should:
        1. Greet {user_name} simply and naturally.
        2. Clearly state that it's time to {task}.
        3. Offer brief encouragement without excessive enthusiasm.
        4. Say a straightforward goodbye as if you're quickly hanging up.

        Keep it concise and natural. 
        Don't include any sound effects, actions, or unnecessary references. Focus on the specific task of {task}. 
        Use your character's voice, but keep it realistic and straightforward.
        """

        # Combine both prompts for the OpenAI call
        combined_prompt = character_prompt + prompt
        
        print("Sending request to OpenAI...")
        response = client.chat.completions.create(
            model=self.model,
            messages=[{"role": "user", "content": combined_prompt}],
            max_tokens=200,  # Adjust based on your needs
            temperature=0.8   # Lower temperature for more predictable responses
        )
        ai_response = response.choices[0].message.content

        # Print token usage
        print(f"Prompt tokens: {response.usage.prompt_tokens}")
        print(f"Completion tokens: {response.usage.completion_tokens}")
        print(f"Total tokens: {response.usage.total_tokens}")

        print("Received response from OpenAI.")
        return ai_response

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
        I do it all while staying true to myself—unapologetically bold, creative, and always evolving.""",
        backstory="""Nicki Minaj, born Onika Tanya Maraj on December 8, 1982, in Trinidad and Tobago, is a globally renowned rapper, singer, songwriter, 
        and actress. Known for her sharp lyricism, distinctive voice, and vibrant persona, she gained widespread fame with her debut album 
        Pink Friday (2010), which produced hits like "Super Bass." Her dynamic style and unapologetic confidence have made her a cultural icon."""
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
