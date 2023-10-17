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

function getStatus(startDateTime, endDateTime, isCompleted) {
    let dateNow = new Date()

    if(dateNow < startDateTime)
        return 0
    else if(dateNow >= startDateTime && dateNow < endDateTime)
        return 1
    else if(dateNow > endDateTime) {
        if(isCompleted)
            return 2
        else
            return 3
    }
}

function getSectionTitleDate(dateTime) {
    let dateNow = new Date()

    if(dateTime.getFullYear() === dateNow.getFullYear()) {
        if(dateTime.getMonth() === dateNow.getMonth()) {
            if(dateTime.getDate() === dateNow.getDate()) return "Today"
            else if(dateTime.getDate() === dateNow.getDate() + 1) return "Tomorrow"
            else if(dateTime.getDate() === dateNow.getDate() - 1) return "Yesterday"
        }
        return dateTime.toLocaleString(Qt.locale(),"MMM dd")
    }
    else return dateTime.toLocaleString(Qt.locale(),"yyyy MMM dd")
}

function getEndDateTime(startDateTime, duration) {
    let endDateTime = startDateTime
    endDateTime.setMinutes(endDateTime.getMinutes() + duration)
    return endDateTime
}
