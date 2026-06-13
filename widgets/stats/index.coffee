# ==============================================================================
# Liquid Chrome - Übersicht CPU & RAM Monitor Widget
# ==============================================================================
# A highly specific crossover between Frutiger Aero (aquatic, glass, glow) and
# Gen X Soft Club (sterile minimalism, Y2K techno translucency, sharp geometry).
# ==============================================================================

# Command to extract CPU and RAM usage percentages from macOS
command: "cpu=$(top -l 1 | awk '/CPU usage/ {gsub(/%/, \"\", $3); printf \"%.0f\", $3}'); ram=$(vm_stat | awk '/Pages free/ {free=$3} /Pages active/ {active=$3} /Pages speculative/ {spec=$3} /Pages wired down/ {wired=$3} END {used=active+spec+wired; total=used+free; printf \"%.0f\", (used/total)*100}'); echo \"$cpu|$ram\""

# Update speed: refreshes every 5 seconds (5000ms)
updateSpeed: 5000

# Render minimalist HUD structured DOM
render: (output) ->
  """
  <div class="stats-panel">
    <div class="stat-group">
      <div class="stat-header">
        <span class="stat-title">SYS.CPU</span>
        <span class="stat-val cpu-val">--%</span>
      </div>
      <div class="bar-outer">
        <div class="bar-inner cpu-bar" style="width: 0%"></div>
      </div>
    </div>
    
    <div class="stat-group">
      <div class="stat-header">
        <span class="stat-title">SYS.RAM</span>
        <span class="stat-val ram-val">--%</span>
      </div>
      <div class="bar-outer">
        <div class="bar-inner ram-bar" style="width: 0%"></div>
      </div>
    </div>
  </div>
  """

# Update statistical values and transition the progress bar widths
update: (output, domEl) ->
  [cpu, ram] = output.trim().split('|')
  
  # Update CPU stats
  $(domEl).find('.cpu-val').text("#{cpu}%")
  $(domEl).find('.cpu-bar').css('width', "#{cpu}%")
  
  # Update RAM stats
  $(domEl).find('.ram-val').text("#{ram}%")
  $(domEl).find('.ram-bar').css('width', "#{ram}%")

# CSS rules matching the exact glassmorphism and metallic borders specifications
style: """
  position: absolute;
  top: 16%;
  left: 1%;
  right: auto;
  transform: translateZ(0);
  margin: 0;
  padding: 0;

  .stats-panel {
    background: rgba(11, 16, 33, 0.45);
    backdrop-filter: blur(24px) saturate(150%);
    -webkit-backdrop-filter: blur(24px) saturate(150%);
    
    /* Metallic Borders (catch the virtual light) */
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
    padding: 0 24px;
  }

  .stat-group {
    margin-bottom: 16px;
  }
  
  .stat-group:last-child {
    margin-bottom: 0;
  }

  .stat-header {
    display: flex;
    justify-content: space-between;
    align-items: baseline;
    margin-bottom: 6px;
  }

  .stat-title {
    font-family: "SF Mono", "JetBrains Mono", monospace;
    font-size: 11px;
    font-weight: 700;
    color: #A0A5B5; /* Muted Silver-Blue Secondary Text */
    letter-spacing: 1.5px;
  }

  .stat-val {
    font-family: "SF Mono", "JetBrains Mono", monospace;
    font-size: 12px;
    font-weight: 500;
    color: #00FFFF; /* Primary Accent 1 (Cyan) */
  }

  /* Thin Wireframe Progress Bars */
  .bar-outer {
    background: rgba(255, 255, 255, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.15);
    height: 8px;
    border-radius: 4px;
    overflow: hidden;
    padding: 1px;
    box-sizing: border-box;
  }

  .bar-inner {
    height: 100%;
    border-radius: 3px;
    width: 0%;
    background: linear-gradient(90deg, #00FFFF, #39FF14); /* Glow gradient from cyan to lime */
    box-shadow: 0 0 8px rgba(0, 255, 255, 0.5);
    transition: width 0.5s cubic-bezier(0.1, 0.8, 0.25, 1);
  }
"""
