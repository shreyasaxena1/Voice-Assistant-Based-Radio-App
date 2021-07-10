// Use this sample to create your own voice commands
intent('hello world', p => {
    p.play('(hello|hi there)');
});

intent('(play)', 'play (the|) (some|) music', p => {
    p.play({ "command": "play" });
    p.play("(Playing Now|on it|Doing it|enjoy your music)");
});

intent('stop (it|)', 'stop (the|) music', 'pause (it|)', 'pause (the|) music', p => {
     p.play({ "command": "stop" });
    p.play("(Stopping Now|on it|Doing it)");
});

intent('(play|) next (channel|fm|radio|)', p => {
    p.play({ "command": "next" });
    p.play("(Playing next|on it|Doing it|sure)");
});

intent('(play|) previous (channel|fm|radio|)', p => {
    p.play({ "command": "prev" });
    p.play("(Playing prev|on it|Doing it|sure)");
});

intent('play $(CHANNEL* (.*)) fm', p => {
    let channel = project.radios.filter(x => x.name.toLowerCase() === p.CHANNEL.value.toLowerCase())[0];
    try {
        p.play({ "command": "play_channel", "id": channel.id });
        p.play('(Playing Now|on it|enjoy your music|Doing it)');
    } catch (err) {
        console.log("Can't play");
        p.play("I cannot play this");
    }
});


intent('play (some|) $(CATEGORY* (.*)) music', p => {
    let channel = project.radios.filter(x => x.category.toLowerCase() === p.CATEGORY.value.toLowerCase())[0];
    try {
        p.play({ 'command': 'play_channel', 'id': channel.id });
        p.play('(playing now|On it|enjoy your music)');
    } catch (error) {
        console.log("Can't play");
        p.play('I could not find this genre');
    }

});

