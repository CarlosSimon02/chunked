function getTimeStatus(startDateTime, endDateTime, isCompleted) {
    let dateNow = new Date()

    if(dateNow < startDateTime)
        return "Starts on " + startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
    else if(dateNow >= startDateTime && dateNow < endDateTime)
        return getTimeFrame(dateNow, endDateTime) + " remaining"
    else if(dateNow > endDateTime) {
        if(isCompleted)
            return "Ended on " + endDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
        else {
            return getTimeFrame(endDateTime, dateNow) + " overdue"
        }
    }
}

function getTimeFrame(startDateTime, endDateTime, isCompleted) {
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

function getColorStatus(startDateTime, endDateTime, isCompleted) {
    if(dateNow < startDateTime)
        return "Starts on " + startDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
    else if(dateNow >= startDateTime && dateNow < endDateTime)
        return getTimeFrame(dateNow, endDateTime) + " remaining"
    else if(dateNow > endDateTime) {
        if(isCompleted)
            return "Ended on " + endDateTime.toLocaleString(Qt.locale(),"dd MMM yyyy hh:mm AP")
        else {
            return getTimeFrame(dateNow, endDateTime) + " overdue"
        }
    }
}
