class BodyForLifeTimerViewModel
    TWENTY_MINUTES_IN_SECONDS = 1200
    
    constructor: ->
        @timerGoing = ko.observable(false)
        @startStopText = ko.computed(@_startStopText, @)
        @startStopIcon = ko.computed(@_startStopIcon, @)
        @timerCount = ko.observable(TWENTY_MINUTES_IN_SECONDS) # seconds left in workout
        @timerText = ko.computed(@_timerText, @)
        @intensityText = ko.computed(@_intensityText, @)
        @intensityGraph = ko.computed(@_intensityGraph, @)

        @_secondIntervalHandle = setInterval(@_tick, 1000)

    _startStopText: ->
        # NOTE: adding space character to space out icon and button text
        if @timerGoing()
            return ' Stop'
        else
            return ' Start'

    _startStopIcon: ->
        if @timerGoing()
            return 'fi-stop'
        else
            return 'fi-play'

    toggleTimer: (vm, event) ->
        going = @timerGoing()

        # toggle it
        @timerGoing(not going)

    _timerText: ->
        seconds = @timerCount()
        minutes = Math.floor(seconds / 60)
        seconds = seconds % 60

        # pad seconds
        if seconds < 10
            seconds = "0#{seconds}"
        
        return "#{minutes}:#{seconds}"

    # given a time in seconds return the intensity
    timeToIntensity: ->


    intervalIntensities = [
        5 # last minute
        10
        9
        8
        7
        6
        9
        8
        7
        6
        9
        8
        7
        6
        9
        8
        7
        6
        5
        5 # first minute
    ]

    # returns the current interval
    _interval: ->
        return Math.floor(@timerCount() / 60)

    _intensityText: ->
        interval = @_interval()

        # make sure it fits in range
        interval = Math.max(0, interval)
        interval = Math.min(intervalIntensities.length-1, interval)
        
        intensity = intervalIntensities[interval]
        
        return intensity

    _intensityGraph: ->
        backwards = intervalIntensities.slice(0)

        for i in [0..backwards.length-1]
            if i is @_interval() or i is 20
                backwards[i] = '<b><u>' + backwards[i] + '</u></b>'

        backwards.reverse()

        return backwards.join(' ')
        
    # called every second
    _tick: =>
        if @timerGoing()
            @timerCount(@timerCount()-1)

            # new interval
            if @timerCount() % 60 is 0
                @_playIntervalChangeSound()

    addTime: ->
        newCount = Math.min(TWENTY_MINUTES_IN_SECONDS, @timerCount() + 30)
        @timerCount(newCount)

    subtractTime: ->
        newCount = Math.max(0, @timerCount() - 30)
        @timerCount(newCount)

    # play a sound when going between interval intensities
    _playIntervalChangeSound: ->
        
$(document).ready(->
    timerVM = new BodyForLifeTimerViewModel()
    
    ko.applyBindings(timerVM)
)
