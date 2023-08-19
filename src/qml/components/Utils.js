function setColorAlpha(color, alpha) {
    return Qt.hsla(color.hslHue, color.hslSaturation, color.hslLightness, alpha)
}

function getTimeFrame(startDateTime, endDateTime) {
    let difference = endDateTime - startDateTime
    let formattedDifference = ""
    let valuesPerUnit = [
            parseInt(difference / 31556926000), //year
            parseInt((difference % 31556926000) / 604800000), //weeks
            parseInt(((difference % 31556926000) % 604800000) / 86400000), // days
            parseInt((((difference % 31556926000) % 604800000) % 86400000) / 3600000), //hours
            parseInt(((((difference % 31556926000) % 604800000) % 86400000) % 3600000) / 60000), //minutes
            parseInt((((((difference % 31556926000) % 604800000) % 86400000) % 3600000) % 60000) / 1000)  //seconds
        ]
    let units = ["y", "w", "d", "h", "m", "s"]

    for(let i = 0; i < units.length; i++) {
        if(valuesPerUnit[i]) {
            formattedDifference += valuesPerUnit[i].toString() + units[i].toString()

            if(i+1 < units.length && valuesPerUnit[i+1]) {
                formattedDifference += " " + valuesPerUnit[i+1].toString() + units[i+1].toString()
            }
            return formattedDifference
        }
    }

    return "0 time"
}
