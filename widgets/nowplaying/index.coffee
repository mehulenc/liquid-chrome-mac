# ==============================================================================
# Liquid Chrome - Übersicht Now Playing Widget
# ==============================================================================
# A highly specific crossover between Frutiger Aero (aquatic, glass, glow) and
# Gen X Soft Club (sterile minimalism, Y2K techno translucency, sharp geometry).
# Displays current Apple Music or Spotify metadata, live track progress,
# and extracts album art dynamically.
# ==============================================================================

# Command to extract player details and save Apple Music artwork to local dir
command: "osascript ./liquid-chrome-nowplaying/get_music_info.applescript"
updateSpeed: 2000

# Render DOM structure
render: (output) ->
  """
  <div class="now-playing-panel">
    <div class="meta-container">
      <div class="artwork-container">
        <img class="artwork" src="" onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" onload="this.style.display='block'; this.nextElementSibling.style.display='none';" />
        <div class="artwork-placeholder">♫</div>
      </div>
      <div class="text-container">
        <div class="title">--</div>
        <div class="artist">--</div>
        <div class="album">--</div>
      </div>
    </div>
    <div class="progress-outer">
      <div class="progress-inner"></div>
    </div>
  </div>
  """

# Update metadata, album art source, and live progress bar width
update: (output, domEl) ->
  [source, title, artist, album, art, pos, dur] = output.trim().split('|')
  
  if source is 'None' or not title
    $(domEl).hide()
    return
    
  $(domEl).show()
  $(domEl).find('.title').text(title)
  $(domEl).find('.artist').text(artist)
  $(domEl).find('.album').text(album)
  
  # Calculate track progress percentage
  posNum = parseFloat(pos) or 0
  durNum = parseFloat(dur) or 1
  pct = (posNum / durNum) * 100
  $(domEl).find('.progress-inner').css('width', "#{pct}%")
  
  # Set artwork image source
  if source is 'Spotify'
    $(domEl).find('.artwork').attr('src', art)
  else if source is 'Music' and art isnt 'none'
    # Append timestamp to bust browser image cache
    $(domEl).find('.artwork').attr('src', "./liquid-chrome-nowplaying/music_cover.jpg?t=#{Date.now()}")
  else
    $(domEl).find('.artwork').removeAttr('src')

# CSS styling adhering to the Liquid Chrome glassmorphism principles
style: """
  position: absolute;
  top: 27%;
  left: 1%;
  right: auto;
  transform: translateZ(0);
  margin: 0;
  padding: 0;

  .now-playing-panel {
    background: rgba(11, 16, 33, 0.45);
    backdrop-filter: blur(24px) saturate(150%);
    -webkit-backdrop-filter: blur(24px) saturate(150%);
    
    /* Metallic Borders */
    border: 1px solid rgba(255, 255, 255, 0.25);
    border-top: 1px solid rgba(255, 255, 255, 0.4);
    
    /* Bioluminescent Glow */
    box-shadow: 0 8px 32px 0 rgba(0, 255, 255, 0.15);
    
    border-radius: 16px;
    width: 280px;
    height: 130px;
    color: #FFFFFF;
    font-family: "Helvetica Neue", Helvetica, sans-serif;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 0 20px;
  }

  .meta-container {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
  }

  /* Album Art & Glass Frame */
  .artwork-container {
    width: 64px;
    height: 64px;
    border-radius: 8px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    overflow: hidden;
    background: rgba(11, 16, 33, 0.6);
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    box-shadow: 0 0 12px rgba(0, 255, 255, 0.15);
    flex-shrink: 0;
  }

  .artwork {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: none;
  }

  .artwork-placeholder {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
    color: #00FFFF;
    text-shadow: 0 0 8px rgba(0, 255, 255, 0.5);
    width: 100%;
    height: 100%;
    font-family: sans-serif;
  }

  /* Metadata Text Settings */
  .text-container {
    margin-left: 16px;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    justify-content: center;
    flex-grow: 1;
  }

  .title {
    font-size: 13px;
    font-weight: 700;
    color: #FFFFFF;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    letter-spacing: 0.5px;
  }

  .artist {
    font-size: 11px;
    font-weight: 400;
    color: #A0A5B5; /* Muted Silver-Blue */
    margin-top: 4px;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
  }

  .album {
    font-family: "SF Mono", "JetBrains Mono", monospace;
    font-size: 9px;
    color: rgba(160, 165, 181, 0.6);
    margin-top: 4px;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  /* Progress Bar styling */
  .progress-outer {
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.12);
    height: 6px;
    border-radius: 3px;
    overflow: hidden;
    padding: 1px;
    box-sizing: border-box;
  }

  .progress-inner {
    height: 100%;
    border-radius: 2px;
    width: 0%;
    background: linear-gradient(90deg, #00FFFF, #39FF14);
    box-shadow: 0 0 6px rgba(0, 255, 255, 0.4);
    transition: width 0.3s linear;
  }
"""
