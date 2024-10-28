from flask import Flask, request, jsonify
from openai_connector import AI_Character

app = Flask(__name__)

# test AI_Character instance
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

@app.route('/generate-reminder', methods=['POST'])
def generate_reminder():
    data = request.get_json()
    user_name = data.get('user_name')
    task = data.get('task')
    scheduled_time = data.get('scheduled_time')

    response = nicki.generate_ai_reminder_call(user_name, task, scheduled_time)
    # return jsonify({'ai_response': response})
    return jsonify(response)
    # return [response.to_dict()], 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5555)