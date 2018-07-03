# bashbot
A Telegram bot written in bash.

### Prerequisites
sudo apt-get install bc
sudo apt-get install jq

### Install bashbot
Clone the repository:
```
git clone --recursive https://github.com/mavnezz/telegram-bot-bash
```

Create a file called token and paste the telegram token in there.
Then start editing the commands.

### Receive data
You can read incoming data using the following variables:

* ```$MESSAGE```: Incoming messages
* ```$MESSAGE[ID]```: ID of incoming message
* ```$CAPTION```: Captions
* ```$USER```: This array contains the First name, last name, username and user id of the sender of the current message.
 * ```${USER[ID]}```: User id
 * ```${USER[FIRST_NAME]}```: User's first name
 * ```${USER[LAST_NAME]}```: User's last name
 * ```${USER[USERNAME]}```: Username
* ```$CHAT```: This array contains the First name, last name, username, title and user id of the chat of the current message.
 * ```${CHAT[ID]}```: Chat id
 * ```${CHAT[FIRST_NAME]}```: Chat's first name
 * ```${CHAT[LAST_NAME]}```: Chat's last name
 * ```${CHAT[USERNAME]}```: Username
 * ```${CHAT[TITLE]}```: Title
 * ```${CHAT[TYPE]}```: Type
 * ```${CHAT[ALL_MEMBERS_ARE_ADMINISTRATORS]}```: All members are administrators (true if true)
* ```$URLS```: This array contains documents, audio files, stickers, voice recordings and stickers stored in the form of URLs.
 * ```${URLS[AUDIO]}```: Audio files
 * ```${URLS[VIDEO]}```: Videos
 * ```${URLS[PHOTO]}```: Photos (maximum quality)
 * ```${URLS[VOICE]}```: Voice recordings
 * ```${URLS[STICKER]}```: Stickers
 * ```${URLS[DOCUMENT]}```: Any other file
* ```$CONTACT```: This array contains info about contacts sent in a chat.
 * ```${CONTACT[NUMBER]}```: Phone number
 * ```${CONTACT[FIRST_NAME]}```: First name
 * ```${CONTACT[LAST_NAME]}```: Last name
 * ```${CONTACT[ID]}```: User id
* ```$LOCATION```: This array contains info about locations sent in a chat.
 * ```${LOCATION[LONGITUDE]}```: Longitude
 * ```${LOCATION[LATITUDE]}```: Latitude
