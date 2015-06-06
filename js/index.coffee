class BodyForLifeTimerViewModel
    constructor: ->
        @timerGoing = ko.observable(false)
        @startStopText = ko.computed(@_startStopText, @)
        @timerCount = ko.observable(1200) # seconds left in workout
        @timerText = ko.computed(@_timerText, @)
        @intensityText = ko.computed(@_intensityText, @)

        @_secondIntervalHandle = setInterval(@_tick, 1000)

    _startStopText: ->
        if @timerGoing()
            return 'Stop'
        else
            return 'Start'

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

    _intensityText: ->
        intervalIntensities = [
            5 # last minute
            10
            9
            8
            7
            9
            8
            7
            9
            8
            7
            9
            8
            7
            9
            8
            7
            6
            5
            5 # first minute
        ]
        
        interval = Math.floor(@timerCount() / 60)
        intensity = intervalIntensities[interval]
        
        return intensity
        
    # called every second
    _tick: =>
        if @timerGoing()
            @timerCount(@timerCount()-1)

            # new interval
            if @timerCount() % 60 is 0
                @_playIntervalChangeSound()

    addTime: ->
        @timerCount(@timerCount()+10)

    subtractTime: ->
        @timerCount(@timerCount()-10)

    # play a sound when going between interval intensities
    _playIntervalChangeSound: ->
        
$(document).ready(->
    timerVM = new BodyForLifeTimerViewModel()
    
    ko.applyBindings(timerVM)
)
