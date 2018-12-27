'use strict';
const swipl             = require('swipl');
const readline          = require('readline');
const rl                = readline.createInterface(process.stdin, process.stdout);
const net               = require('net');
const { spawn }         = require("child_process");
const JsonFind          = require('json-find');
const googleSTT         = require('./googleSTT');

swipl.call('consult(main)');
//spawn('python3.7', ['prolog_interface_server.py']);
const mpg123 = spawn('mpg123', ['-R']);

var client;
var json_parser = [];

const loai_danh_tu = [
    'danhtu_ten',
    'danhtu_rieng',
    'danhtu_chicaycoi',
    'danhtu_chidovat',
    'danhtu_chiconvat',
    'danhtuchung_demduoc',
    'danhtu_khongdemduoc'
];

function match_regex(regex, text) {
    return text.match(regex)
}

function text_to_code(text) {
    let buffer_text = Buffer.from(text);
    var code_str = '';

    for (var i = 0; i < buffer_text.length; i++)
    {
        code_str += buffer_text[i].toString(16);
    }

    return code_str;
}

function code_to_text(code) {
    var buf = Buffer.alloc(code.length/2);
    for (var i = 0; i < code.length/2; i++)
    {
        var str = code[i*2] + code[i*2 + 1];
        buf[i] = parseInt(str, 16);
    }
    return buf.toString('utf8');
}

function strcode_to_strtext(strcode) {
    var split_words = strcode.split(" ");
    var strtext = '';

    for (var index in split_words)
    {
        strtext += code_to_text(split_words[index]) + ' ';
    }
    strtext = strtext.slice(0, -1);
    return strtext;
}

/**
 * Input command line.
 *
 * @param {string} prompt.
 * @param {callback}{string} handler.
 */
function promptInput(prompt, handler) {
    rl.question(prompt, input => {
        if (handler(input) !== false) {
            promptInput(prompt, handler);
        }
        else {
            rl.close();
        }
    });
}

function call_prolog(arg) {
    var pl_cmd_input = 'cau([';
    arg = arg.toLowerCase();
    console.log(arg);
    var split_words = arg.split(" ");
    for (var index in split_words)
    {
        pl_cmd_input += `'${text_to_code(split_words[index])}',`;
    }
    pl_cmd_input = pl_cmd_input.slice(0, -1);
    pl_cmd_input += "], [], P)";

    console.log(pl_cmd_input)
    client.write(pl_cmd_input);
}

/*
var obj = JSON.parse(result);
var keys = Object.keys(obj);
for (var i = 0; i < keys.length; i++) {
  console.log(obj[keys[i]]);
}
 */

function rm_lastnum(str) {
    var num = str.slice(-1, str.length);
    num = parseInt(num, 10);

    if (isNaN(num))
    {
        return str;
    }
    else
    {
        return str.slice(0, -1);
    }
}

// mpg123.stdin.setEncoding('utf8');
// mpg123.stdout.on('data', function(data) {
//     console.log(data.toString());
// });

function playing_music_skill(status, music_name)
{
    if (status === 'tắt') {
        mpg123.stdin.write('S\n');
    }

    if (status === 'mở') {
        if (music_name === 'nhạc') {
            mpg123.stdin.write(`L ./Sounds/Anh-Nang-Cua-Anh-Cho-Em-Den-Ngay-Mai-OST-Duc-Phuc.mp3\n`);
        }
        else {
            switch (music_name) {
                case 'lạc trôi':
                    console.log(music_name)
                    mpg123.stdin.write(`L ./Sounds/Lac-Troi-Son-Tung-M-TP.mp3\n`);
                    break;
                case 'duyên phận':
                    mpg123.stdin.write(`L ./Sounds/Duyen-Phan-Nhu-Quynh.mp3\n`);
                    break;
                case 'chạm đáy của nỗi đau':
                    mpg123.stdin.write(`L ./Sounds/Cham-Day-Noi-Dau-ERIK.mp3\n`);
                    break;
                case 'đừng như thói quen':
                    mpg123.stdin.write(`L ./Sounds/Dung-Nhu-Thoi-Quen-JayKii-Sara-Luu.mp3\n`);
                    break;
                case 'chắc ai đó sẽ về':
                    mpg123.stdin.write(`L ./Sounds/Chac-Ai-Do-Se-Ve-Son-Tung-M-TP.mp3\n`);
                    break;
            }
        }
    }
}

function find_json_in_key(JsonFind_in, key)
{
    var ret = JsonFind_in.checkKey(key);
    if (ret !== false)
        return ret;

    for (var i = 0; i < 10; i++)
    {
        ret = JsonFind_in.checkKey(`${key}${i}`);
        if (ret !== false)
            return ret;
    }
    return false;
}

// const find_json_parser_in_tmp = JsonFind(json_parser_in);
// console.log(find_json_in_key(find_json_parser_in_tmp, 'cum_danh_tu'));



function cau_cau_khien_processing(json_parser_in) {
    console.log(`------ cau_cau_khien_processing ------`);
    console.log(JSON.stringify(json_parser_in));

    const find_json_parser_in = JsonFind(json_parser_in);

    if (Object.keys(json_parser_in)[0] !== 'cau_cau_khien') return;

    const find_caucaukhien_xulytrungtam = JsonFind(find_json_parser_in.checkKey('caucaukhien_xulytrungtam'));

    var caucaukhien_xulytrungtam = find_json_parser_in.checkKey('caucaukhien_xulytrungtam');
    var caucaukhien_xulytrungtam_keys = Object.keys(caucaukhien_xulytrungtam);
    var danh_tu = '', dong_tu = '', mao_tu = '';

    console.log(caucaukhien_xulytrungtam_keys);

    if (caucaukhien_xulytrungtam_keys.length === 1)
    {
        if (rm_lastnum(caucaukhien_xulytrungtam_keys[0]) === 'cum_dong_tu')
        {
            const find_cum_dong_tu = JsonFind(find_json_parser_in.checkKey('cum_dong_tu'));

            const cumtu_dacbiet = find_cum_dong_tu.checkKey('cumtu_dacbiet');

            dong_tu = strcode_to_strtext(find_json_in_key(find_cum_dong_tu,'dongtu_chihanhdong'));

            if (cumtu_dacbiet != false)
            {
                mao_tu = strcode_to_strtext(find_json_in_key(find_cum_dong_tu,'maotu_dacbiet'));
                danh_tu = strcode_to_strtext(cumtu_dacbiet);
            }
            else
            {
                for (var i in loai_danh_tu)
                {
                    var danh_tu_tmp = find_json_in_key(find_cum_dong_tu,loai_danh_tu[i]);

                    if (danh_tu_tmp != false)
                    {
                        danh_tu = strcode_to_strtext(danh_tu_tmp);
                        break;
                    }
                }
            }
        }
    }
    else if(caucaukhien_xulytrungtam_keys.length === 3)
    {
        if (((rm_lastnum(caucaukhien_xulytrungtam_keys[0]) === 'giup') || (rm_lastnum(caucaukhien_xulytrungtam_keys[0]) === 'cho')) &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[1]) === 'cum_danh_tu' &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[2]) === 'cum_dong_tu')
        {
            const find_cum_dong_tu = JsonFind(find_json_parser_in.checkKey('cum_dong_tu'));

            const cumtu_dacbiet = find_cum_dong_tu.checkKey('cumtu_dacbiet');

            dong_tu = strcode_to_strtext(find_json_in_key(find_cum_dong_tu,'dongtu_chihanhdong'));

            if (cumtu_dacbiet != false)
            {
                mao_tu = strcode_to_strtext(find_json_in_key(find_cum_dong_tu,'maotu_dacbiet'));
                danh_tu = strcode_to_strtext(cumtu_dacbiet);
            }
            else
            {
                for (var i in loai_danh_tu)
                {
                    var danh_tu_tmp = find_json_in_key(find_cum_dong_tu,loai_danh_tu[i]);

                    if (danh_tu_tmp != false)
                    {
                        danh_tu = strcode_to_strtext(danh_tu_tmp);
                        break;
                    }
                }
            }
        }

    }

    else if(caucaukhien_xulytrungtam_keys.length === 4)
    {
        if (rm_lastnum(caucaukhien_xulytrungtam_keys[0]) === 'dong_tu' &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[1]) === 'cho' &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[2]) === 'cum_danh_tu' &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[3]) === 'cum_dong_tu')
        {
            const dong_tu_json = find_json_in_key(find_caucaukhien_xulytrungtam,'dong_tu');
            const find_dong_tu = JsonFind(dong_tu_json);
            const cum_dong_tu_json = find_json_in_key(find_caucaukhien_xulytrungtam,'cum_dong_tu');
            const find_cum_dong_tu = JsonFind(cum_dong_tu_json);
            const cumtu_dacbiet = find_cum_dong_tu.checkKey('cumtu_dacbiet');

            dong_tu = strcode_to_strtext(find_json_in_key(find_dong_tu,'dongtu_chihanhdong'));

            if (cumtu_dacbiet != false)
            {
                mao_tu = strcode_to_strtext(find_json_in_key(find_cum_dong_tu,'maotu_dacbiet'));
                danh_tu = strcode_to_strtext(cumtu_dacbiet);
            }
            else
            {
                for (var i in loai_danh_tu)
                {
                    var danh_tu_tmp = find_json_in_key(find_cum_dong_tu,loai_danh_tu[i]);

                    if (danh_tu_tmp != false)
                    {
                        danh_tu = strcode_to_strtext(danh_tu_tmp);
                        break;
                    }
                }
            }
        }
        else if (rm_lastnum(caucaukhien_xulytrungtam_keys[0]) === 'dong_tu' &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[1]) === 'cho' &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[2]) === 'cum_danh_tu' &&
            rm_lastnum(caucaukhien_xulytrungtam_keys[3]) === 'cum_danh_tu')
        {
            const dong_tu_json = find_json_in_key(find_caucaukhien_xulytrungtam,'dong_tu');
            const find_dong_tu = JsonFind(dong_tu_json);
            const cum_danh_tu_json = find_caucaukhien_xulytrungtam.checkKey('cum_danh_tu2');
            const find_cum_danh_tu = JsonFind(cum_danh_tu_json);
            const cumtu_dacbiet = find_cum_danh_tu.checkKey('cumtu_dacbiet');

            dong_tu = strcode_to_strtext(find_json_in_key(find_dong_tu,'dongtu_chihanhdong'));

            if (cumtu_dacbiet != false)
            {
                mao_tu = strcode_to_strtext(find_json_in_key(find_cum_danh_tu,'maotu_dacbiet'));
                danh_tu = strcode_to_strtext(cumtu_dacbiet);
            }
            else
            {
                for (var i in loai_danh_tu)
                {
                    var danh_tu_tmp = find_json_in_key(find_cum_danh_tu,loai_danh_tu[i]);

                    if (danh_tu_tmp != false)
                    {
                        danh_tu = strcode_to_strtext(danh_tu_tmp);
                        break;
                    }
                }
            }
        }
    }

    if (danh_tu === 'nhạc' || mao_tu === 'bài') {
        playing_music_skill(dong_tu, danh_tu);
    }
}

function processing_parser(json_parser_in) {
    var cumtu_dacbiet_shortest_parser = null;
    var cumtu_dacbiet_length = 10000;

    for (var index in json_parser_in)
    {
        const doc = JsonFind(json_parser_in[index]);
        // console.log(`${index} :===================>`);
        // console.log(JSON.stringify(json_parser_in[index]))

        if(doc.checkKey('cau_cau_khien') == false) continue;

        const cumtu_dacbiet_tmp = doc.checkKey('cumtu_dacbiet');
        if(cumtu_dacbiet_tmp != false)
        {
            if (cumtu_dacbiet_tmp.length < cumtu_dacbiet_length)
            {
                cumtu_dacbiet_length = cumtu_dacbiet_tmp.length;
                cumtu_dacbiet_shortest_parser = json_parser_in[index];
            }
        }
        else
        {
            cau_cau_khien_processing(json_parser_in[index]);
        }

    }

    if (cumtu_dacbiet_shortest_parser != null)
    {
        cau_cau_khien_processing(cumtu_dacbiet_shortest_parser);
    }
}

async function convert_valid_json(json_str) {
    function counting_words_in_json(json_str, word) {
        return new Promise(resolve => {
            const regex = /([a-z|_])+":/g;
            const words = match_regex(regex, json_str);
            var count = 0;
            for (var index in words)
            {
                words[index] = words[index].slice(0, -2);
                if (words[index] === word)
                {
                    count++;
                }
            }
            resolve(count);
        });
    }

    const regex = /([a-z|_])+":/g;
    const words = match_regex(regex, json_str);
    for (var index in words)
    {
        words[index] = words[index].slice(0, -2);
        const counting_words = await counting_words_in_json(json_str, words[index]);
        if (counting_words > 1)
        {
            for (var i = 0; i < counting_words; i++)
            {
                const regex = new RegExp(`\\b${words[index]}\\b`);
                json_str = json_str.replace(regex, `${words[index]}${i+1}`);
            }
        }
    }
    return json_str
}

setTimeout(async function() {
    var json_parser_queue = [];
    client = new net.Socket();
    client.connect(3344, '127.0.0.1', function() {
        console.log('Connected');
    });

    client.on('close', function() {
        console.log('Connection closed');
    });

    client.on('data', async function(data) {
        json_parser_queue.push(data)
    });

    function _getqueue() {
        return new Promise(resolve => {
            setTimeout(async () => {
                if (json_parser_queue.length > 0) {
                    var json_string = json_parser_queue.shift().toString('utf8');
                    json_string = json_string.replace(/'/g, "\"");
                    const check_Finish = json_string.slice(-6, json_string.length);

                    if( json_string.length > check_Finish.length)
                    {
                        if(check_Finish == 'Finish')
                        {
                            json_string = json_string.slice(0, -check_Finish.length);
                        }

                        json_string = await convert_valid_json(json_string);
                        json_parser.push(JSON.parse(json_string));
                    }

                    if(check_Finish == 'Finish')
                    {
                        var json_parser_tmp = json_parser;
                        json_parser = [];
                        processing_parser(json_parser_tmp);
                    }
                }
                resolve();
            }, 1);
        });
    }

    while (true) {
        await _getqueue();
    }
}, 300);

googleSTT.event().on('data', data => {
    call_prolog(data);
})

async function main() {
    const args = process.argv.slice(2);

    promptInput('Command > ', async input => {
        var command, arg;
        var index_str = input.indexOf(" ");

        if (index_str >= 0) {
            command = input.slice(0, index_str);
            arg = input.slice(index_str + 1, input.length);
        }
        else {
            command = input;
        }

        switch (command) {
            case 'r': /* Start recording */
                console.log("Begin Recording");
                googleSTT.start();
                break;

            case 's':
                console.log("Stop Recording");
                googleSTT.stop();
                break;

            case 'p:':
                call_prolog(arg);
                break;

            case 'exit':
            case 'quit':
            case 'q':
                return false;
        }
    });
}

/*
maika ơi mở bài lạc trôi đi

 */
main()