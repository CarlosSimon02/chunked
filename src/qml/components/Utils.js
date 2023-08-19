function setColorAlpha(color, alpha) {
    return Qt.hsla(color.hslHue, color.hslSaturation, color.hslLightness, alpha)
}

function getTimeFrame(startDateTime, endDateTime) {
    let difference = endDateTime - starttDateTime
    let formattedDifference = ""
    let valuesPerUnit = [
            difference % 31556926000, //year
            (difference % 31556926000) % 604800000, //weeks
            ((difference % 31556926000) % 604800000) % 86400000, // days
            (((difference % 31556926000) % 604800000) % 86400000) % 3600000, //hours
            ((((difference % 31556926000) % 604800000) % 86400000) % 3600000) % 60000, //minutes
            (((((difference % 31556926000) % 604800000) % 86400000) % 3600000) % 60000) % 1000,  //seconds
        ]
    let units = ["y", "w", "d", "h", "m", "s"]

    for(let i = 0; i < units.length; i++) {
        if(valuesPerUnit[i]) {
            formattedDifference += valuesPerUnit[i].toString() + units[i].toString

            if(i+1 < units.length && valuesPerUnit[i+1]) {
                formattedDifference += " " + valuesPerUnit[i+1].toString() + units[i+1].toString
            }
            return formattedDifference
        }
    }

    return "0 time"
}
