# import os
# from elevenlabs import generate, play
# from elevenlabs.client import ElevenLabs



# client = ElevenLabs(api_key="ELEVEN_API_KEY")

# class AI_Voice(object):
#     def __init__(self, name, description):
#         self.model = "eleven_multilingual_v2"
#         self.name = name
#         self.description = description
#         self.voice = None
#         self.speech = None


#     def clone_voice(self, files):
#         self.voice = client.clone(
#             name=self.name,
#             description=self.description,
#             files=files,
#         )
#         return self.voice

#     def generate_audio(self, text):
#         self.speech = client.generate(text=text, voice=self.voice)
#         return self.speech

#     def play_speech(self, text):
#         print(text)
#         play(self.speech)

#     def save_audio(self, filename):
#         audio = AudioSegment.from_wav(io.BytesIO(self.speech))
#         audio.export(filename, format="mp3")

#     @staticmethod
#     def load_voice(voice_id):
#         """Load a pre-existing voice by ID."""
#         return client.get_voice(voice_id)
    
