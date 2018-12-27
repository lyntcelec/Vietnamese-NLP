'use strict';
const speech            = require('@google-cloud/speech');
const current_path      = require('path').dirname(require.main.filename);
const recordingStream   = require('node-record-lpcm16');
const event             = require('events');

var interfunc = {};
module.exports = interfunc;

process.env['GOOGLE_APPLICATION_CREDENTIALS'] = `${current_path}/credentials.json`;
/* Creates a client */
const speech_client = new speech.SpeechClient();

var mic_options = {
    encoding: 'LINEAR16',
    sampleRateHertz: 16000,
    languageCode: 'vi-VN'// 'vi-VN' 'en-US'
}

const rec_event = new event();

interfunc.event = function googleSTT() {
    return rec_event;
}

interfunc.start = function startStream() {
    const request = {
        config: {
            encoding: mic_options.encoding,
            sampleRateHertz: mic_options.sampleRateHertz,
            languageCode: mic_options.languageCode,
        },
        interimResults: false, /* If you want interim results, set this to true */
    };

    /* Create a recognize stream */
    const recognizeStream = speech_client
        .streamingRecognize(request)
        .on('error', (err) => {
            //console.log(err);
        })
        .on('data', data => {
            rec_event.emit('data', data.results[0] && data.results[0].alternatives[0]
                ? data.results[0].alternatives[0].transcript
                : '')
        })
        .on('end', () => {
        })

    var micStream = recordingStream
        .start({
            sampleRateHertz: mic_options.sampleRateHertz,
            threshold: 0,
            // Other options, see https://www.npmjs.com/package/node-record-lpcm16#options
            verbose: false,
            recordProgram: 'rec', // Try also "arecord" or "sox"
            silence: '0',
        })
        .on('error', (err) => {
            console.log(err);
        })
        .on('end', () => {
        })

    micStream.pipe(recognizeStream);
}

interfunc.stop = function stopStream() {
    recordingStream.stop();
}