from discord_webhook import DiscordWebhook

webhook = DiscordWebhook(url='<webhook url goes here>', content='Hey guys, the server is up and ready to go! Time to break some blocks :)')
response = webhook.execute()