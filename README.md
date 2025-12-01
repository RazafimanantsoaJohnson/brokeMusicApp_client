# brokemusicapp
    BrokeMusicApp is an app which lets its users stream music online for free.
    This repo is for the client part of the app.

## Why this name?
    I just thought of a name for a music streaming app for broke people so there it was XD.

## Why use it when spotify already exists?
    Well, free Spotify don't let its users fully control their listening; whether you don't get to play the song you're interested in right away or the next song in your listening queue is completely random.
    It is particularly annoying when you're trying to listen to an album (where the artist wrote songs in a specific order to trigger specific feelings or tell a story).

## How it works?
The server repo explains it in more detail [link here](https://github.com/RazafimanantsoaJohnson/brokemusicapp/)
The client will consume the APIs exposed by the server to get album data and stream audio files whether from the youtube streaming url (for non-downloaded files yet); and directly from the server if the audio file is already processed.
The client will call for the tracks' data:
 - if it finds a valid 'file_url' in the server's response, it will form the streaming api url and stream it directly from the server.
 - if it finds a youtubeUrl it will try to stream the audio from that url
 - if both checks didn't work it will send a request to the server with a *'retry'* parameter; the server will then evaluate if the retry is valid by checking the file path and if the youtube url is still responding well. If both are not conclusive, the server will refetch the youtube streaming url for the specific track and send it to the client synchronously.

## Screens:
 ## Signin and Signup screen 
  The authentication will cache the refresh token in disk if successful.
  We will then lookup to that refresh token each time the app is launched to get an access token and get directly to the Home screen.
  The user is redirected to the Signin screen if the check and/or authentication by refresh token is unsuccessful. 
 ## Home Screen
  It will show the user a list of his recently visited albums.
  ![home screen](https://github.com/RazafimanantsoaJohnson/brokeMusicApp_client/blob/main/illustrations/home_screen_illustration.png)
 ## Search Screen
  ![search_screen](https://github.com/RazafimanantsoaJohnson/brokeMusicApp_client/blob/main/illustrations/search_screen_illustration.png)
 ## Album Screen
  A screen which will show the list of tracks within the album. 
  The user can play the whole album by tapping the 'play' button or by clicking to the song he wants.
  ![album_screen](https://github.com/RazafimanantsoaJohnson/brokeMusicApp_client/blob/main/illustrations/album_screen_illustration_with_player.png)
 ## Player Screen
  A screen which helps the user have more control over the songs being played, accessible through the persistent button showing the currently played song.
  ![player_screen](https://github.com/RazafimanantsoaJohnson/brokeMusicApp_client/blob/main/illustrations/player_screen_illustration.png)

 ## Gif illustration
  ![illustration](https://github.com/RazafimanantsoaJohnson/brokeMusicApp_client/blob/main/illustrations/switch_song_illustration.gif)
