import discord
from discord.ext import commands
import random

# helper imports
import os
import subprocess
import re

# -------------- Helpers -------------------

def findThisProcess(process_name):
  ps     = subprocess.Popen("ps -eaf | grep "+ process_name + "| grep -v grep", shell=True, stdout=subprocess.PIPE)
  output = ps.stdout.read()
  ps.stdout.close()
  ps.wait()

  return output

def isThisRunning(process_name):
  output = findThisProcess( process_name )

  if re.search(process_name, output.decode()) is None:
    return False
  else:
    return True

# -------------- End Helpers -------------------

description = '''Server watcher will let you know what the server status is.

Just type: !status in chat'''
bot = commands.Bot(command_prefix='!', description=description)

@bot.event
async def on_ready():
    await bot.wait_until_ready()
    print('Logged in as')
    print(bot.user.name)
    print(bot.user.id)
    print('------')
    await status('temp')


@bot.command(description='For when you wanna settle the score some other way')
async def choose(*choices : str):
    """Chooses between multiple choices."""
    await ctx.send(random.choice(choices))

@bot.command()
async def repeat(times : int, content='repeating...'):
    """Repeats a message multiple times."""
    for i in range(times):
        await ctx.send(content)

@bot.command()
async def joined(member : discord.Member):
    """Says when a member joined."""
    await ctx.send('{0.name} joined in {0.joined_at}'.format(member))

@bot.command()
async def status(ctx):
    channel = bot.get_channel(683121976596103315)
    if (isThisRunning('bedrock_server') == True):
        await channel.send('Server is running!')
    else:
        await channel.send('Server is down!')

@bot.group()
async def cool(ctx):
    """Says if a user is cool.
    In reality this just checks if a subcommand is being invoked.
    """
    if ctx.invoked_subcommand is None:
        await ctx.send('No, {0.subcommand_passed} is not cool'.format(ctx))

@cool.command(name='bot')
async def _bot(ctx):
    """Is the bot cool?"""
    await ctx.send('Yes, the bot is cool.')

bot.run('NjgzNzYxMjA4NjU4MTAwMzgw.XlwSEg.N4XcD3xDA6IZos0B63x8e6b1k38')