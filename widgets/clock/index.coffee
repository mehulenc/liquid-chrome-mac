# ==============================================================================
# Liquid Chrome - Übersicht Minimal Desktop Clock Widget
# ==============================================================================
# A highly specific crossover between Frutiger Aero (aquatic, glass, glow) and
# Gen X Soft Club (sterile minimalism, Y2K techno translucency, sharp geometry).
# ==============================================================================

# Command to get formatted hours, minutes, am/pm, and full date details
command: "date +\"%I:%M %p|%A, %b %d\""

# Update speed: refreshes every 10 seconds (10000ms)
updateSpeed: 10000

# Render light-weight DOM structure
render: (output) ->
  [time, date] = output.split('|')
  """
  <div class="clock-panel">
    <div class="time">#{time}</div>
    <div class="date">#{date}</div>
  </div>
  """

# Update time and date dynamically
update: (output, domEl) ->
  [time, date] = output.split('|')
  $(domEl).find('.time').text(time)
  $(domEl).find('.date').text(date)

# CSS styling utilizing the precise Liquid Chrome guidelines
style: """
  position: absolute;
  top: 5%;
  left: 1%;
  right: auto;
  transform: translateZ(0);
  margin: 0;
  padding: 0;

  .clock-panel {
    background: rgba(11, 16, 33, 0.45);
    backdrop-filter: blur(24px) saturate(150%);
    -webkit-backdrop-filter: blur(24px) saturate(150%);
    
    /* Metallic Borders (Silver metallic edge catching virtual light) */
    border: 1px solid rgba(255, 255, 255, 0.25);
    border-top: 1px solid rgba(255, 255, 255, 0.4);
    
    /* Bioluminescent Glow */
    box-shadow: 0 8px 32px 0 rgba(0, 255, 255, 0.15);
    
    border-radius: 16px;
    color: #FFFFFF;
    font-family: "Helvetica Neue", Helvetica, sans-serif;
    width: 280px;
    height: 130px;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .time {
    /* thin/light weights typography */
    font-size: 56px;
    font-weight: 100;
    letter-spacing: -2px;
    color: #00FFFF; /* Aquatic Cyan Accent */
    margin: 0;
    padding: 0;
    line-height: 1.1;
  }

  .date {
    font-size: 13px;
    font-weight: 400;
    letter-spacing: 2px;
    color: #A0A5B5; /* Muted Silver-Blue Secondary Text */
    text-transform: uppercase;
    margin-top: 8px;
    padding: 0;
  }
"""
