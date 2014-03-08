function play2() {
    onYouTubePlayerReady(playerid)
}

function stop(playerid){
    thisplayer=document.getElementById(playerid);
    thisplayer.stopVideo();
    alert(thisplayer.getPlayerState());
}

function ShowVidStop(divid, playerid){
    thisplayer=document.getElementById(playerid);
    if(document.getElementById(divid).style.display == 'none'){
        document.getElementById(divid).style.display = 'inline';
        thisplayer.playVideo();
    }else{
        document.getElementById(divid).style.display = 'none';
        thisplayer.pauseVideo();
    }
}

function ShowVid(divid){
    if(document.getElementById(divid).style.display == 'none'){
        document.getElementById(divid).style.display = 'inline';
    }else{
        document.getElementById(divid).style.display = 'none';
    }
}

function updateHTML(elmId, value) {
    document.getElementById(elmId).innerHTML = value;
}

function setytLibplayerState(newState) {
    updateHTML("playerstate", newState);
}

function onYouTubePlayerReady(playerId) {
    ytLibplayer = document.getElementById("myytLibplayer");
    setInterval(updateytLibplayerInfo, 250);
    updateytLibplayerInfo();
    ytLibplayer.addEventListener("onStateChange", "onytLibplayerStateChange");
    ytLibplayer.addEventListener("onError", "onPlayerError");
    ytLibplayer.playVideo();
}

function onytplayerStateChange(newState) {
    alert("Player's new state: " + newState);
}

function onytLibplayerStateChange(newState) {
    setytLibplayerState(newState);
}

function onPlayerError(errorCode) {
    alert("An error occurred: "+ errorCode);
}

function updateytLibplayerInfo() {
    updateHTML("bytesloaded", getBytesLoaded());
    updateHTML("bytestotal", getBytesTotal());
    updateHTML("videoduration", getDuration());
    updateHTML("videotime", getCurrentTime());
    updateHTML("startbytes", getStartBytes());
}

// functions for the api calls
function play() {
    if (ytLibplayer) {
        ytLibplayer.playVideo();
    }
}

function pause() {
    if (ytLibplayer) {
        ytLibplayer.pauseVideo();
    }
}

function Allstop() {
    if (ytLibplayer) {
        ytLibplayer.stopVideo();
    }
}

function getPlayerState() {
    if (ytLibplayer) {
        return ytLibplayer.getPlayerState();
    }
}

function seekTo(seconds) {
    if (ytLibplayer) {
        ytLibplayer.seekTo(seconds, true);
    }
}

function getBytesLoaded() {
    if (ytLibplayer) {
        return ytLibplayer.getVideoBytesLoaded();
    }
}

function getBytesTotal() {
    if (ytLibplayer) {
        return ytLibplayer.getVideoBytesTotal();
    }
}

function getCurrentTime() {
    if (ytLibplayer) {
        return ytLibplayer.getCurrentTime();
    }
}

function getDuration() {
    if (ytLibplayer) {
        return ytLibplayer.getDuration();
    }
}

function getStartBytes() {
    if (ytLibplayer) {
        return ytLibplayer.getVideoStartBytes();
    }
}

function mute() {
    if (ytLibplayer) {
        ytLibplayer.mute();
    }
}

function unMute() {
    if (ytLibplayer) {
        ytLibplayer.unMute();
    }
}