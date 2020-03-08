from discord_webhook import DiscordWebhook

webhook = DiscordWebhook(url='<webhook url goes here>', content='Hey guys, the server is down :(. Time to brew a pot!!')
response = webhook.execute()