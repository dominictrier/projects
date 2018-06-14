command: "macstat.widget/values.sh"

# refresh every minute
refreshFrequency: '1m'

style: """
  // Widget Alignment
  widget-align = left

  // Distance to Edge
  top 10px
  left 10px

  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .3)
  padding 10px 20px 0px
  border-radius 10px
  -webkit-backdrop-filter: blur(2px)

  // complete Container
  .container
    width: 230px
    text-align: widget-align
    position: relative
    clear: both

  // Value Containers
  .stats-container
    margin-bottom 10px
    border-collapse collapse
  
  // Values
  td
    font-size: 14px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align
    letter-spacing 1px
  
  // Values Title
  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight bold
"""


render: -> """
  <div class="container">
    <div class="widget-title">Servicetag - Serialnumber</div>
    <table class="stats-container">
      <tr>
        <td class="stat"><span class="hostname"></span></td>
      </tr>
    </table>
    <div class="widget-title">IP address ( Gateway | Config Type )</div>
    <table class="stats-container">
      <tr>
        <td class="stat"><span class="ip"></span></td>
        <td class="stat"><span class="gateway"></span></td>
      </tr>
    </table>
    <div class="widget-title">Internet connectivity</div>
    <table class="stats-container">
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
   hostname = srvtag + " - " + macname
   ip = data[1]
   inetup= data[2]
   dash= "-"
   gw= "( " + data[3].split(".")[3] + " | " + data[4]+ " )"
   
   
 
   $(domEl).find(".hostname").text hostname
   $(domEl).find(".ip").text ip
   $(domEl).find(".internet").text inetup
   $(domEl).find(".gateway").text gw
