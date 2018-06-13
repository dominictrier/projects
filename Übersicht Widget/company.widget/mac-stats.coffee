command: "networksetup -getcomputername && ifconfig | grep 'inet ' | grep -v -m1 127.0.0.1 | awk -F' ' '{print $2}' && if nc -4 -z -w5 -G5 www.reddit.com 443 > /dev/null 2>&1 == 0; then echo 'avaiable'; else echo 'not available'; fi && netstat -nr | grep -m1 default | awk -F' ' '{print $2}' && system_profiler SPNetworkLocationDataType | grep -A999 'Active Location: Yes' | grep -E -A999 'Type: Ethernet|IEEE80211' |grep -A999 'IPv4' | grep -m1 'Configuration Method:' | awk -F': ' '{print $2}'"


refreshFrequency: '1m'

style: """
  // Change bar height
  bar-height = 6px

  // Align contents left or right
  widget-align = left

  // Position this where you want
  top 10px
  left 10px

  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .3)
  padding 10px 20px 5px
  border-radius 5px

  .container
    width: 250px
    text-align: widget-align
    position: relative
    clear: both

  .widget-title
    text-align: widget-align

  .stats-container
    margin-bottom 10px
    border-collapse collapse

  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align

  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight bold

  .label
    font-size 8px
    text-transform uppercase
    font-weight bold

  .bar-container
    width: 100%
    height: bar-height
    border-radius: bar-height
    float: widget-align
    clear: both
    background: rgba(#fff, .5)
    position: absolute
    margin-bottom: 5px

  .bar
    height: bar-height
    float: widget-align
    transition: width .2s ease-in-out

  .bar:first-child
    if widget-align == left
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .bar:last-child
    if widget-align == right
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .bar-inactive
    background: rgba(#0bf, .5)

  .bar-active
    background: rgba(#fc0, .5)

  .bar-wired
    background: rgba(#c00, .5)
"""


render: -> """
  <div class="container">
    <div class="widget-title">Servicetag - Serialnumber</div>
    <table class="stats-container" width="0%">
      <tr>
        <td class="stat"><span class="tag"></span></td>
        <td class="stat"><span class="dash"></span></td>
        <td class="stat"><span class="serial"></span></td>
      </tr>
    </table>
    <div class="widget-title">IP address (Gateway | Config)</div>
    <table class="stats-container" width="75%">
      <tr>
        <td class="stat"><span class="ip"></span></td>
        <td class="stat"><span class="gateway"></span></td>
      </tr>
    </table>
    <div class="widget-title">Internet connectivity</div>
    <table class="stats-container" width="100%">
      <tr>
        <td class="stat"><span class="internet"></span></td>
      </tr>
    </table>
  </div>
"""

update: (output, domEl) ->


   data = output.split "\n"
   srvtag = data[0].split("-")[0]
   macname = data[0].split("-")[1]
   ip = data[1]
   inetup= data[2]
   dash= "-"
   gw= "( " + data[3].split(".")[3] + " | " + data[4]+ " )"
   
   
 
   $(domEl).find(".tag").text srvtag
   $(domEl).find(".serial").text macname
   $(domEl).find(".ip").text ip
   $(domEl).find(".internet").text inetup
   $(domEl).find(".dash").text dash
   $(domEl).find(".gateway").text gw
