# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

from botbuilder.core import ActivityHandler, TurnContext
from botbuilder.schema import ChannelAccount
import requests


class MyBot(ActivityHandler):
    # See https://aka.ms/about-bot-activity-message to learn more about the message and other activity types.

    async def on_message_activity(self, turn_context: TurnContext):
        print(turn_context.activity.text)
        await turn_context.send_activity(f"You said '{ turn_context.activity.text }'")
        # print(turn_context.activity.text)
        # send a get request to localhost:5000/has_directory
        # response = requests.get('http://localhost:5000/has_directory')
        # message = response.json().get()
        # await turn_context.send_activity(f"'{ response.text }'")

    async def on_members_added_activity(
        self,
        members_added: ChannelAccount,
        turn_context: TurnContext
    ):
        for member_added in members_added:
            if member_added.id != turn_context.activity.recipient.id:
                await turn_context.send_activity("Hello and welcome!")
