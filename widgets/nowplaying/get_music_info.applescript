tell application "System Events"
    set musicRunning to (name of every process) contains "Music"
    set spotifyRunning to (name of every process) contains "Spotify"
end tell

set rawData to ""
set hasArt to false
set tName to ""
set tArtist to ""
set tAlbum to ""
set tArt to ""
set pos to 0
set dur to 1
set sourcePlayer to "None"

if spotifyRunning then
    tell application "Spotify"
        if player state is playing then
            set tName to name of current track
            set tArtist to artist of current track
            set tAlbum to album of current track
            set tArt to artwork url of current track
            set pos to player position
            set dur to (duration of current track) / 1000
            set sourcePlayer to "Spotify"
        end if
    end tell
end if

if musicRunning and sourcePlayer is "None" then
    tell application "Music"
        if player state is playing then
            set tName to name of current track
            set tArtist to artist of current track
            set tAlbum to album of current track
            set hasArt to (count of artworks of current track) > 0
            if hasArt then
                set rawData to raw data of artwork 1 of current track
                set tArt to "./liquid-chrome-nowplaying/music_cover.jpg"
            else
                set tArt to "none"
            end if
            set pos to player position
            set dur to duration of current track
            set sourcePlayer to "Music"
        end if
    end tell
end if

if hasArt and sourcePlayer is "Music" then
    try
        set fileRef to (open for access POSIX file "liquid-chrome-nowplaying/music_cover.jpg" with write permission)
        set eof fileRef to 0
        write rawData to fileRef
        close access fileRef
    on error err
        set tArt to "none"
    end try
end if

return sourcePlayer & "|" & tName & "|" & tArtist & "|" & tAlbum & "|" & tArt & "|" & pos & "|" & dur
